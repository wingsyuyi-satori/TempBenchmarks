
; SMT-LIB2 file for JWT and API key validation
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and necessary functions
(declare-sort Char 0)

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

; JWT token constraints (3 segments separated by dots)
(declare-const jwt String)
(assert (= (str.num_splits jwt dot) 3)) ; JWT must have exactly 3 parts

; ; Extract JWT segments
(declare-const jwt_header String)
(assert (= jwt_header (str.split_at jwt dot 0)))
(declare-const jwt_payload String)
(assert (= jwt_payload (str.split_at jwt dot 1)))
(declare-const jwt_signature String)
(assert (= jwt_signature (str.split_at jwt dot 2)))

; Base64 validation for JWT segments
(assert (str.is_base64 jwt_header))
(assert (str.is_base64 jwt_payload))
(assert (str.is_base64 jwt_signature))

; API key constraints (3 segments separated by colons)
(declare-const api_key String)
(assert (= (str.num_splits api_key colon) 3)) ; API key must have exactly 3 parts

; ; Extract API key segments
(declare-const api_prefix String)
(assert (= api_prefix (str.split_at api_key colon 0)))
(declare-const api_id String)
(assert (= api_id (str.split_at api_key colon 1)))
(declare-const api_secret String)
(assert (= api_secret (str.split_at api_key colon 2)))

; API key format constraints
(assert (str.contains api_prefix "API")) ; Must contain "API" prefix
(assert (>= (str.len api_id) 8)) ; ID must be at least 8 chars
(assert (>= (str.len api_secret) 16)) ; Secret must be at least 16 chars

; Combined authentication scenario
; Case 1: Valid JWT but invalid API key (should be SAT)
(assert (not (= (str.len jwt_signature) 43))) ; Invalid signature length
(assert (= (str.num_splits api_key dash) 2)) ; Wrong delimiter for API key
(check-sat)




(exit)
(get-model)
