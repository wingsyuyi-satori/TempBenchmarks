
(set-logic QF_SLIA) ; Set the string theory

; Declare string constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Declare variables for JWT token and API key
(declare-const jwt_token String)
(declare-const api_key String)

; JWT constraints
; A valid JWT must have exactly 3 parts separated by dots
(assert (= (str.num_splits jwt_token dot) 3))

; ; Extract JWT segments
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)
(assert (= jwt_header (str.split_at jwt_token dot 0)))
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; ; JWT header and payload must be base64 encoded (simplified check)
(assert (str.contains jwt_header "="))
(assert (str.contains jwt_payload "="))
(assert (>= (str.len jwt_header) 4))
(assert (>= (str.len jwt_payload) 4))

; Signature must be non-empty
(assert (> (str.len jwt_signature) 0))

; API key constraints
; API key must have either 2 parts (colon separated) or 4 parts (dash separated)
(assert (or 
 (= (str.num_splits api_key colon) 2)
 (= (str.num_splits api_key dash) 4)
))

; Case 1: API key with colon separator (client_id:secret)
(declare-const api_key_client_id String)
(declare-const api_key_secret String)
(assert (=> (= (str.num_splits api_key colon) 2)
 (and
 (= api_key_client_id (str.split_at api_key colon 0))
 (= api_key_secret (str.split_at api_key colon 1))
 (> (str.len api_key_client_id) 0)
 (> (str.len api_key_secret) 0)
)
))

; Case 2: API key with dash separator (uuid-style)
(declare-const api_key_part1 String)
(declare-const api_key_part2 String)
(declare-const api_key_part3 String)
(declare-const api_key_part4 String)
(assert (=> (= (str.num_splits api_key dash) 4)
 (and
 (= api_key_part1 (str.split_at api_key dash 0))
 (= api_key_part2 (str.split_at api_key dash 1))
 (= api_key_part3 (str.split_at api_key dash 2))
 (= api_key_part4 (str.split_at api_key dash 3))
 (= (str.len api_key_part1) 8)
 (= (str.len api_key_part2) 4)
 (= (str.len api_key_part3) 4)
 (= (str.len api_key_part4) 12)
)
))

; Additional constraints
; JWT and API key cannot be empty
(assert (> (str.len jwt_token) 0))
(assert (> (str.len api_key) 0))

; JWT and API key cannot be the same
(assert (not (= jwt_token api_key)))

; Unsatisfiable case: JWT with wrong segment count
(declare-const bad_jwt String)
(assert (= (str.num_splits bad_jwt dot) 2)) ; Invalid JWT with only 2 parts
(assert (> (str.len bad_jwt) 0))

; ; Check satisfiability
(check-sat)


(exit)
(get-model)
