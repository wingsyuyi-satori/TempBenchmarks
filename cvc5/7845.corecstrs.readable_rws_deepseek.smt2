
; SMT-LIB2 script for JWT and API key validation
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)

; Declare delimiters
(define-const dot String ".")
(define-const dash String "-")
(define-const colon String ":")

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits jwt dot) 3))
(assert (> (str.len (str.split_at jwt dot 0)) 0)) ; header exists
(assert (> (str.len (str.split_at jwt dot 1)) 0)) ; payload exists
(assert (> (str.len (str.split_at jwt dot 2)) 0)) ; signature exists

; JWT signature verification (simplified)
(assert (= (str.split_at jwt dot 2) 
 (str.++ "sig" (str.split_at jwt dot 0) (str.split_at jwt dot 1) secret)))

; API key constraints (3 segments separated by colons)
(assert (= (str.num_splits api_key colon) 3))
(assert (> (str.len (str.split_at api_key colon 0)) 0)) ; client ID exists
(assert (> (str.len (str.split_at api_key colon 1)) 0)) ; timestamp exists
(assert (> (str.len (str.split_at api_key colon 2)) 0)) ; hash exists

; API key timestamp validation (must be numeric)
(assert (str.is_digit (str.split_at api_key colon 1)))

; API key hash verification (simplified)
(assert (= (str.split_at api_key colon 2) 
 (str.++ "hash" (str.split_at api_key colon 0) (str.split_at api_key colon 1) secret)))

; Additional constraints for base64-like validation (simplified)
(assert (str.contains (str.split_at jwt dot 0) "ey")) ; common JWT header prefix
(assert (str.contains (str.split_at jwt dot 1) "ey")) ; common JWT payload prefix

; Negative test case - invalid JWT with wrong segment count
(declare-const invalid_jwt String)
(assert (= (str.num_splits invalid_jwt dot) 2)) ; missing signature
(assert (not (= (str.num_splits invalid_jwt dot) 3)))

; Negative test case - API key with invalid timestamp
(declare-const invalid_api_key String)
(assert (= (str.num_splits invalid_api_key colon) 3))
(assert (not (str.is_digit (str.split_at invalid_api_key colon 1))))

; ; Check satisfiability of valid cases
(check-sat)



(get-model)
