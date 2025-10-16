
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Declare token variables
(declare-const jwt String)
(declare-const api_key String)

; JWT constraints (3 segments separated by dots)
(assert (= (str.num_splits jwt dot) 3))

; First segment (header) must contain "alg"
(assert (str.contains (str.split_at jwt dot 0) "alg"))

; Second segment (payload) must contain "sub"
(assert (str.contains (str.split_at jwt dot 1) "sub"))

; Third segment (signature) must be exactly 43 chars
(assert (= (str.len (str.split_at jwt dot 2)) 43))

; API key constraints (4 segments separated by dashes)
(assert (= (str.num_splits api_key dash) 4))

; Each API key segment must be 8 characters
(assert (= (str.len (str.split_at api_key dash 0)) 8))
(assert (= (str.len (str.split_at api_key dash 1)) 8))
(assert (= (str.len (str.split_at api_key dash 2)) 8))
(assert (= (str.len (str.split_at api_key dash 3)) 8))

; Authentication scenario constraints
(declare-const auth_header String)

; Either JWT or API key must be present
(assert (or
 (and 
 (str.prefixof "Bearer " auth_header)
 (= jwt (str.substr auth_header 7 (- (str.len auth_header) 7)))
)
 (and
 (str.prefixof "ApiKey " auth_header)
 (= api_key (str.substr auth_header 7 (- (str.len auth_header) 7)))
)
))

; Unsatisfiable case: cannot have both tokens in same header
(assert (not (and
 (str.prefixof "Bearer " auth_header)
 (str.prefixof "ApiKey " auth_header)
)))

; ; Check if JWT signature matches expected pattern
(declare-const expected_sig String)
(assert (= expected_sig "ABC123"))
(assert (=> 
 (> (str.len jwt) 0) 
 (str.contains (str.split_at jwt dot 2) expected_sig)
))

; ; Check satisfiability
(check-sat)
(get-model)
