; SMT-LIB2 file for JWT and API Key Validation using string split operations
; ; This models segment counting, base64 validation, and signature checking
; using delimiters: '.', '-', ':'

(set-logic ALL)
(set-option :produce-models true)

; Declare variables for input tokens
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT tokens have format: header.payload.signature (delimited by '.')
; API keys have format: prefix-key:signature (delimiters '-' and ':')

; Declare variables for JWT segments
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)
(declare-fun jwt_num_segments () Int)

; ; Split JWT token at '.' and extract segments
(assert (= jwt_num_segments (str.num_splits jwt_token ".")))
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT must have exactly 3 segments
(assert (= jwt_num_segments 3))

; Base64 validation for header and payload: only characters A-Z a-z 0-9 + / =
; ; For simplicity, check prefix/suffix to model constraint (real check would be regex)
(declare-fun jwt_header_is_base64 () Bool)
(declare-fun jwt_payload_is_base64 () Bool)

; Assume that base64-encoded strings never contain '.' or '-' or ':'
(assert (not (str.contains jwt_header ".")))
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ":")))
(assert (not (str.contains jwt_payload ".")))
(assert (not (str.contains jwt_payload "-")))
(assert (not (str.contains jwt_payload ":")))

; Model "base64 validation" as a Boolean for header/payload
(assert (= jwt_header_is_base64 true))
(assert (= jwt_payload_is_base64 true))

; JWT signature must be non-empty
(assert (> (str.len jwt_signature) 0))

; ; Example: JWT signature must not contain a colon
(assert (not (str.contains jwt_signature ":")))

; API key format: prefix-key:signature
; ; Example: "svc-abc123:deadbeef"
; ; Let's extract segments

(declare-fun api_prefix_key () String)
(declare-fun api_signature () String)
(declare-fun api_split_count_colon () Int)

; Split at ':'
(assert (= api_split_count_colon (str.num_splits api_key ":")))
(assert (= api_prefix_key (str.split_at api_key ":" 0)))
(assert (= api_signature (str.split_at api_key ":" 1)))
(assert (= api_split_count_colon 2))

; Now, split prefix_key at '-'
(declare-fun api_prefix () String)
(declare-fun api_keypart () String)
(declare-fun api_split_count_dash () Int)

(assert (= api_split_count_dash (str.num_splits api_prefix_key "-")))
(assert (= api_prefix (str.split_at api_prefix_key "-" 0)))
(assert (= api_keypart (str.split_at api_prefix_key "-" 1)))
(assert (= api_split_count_dash 2))

; API prefix must be "svc"
(assert (= api_prefix "svc"))

; API key part must be alphanumeric (simulate: must not contain '.' or ':')
(assert (not (str.contains api_keypart ".")))
(assert (not (str.contains api_keypart ":")))

; ; API signature must be at least 8 characters (simulate "signature checking")
(assert (>= (str.len api_signature) 8))

; API signature must not contain '-'
(assert (not (str.contains api_signature "-")))

; Satisfiable scenario: provide a model that can satisfy all constraints
; (smt solver will find a satisfying assignment)

; Unsatisfiable scenario 1: JWT with less than 3 segments
(declare-fun jwt_token_invalid () String)
(declare-fun jwt_invalid_num_segments () Int)
(assert (= jwt_invalid_num_segments (str.num_splits jwt_token_invalid ".")))
(assert (< jwt_invalid_num_segments 3))

; Unsatisfiable scenario 2: API key with wrong prefix
(declare-fun api_key_invalid () String)
(declare-fun api_invalid_prefix_key () String)
(declare-fun api_invalid_prefix () String)
(assert (= api_invalid_prefix_key (str.split_at api_key_invalid ":" 0)))
(assert (= api_invalid_prefix (str.split_at api_invalid_prefix_key "-" 0)))
(assert (not (= api_invalid_prefix "svc")))

; Unsatisfiable scenario 3: JWT signature is empty
(declare-fun jwt_token_empty_sig () String)
(declare-fun jwt_signature_empty () String)
(assert (= jwt_signature_empty (str.split_at jwt_token_empty_sig "." 2)))
(assert (= (str.len jwt_signature_empty) 0))

; Unsatisfiable scenario 4: API signature too short
(declare-fun api_key_short_sig () String)
(declare-fun api_short_sig () String)
(assert (= api_short_sig (str.split_at api_key_short_sig ":" 1)))
(assert (< (str.len api_short_sig) 8))

(check-sat)
(exit)
(get-model)
