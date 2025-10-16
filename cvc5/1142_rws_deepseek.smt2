; SMT-LIB2 script for JWT and API key validation with split operations
(set-logic QF_SLIA)

; Declare string constants and variables
(declare-const jwt String)
(declare-const api_key String)
(declare-const expected_sig String)
(declare-const header String)
(declare-const payload String)
(declare-const signature String)

; Delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits jwt dot) 3))
(assert (= header (str.split_at jwt dot 0)))
(assert (= payload (str.split_at jwt dot 1)))
(assert (= signature (str.split_at jwt dot 2)))

; Header must start with "eyJ" (common JWT header prefix)
(assert (str.prefixof "eyJ" header))

; Signature must match expected value
(assert (= signature expected_sig))

; API key constraints (3 segments separated by colons)
(assert (= (str.num_splits api_key colon) 3))
(assert (str.contains (str.split_at api_key colon 0) "AKIA")) ; AWS-like prefix
(assert (>= (str.len (str.split_at api_key colon 1)) 16)) ; Secret part length
(assert (str.is_digit (str.split_at api_key colon 2))) ; Version number

; Combined authentication constraint
(assert (or 
 (and 
 (= (str.num_splits jwt dot) 3)
 (str.prefixof "eyJ" header)
 (= signature expected_sig)
)
 (and
 (= (str.num_splits api_key colon) 3)
 (str.contains (str.split_at api_key colon 0) "AKIA")
)
))

; Negative test case - invalid JWT with wrong segment count
(declare-const invalid_jwt String)
(assert (= (str.num_splits invalid_jwt dot) 2)) ; Missing signature

; Negative test case - API key with wrong prefix
(declare-const bad_api_key String)
(assert (not (str.contains (str.split_at bad_api_key colon 0) "AKIA")))

; ; Check satisfiability of valid cases
(echo "Checking valid authentication cases")
(check-sat)



(get-model)
