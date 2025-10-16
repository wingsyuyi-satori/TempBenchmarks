
; SMT-LIB2 script for JWT and API key validation
(set-logic QF_SLIA)

; Declare string constants
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)

; Common delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")

; JWT Validation Constraints
; JWT must have exactly 3 segments when split by dot
(assert (= (str.num_splits jwt dot) 3))

; ; Extract JWT segments
(define-const jwt_header String (str.split_at jwt dot 0))
(define-const jwt_payload String (str.split_at jwt dot 1))
(define-const jwt_signature String (str.split_at jwt dot 2))

; ; Header and payload must be base64 encoded (simplified check for length multiple of 4)
(assert (= (mod (str.len jwt_header) 4) 0))
(assert (= (mod (str.len jwt_payload) 4) 0))

; ; Signature must match expected value (simplified check)
(define-const expected_sig String (str.++ jwt_header dot jwt_payload secret))
(assert (str.contains jwt_signature expected_sig))

; API Key Validation Constraints
; API key must have either 2 segments (colon) or 3 segments (dash)
(assert (or 
 (= (str.num_splits api_key colon) 2)
 (= (str.num_splits api_key dash) 3)
))

; If API key has 2 segments (colon separated)
(define-const api_key_part1 String (str.split_at api_key colon 0))
(define-const api_key_part2 String (str.split_at api_key colon 1))
(assert (=> (= (str.num_splits api_key colon) 2)
 (and
 (= (str.len api_key_part1) 8) ; API key prefix length
 (= (str.len api_key_part2) 32) ; API key secret length
)
))

; If API key has 3 segments (dash separated)
(define-const api_key_comp1 String (str.split_at api_key dash 0))
(define-const api_key_comp2 String (str.split_at api_key dash 1))
(define-const api_key_comp3 String (str.split_at api_key dash 2))
(assert (=> (= (str.num_splits api_key dash) 3)
 (and
 (= (str.len api_key_comp1) 4) ; Component 1 length
 (= (str.len api_key_comp2) 4) ; Component 2 length
 (= (str.len api_key_comp3) 4) ; Component 3 length
 (str.is_digit api_key_comp3) ; Last component must be digits
)
))

; Additional constraints
; JWT and API key cannot be empty
(assert (> (str.len jwt) 0))
(assert (> (str.len api_key) 0))

; Secret must be at least 16 characters
(assert (>= (str.len secret) 16))

; Unsatisfiable case: API key cannot satisfy both formats simultaneously
(assert (not (and 
 (= (str.num_splits api_key colon) 2)
 (= (str.num_splits api_key dash) 3)
)))

(check-sat)
(exit)
(get-model)
