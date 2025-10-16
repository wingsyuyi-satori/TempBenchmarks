; SMT-LIB2 file: JWT and API Key Validation with String Split Constraints
; ; Focus: segment count, base64 validation (simplified), signature checking
; Delimiters: '.', '-', ':'
; ; Author: SMT String Split Reasoning Example

(set-logic ALL_SUPPORTED)

; Declare variables representing tokens
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_client_id () String)
(declare-fun api_secret () String)

; --- JWT Validation ---

; JWTs have the form: header.payload.signature (delimited by '.')
; There must be exactly 3 segments after splitting by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract each segment
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; ; Simplified base64 validation: base64 alphabet is [A-Za-z0-9+/=], we check that no segment contains '-' or ':'
; ; In practice, base64url for JWT allows '-', but we use this as a simplified check for illustration
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ":")))
(assert (not (str.contains jwt_payload "-")))
(assert (not (str.contains jwt_payload ":")))
(assert (not (str.contains jwt_signature "-")))
(assert (not (str.contains jwt_signature ":")))

; ; Signature check: the signature segment must not be empty
(assert (not (= jwt_signature "")))

; --- API Key Validation ---

; API key format: PREFIX-CLIENTID:SECRET (delimiters: '-' and ':')
; There must be exactly 2 segments after splitting by ':'
(assert (= (str.num_splits api_key ":") 2))

; ; Extract secret (after ':')
(assert (= api_secret (str.split_at api_key ":" 1)))

; ; Extract PREFIX-CLIENTID (before ':')
(assert (= (str.split_at api_key ":" 0) (str.++ api_prefix "-" api_client_id)))

; There must be exactly 2 segments after splitting PREFIX-CLIENTID by '-'
(assert (= (str.num_splits (str.split_at api_key ":" 0) "-") 2))

; ; Extract prefix and client id
(assert (= api_prefix (str.split_at (str.split_at api_key ":" 0) "-" 0)))
(assert (= api_client_id (str.split_at (str.split_at api_key ":" 0) "-" 1)))

; Prefix must not be empty and must be "API"
(assert (= api_prefix "API"))

; Client ID must only contain digits (simplified: not containing '-' or ':')
(assert (not (str.contains api_client_id "-")))
(assert (not (str.contains api_client_id ":")))

; Secret must not be empty and must not contain '-'
(assert (not (= api_secret "")))
(assert (not (str.contains api_secret "-")))

; ; --- Satisfiable Example: Provide a concrete instance
(assert (= jwt_token "QWxhZGRpbjpPcGVuU2VzYW1l.LGx1c2Vy.LG1hYw"))
(assert (= api_key "API-12345:secretValue"))

; ; --- Unsatisfiable Example: Force contradiction for JWT (segment count wrong)
(declare-fun bad_jwt_token () String)
(assert (= bad_jwt_token "header.payload")) ; Only 2 segments, should be 3
(assert (= (str.num_splits bad_jwt_token ".") 3)) ; Contradicts above

(check-sat)
(exit)
(get-model)
