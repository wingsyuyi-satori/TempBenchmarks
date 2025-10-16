; SMT-LIB2 file for Authentication Token: JWT and API Key Validation
; ; Focus: segment count, base64 validation, signature checking
; Delimiters: '.', '-', ':'

(set-logic ALL)
; Declare variables
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_id () String)
(declare-fun api_secret () String)

; JWT must have exactly 3 segments separated by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT segments
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT signature must not be empty
(assert (not (= jwt_signature "")))

; JWT header and payload should only contain base64url characters
; For simplicity, base64url: [A-Za-z0-9-_], so no '.' or ':' allowed in these segments
(assert (= (str.contains jwt_header ".") false))
(assert (= (str.contains jwt_header ":") false))
(assert (= (str.contains jwt_payload ".") false))
(assert (= (str.contains jwt_payload ":") false))

; API key format: <prefix>-<id>:<secret>
; First split on ':', must have exactly 2 segments
(assert (= (str.num_splits api_key ":") 2))
(assert (= api_secret (str.split_at api_key ":" 1)))

; The part before ':' is <prefix>-<id>
(assert (= (str.split_at api_key ":" 0) (str.++ api_prefix "-" api_id)))

; The <prefix>-<id> part split on '-', must have exactly 2 segments
(assert (= (str.num_splits (str.split_at api_key ":" 0) "-") 2))
(assert (= api_prefix (str.split_at (str.split_at api_key ":" 0) "-" 0)))
(assert (= api_id (str.split_at (str.split_at api_key ":" 0) "-" 1)))

; API secret must be at least 8 characters (simulate by not allowing less than 8 chars)
(assert (>= (str.len api_secret) 8))

; ; Example of a satisfiable constraint: JWT and API key both valid
(assert (not (= jwt_token api_key))) ; Tokens should be different

; ; Example of an unsatisfiable constraint: JWT header contains a colon, which is not allowed in base64url
(assert (not (= (str.contains jwt_header ":") true)))

; ; Example of unsatisfiable constraint: API secret is empty and at least 8 characters at the same time
(assert (not (= api_secret ""))) ; secret not empty

; ; Example: JWT signature must match a fixed string (simulate signature checking)
(define-fun valid_signature () String "abc123XYZ")
(assert (not (= jwt_signature valid_signature)))

(check-sat)
(get-model)
