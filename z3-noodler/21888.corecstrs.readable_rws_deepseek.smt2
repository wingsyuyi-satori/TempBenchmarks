
; SMT-LIB2 script for JWT and API key validation
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.at (String Int) String)
(declare-fun str.substr (String Int Int) String)
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

; JWT validation constraints
(declare-const jwt_token String)
(declare-const expected_sig String)

; JWT must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token dot) 3))

; ; Extract JWT segments
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)
(assert (= jwt_header (str.split_at jwt_token dot 0)))
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; Header and payload must be base64 encoded (simplified as containing only base64 chars)
(assert (str.contains jwt_header "=="))
(assert (str.contains jwt_payload "=="))

; Signature must match expected value
(assert (= jwt_signature expected_sig))

; API key validation constraints
(declare-const api_key String)

; API key must have exactly 4 segments when split by '-'
(assert (= (str.num_splits api_key dash) 4))

; ; Extract API key segments
(declare-const api_prefix String)
(declare-const api_project String)
(declare-const api_env String)
(declare-const api_secret String)
(assert (= api_prefix (str.split_at api_key dash 0)))
(assert (= api_project (str.split_at api_key dash 1)))
(assert (= api_env (str.split_at api_key dash 2)))
(assert (= api_secret (str.split_at api_key dash 3)))

; API key prefix must be "ak"
(assert (= api_prefix "ak"))

; API secret must be exactly 32 chars (simplified validation)
(assert (= (str.len api_secret) 32))

; Combined authentication scenario
(declare-const auth_header String)

; Auth header must be in format "Bearer <jwt>:<api_key>"
(assert (= (str.num_splits auth_header colon) 2))

(declare-const bearer_part String)
(declare-const creds_part String)
(assert (= bearer_part (str.split_at auth_header colon 0)))
(assert (= creds_part (str.split_at auth_header colon 1)))

; Bearer part must start with "Bearer "
(assert (str.contains bearer_part "Bearer "))

; Creds part must contain both JWT and API key
(assert (str.contains creds_part jwt_token))
(assert (str.contains creds_part api_key))

; Unsatisfiable case: JWT with wrong segment count
(declare-const bad_jwt String)
(assert (= (str.num_splits bad_jwt dot) 2)) ; Should be 3
(assert (not (= (str.num_splits bad_jwt dot) 3)))

(check-sat)


(get-model)
