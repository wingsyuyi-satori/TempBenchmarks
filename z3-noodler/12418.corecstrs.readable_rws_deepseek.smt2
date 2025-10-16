
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and necessary functions
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.at (String Int) String)
(declare-fun str.is_base64 (String) Bool)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Declare constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; ; Example JWT token validation constraints
(declare-const jwt_token String)
(declare-const api_key String)

; JWT must have exactly 3 segments when split by dots
(assert (= (str.num_splits jwt_token dot) 3))

; Each JWT segment must be valid base64
(assert (str.is_base64 (str.split_at jwt_token dot 0))) ; header
(assert (str.is_base64 (str.split_at jwt_token dot 1))) ; payload
(assert (not (str.is_base64 (str.split_at jwt_token dot 2)))) ; signature is not base64

; Signature must be last segment and non-empty
(assert (> (str.len (str.split_at jwt_token dot 2)) 0))

; API key validation constraints
; API key must have 3 segments when split by dashes
(assert (= (str.num_splits api_key dash) 3))

; First segment must be 8 chars, second 4 chars, third 4 chars
(assert (= (str.len (str.split_at api_key dash 0)) 8))
(assert (= (str.len (str.split_at api_key dash 1)) 4))
(assert (= (str.len (str.split_at api_key dash 2)) 4))

; API key prefix must be "API"
(assert (str.contains (str.split_at api_key dash 0) "API"))

; ; Combined constraint: if JWT is valid, API key must have specific pattern
(assert (=> 
 (and 
 (= (str.num_splits jwt_token dot) 3)
 (str.is_base64 (str.split_at jwt_token dot 0))
)
 (str.contains (str.split_at api_key dash 1) "KEY")
))

; Unsatisfiable case: API key cannot have colons if JWT has valid header
(assert (not (and
 (str.contains (str.split_at api_key colon 0) "SECRET")
 (str.is_base64 (str.split_at jwt_token dot 0))
)))

; ; Check if both tokens can satisfy all constraints
(check-sat)


(get-model)
