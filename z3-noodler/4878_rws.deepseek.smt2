; SMT-LIB2 script for JWT and API key validation with complex splits
(set-logic QF_SLIA)

; Declare string constants
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)
(declare-const auth_header String)

; Common delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")
(define-const underscore String "_")
(define-const space String " ")
(define-const comma String ",")

; JWT Validation Constraints with nested splits
; JWT must have exactly 3 segments when split by dot
(assert (= (str.num_splits jwt dot) 3))

; Extract JWT segments using multiple split methods
(define-const jwt_header String (str.split_at jwt dot 0))
(define-const jwt_payload String (str.split_at (str.split_rest jwt dot 1) dot 0))
(define-const jwt_signature String (str.split_rest (str.split_rest jwt dot 1) dot 1))

; Complex header validation with nested splits
(assert (= (mod (str.len jwt_header) 4) 0))
(assert (= (mod (str.len jwt_payload) 4) 0))

; Multi-level signature validation
(define-const header_payload String (str.++ jwt_header dot jwt_payload))
(define-const expected_sig_part1 String (str.split_at secret underscore 0))
(define-const expected_sig_part2 String (str.split_rest secret underscore 1))
(define-const expected_sig String (str.++ header_payload expected_sig_part1 expected_sig_part2))

(assert (str.contains jwt_signature (str.split_at expected_sig colon 0)))

; API Key Validation Constraints with complex format options
; API key can have 2 segments (colon), 3 segments (dash), or 4 segments (underscore)
(assert (or 
 (= (str.num_splits api_key colon) 2)
 (= (str.num_splits api_key dash) 3)
 (= (str.num_splits api_key underscore) 4)
))

; Complex API key parsing with nested splits
(define-const api_key_part1 String (str.split_at api_key colon 0))
(define-const api_key_part2 String (str.split_at (str.split_rest api_key colon 1) colon 0))

; Multi-format API key validation
(assert (=> (= (str.num_splits api_key colon) 2)
 (and
 (= (str.len (str.split_at api_key_part1 dash 0)) 4)
 (= (str.len (str.split_rest api_key_part1 dash 1)) 4)
 (= (str.len api_key_part2) 32)
 (str.contains (str.split_at api_key_part2 underscore 0) "key")
)))

; Three-segment dash format with additional splits
(define-const api_key_comp1 String (str.split_at api_key dash 0))
(define-const api_key_comp2 String (str.split_at (str.split_rest api_key dash 1) dash 0))
(define-const api_key_comp3 String (str.split_rest (str.split_rest api_key dash 1) dash 1))

(assert (=> (= (str.num_splits api_key dash) 3)
 (and
 (= (str.len api_key_comp1) 4)
 (= (str.len (str.split_at api_key_comp2 colon 0)) 2)
 (= (str.len (str.split_rest api_key_comp2 colon 1)) 2)
 (= (str.len api_key_comp3) 4)
 (str.is_digit (str.split_at api_key_comp3 underscore 0))
)))

; Four-segment underscore format
(define-const api_key_sec1 String (str.split_at api_key underscore 0))
(define-const api_key_sec2 String (str.split_at (str.split_rest api_key underscore 1) underscore 0))
(define-const api_key_sec3 String (str.split_at (str.split_rest (str.split_rest api_key underscore 1) underscore 1) underscore 0))
(define-const api_key_sec4 String (str.split_rest (str.split_rest (str.split_rest api_key underscore 1) underscore 1) underscore 1))

(assert (=> (= (str.num_splits api_key underscore) 4)
 (and
 (= (str.len api_key_sec1) 3)
 (= (str.len api_key_sec2) 6)
 (= (str.len api_key_sec3) 6)
 (= (str.len api_key_sec4) 8)
 (= (str.num_splits api_key_sec2 dash) 2)
)))

; Authorization header parsing with complex splits
(assert (str.contains auth_header "Bearer "))
(define-const auth_type String (str.split_at auth_header space 0))
(define-const auth_token String (str.split_rest auth_header space 1))

; Token can be either JWT or API key
(assert (or (= auth_token jwt) (= auth_token api_key)))

; Multi-format token validation in header context
(assert (=> (str.contains auth_token dot)
 (= (str.num_splits auth_token dot) 3)))

; Complex secret validation with multiple components
(assert (>= (str.len secret) 16))
(define-const secret_part1 String (str.split_at secret colon 0))
(define-const secret_part2 String (str.split_rest secret colon 1))

(assert (>= (str.len secret_part1) 8))
(assert (>= (str.len secret_part2) 8))
(assert (= (str.num_splits secret_part1 dash) 1))
(assert (= (str.num_splits secret_part2 underscore) 1))

; JWT payload parsing with additional constraints
(define-const payload_segment1 String (str.split_at jwt_payload underscore 0))
(define-const payload_segment2 String (str.split_rest jwt_payload underscore 1))

(assert (=> (> (str.len payload_segment2) 0)
 (str.contains (str.split_at payload_segment2 dot 0) "exp")))

; Complex unsatisfiable constraints using multiple splits
(assert (not (and 
 (= (str.num_splits api_key colon) 2)
 (= (str.num_splits api_key dash) 3)
 (= (str.num_splits api_key underscore) 4)
 (str.contains (str.split_at jwt_header comma 0) "invalid")
)))

; Nested validation for API key components
(assert (=> (= (str.num_splits api_key colon) 2)
 (and
 (= (str.num_splits api_key_part1 dash) 2)
 (= (str.len (str.split_at api_key_part1 dash 0)) 4)
 (= (str.len (str.split_rest api_key_part1 dash 1)) 4)
 (str.contains (str.split_at api_key_part2 underscore 0) "sec")
)))

; Additional JWT signature validation with split components
(define-const sig_component1 String (str.split_at jwt_signature dash 0))
(define-const sig_component2 String (str.split_rest jwt_signature dash 1))

(assert (or (= (str.len sig_component2) 0)
 (and (> (str.len sig_component2) 0)
      (= (str.num_splits sig_component2 colon) 1))))

; Final comprehensive constraints
(assert (> (str.len jwt) 0))
(assert (> (str.len api_key) 0))
(assert (> (str.len auth_header) 0))

; Complex mutual exclusion constraint
(assert (not (and
 (= (str.num_splits (str.split_at auth_token dot 0) colon) 2)
 (= (str.num_splits (str.split_rest auth_token dot 1) dash) 3)
)))

(check-sat)
(exit)
(get-model)
