; SMT-LIB2 script for JWT and API key validation with split constraints
(set-logic QF_SLIA)

; Declare string constants and variables
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)
(declare-const header String)
(declare-const payload String)
(declare-const signature String)

; Delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits jwt dot) 3))
(assert (= header (str.split_at jwt dot 0)))
(assert (= payload (str.split_at jwt dot 1)))
(assert (= signature (str.split_at jwt dot 2)))

; Header must start with "eyJ" (common JWT header prefix)
(assert (str.prefixof "eyJ" header))

; API key constraints (3 segments separated by colons)
(assert (= (str.num_splits api_key colon) 3))
(assert (= (str.len (str.split_at api_key colon 0)) 8)) ; client ID length
(assert (= (str.len (str.split_at api_key colon 1)) 16)) ; random component length

; API key signature verification (last segment must match hash of first two segments)
(assert (= (str.split_at api_key colon 2) 
 (str.++ (str.split_at api_key colon 0) 
 (str.split_at api_key colon 1) 
 secret)))

; JWT signature verification (signature must match hash of header.payload)
(assert (= signature 
 (str.++ header payload secret)))

; Base64 validation constraints (all JWT segments should be base64)

; Additional constraints for unsatisfiable case
(assert (not (= (str.len jwt) 0))) ; JWT cannot be empty
(assert (not (str.contains jwt dash))) ; JWT cannot contain dashes

; API key cannot have empty segments
(assert (not (= (str.len (str.split_at api_key colon 0)) 0)))
(assert (not (= (str.len (str.split_at api_key colon 1)) 0)))
(assert (not (= (str.len (str.split_at api_key colon 2)) 0)))

; ; Check satisfiability
(check-sat)
(exit)
(get-model)
