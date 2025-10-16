; SMT-LIB2 script for JWT and API key validation with split operations
(set-logic QF_SLIA)

; Declare string constants and variables
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)
(declare-const header String)
(declare-const payload String)
(declare-const signature String)
(declare-const api_key_prefix String)
(declare-const api_key_value String)

; Define delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits jwt dot) 3))
(assert (= header (str.split_at jwt dot 0)))
(assert (= payload (str.split_at jwt dot 1)))
(assert (= signature (str.split_at jwt dot 2)))

; ; Header must be valid base64 (simplified check - starts with "ey")
(assert (str.prefixof "ey" header))

; ; Payload must be valid base64 (simplified check - starts with "ey")
(assert (str.prefixof "ey" payload))

; ; Signature must be exactly 43 base64 characters (simplified check)
(assert (= (str.len signature) 43))

; API key constraints (2 segments separated by colon)
(assert (= (str.num_splits api_key colon) 2))
(assert (= api_key_prefix (str.split_at api_key colon 0)))
(assert (= api_key_value (str.split_at api_key colon 1)))

; API key prefix must be "sk_" or "pk_"
(assert (or (= api_key_prefix "sk_") (= api_key_prefix "pk_")))

; API key value must be 32 alphanumeric characters
(assert (= (str.len api_key_value) 32))
(assert (str.is_digit (str.at api_key_value 0))) ; First char must be digit

; Signature verification constraint (simplified)
(assert (=> (str.contains jwt "admin") 
 (str.contains signature "x2y"))) ; Special signature required for admin tokens

; Conflicting constraints to test unsatisfiability
;(assert (str.contains payload "admin"))
;(assert (not (str.contains signature "x2y")))

; Alternative API key format (dash-separated)
(declare-const alt_api_key String)
(assert (= (str.num_splits alt_api_key dash) 3))
(assert (= (str.len (str.split_at alt_api_key dash 0)) 8)) ; First segment 8 chars
(assert (= (str.len (str.split_at alt_api_key dash 1)) 4)) ; Second segment 4 chars
(assert (= (str.len (str.split_at alt_api_key dash 2)) 4)) ; Third segment 4 chars

; ; Check if the rest of JWT after header is valid
(assert (str.contains (str.split_rest jwt dot 1) payload))

(check-sat)
(exit)
(get-model)
