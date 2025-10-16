
(set-logic QF_SLIA)
(set-option :produce-models true)

; Delimiter constants
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Token variables
(declare-const jwt_token String)
(declare-const api_key String)

; ; Example 1: JWT validation (3 segments separated by dots)
(assert (= (str.num_splits jwt_token dot) 3)) ; Must have header.payload.signature

; ; Extract JWT components
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)
(assert (= jwt_header (str.split_at jwt_token dot 0)))
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; Length constraints for JWT components
(assert (>= (str.len jwt_header) 10))
(assert (>= (str.len jwt_payload) 10))
(assert (>= (str.len jwt_signature) 10))

; ; Example 2: API key validation (3 segments separated by dashes)
(assert (= (str.num_splits api_key dash) 3)) ; Must have prefix-id-secret

; ; Extract API key components
(declare-const api_prefix String)
(declare-const api_id String)
(declare-const api_secret String)
(assert (= api_prefix (str.split_at api_key dash 0)))
(assert (= api_id (str.split_at api_key dash 1)))
(assert (= api_secret (str.split_at api_key dash 2)))

; API key format constraints
(assert (= api_prefix "AK")) ; Prefix must be "AK"
(assert (= (str.len api_id) 8)) ; ID must be 8 chars
(assert (= (str.len api_secret) 16)) ; Secret must be 16 chars

; ; Check satisfiable case (valid tokens)
(echo "=== Checking valid token constraints ===")
(check-sat)



(exit)
(get-model)
