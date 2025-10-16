(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-info :status unknown)

; Variable declarations for JWT tokens
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Variable declarations for API keys
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_remaining () String)
(declare-fun api_identifier () String)
(declare-fun api_suffix () String)

; Variable declarations for base64 validation
(declare-fun header_b64 () String)
(declare-fun payload_b64 () String)
(declare-fun signature_b64 () String)

; Variable declarations for timestamp validation
(declare-fun exp_field () String)
(declare-fun iat_field () String)

; JWT Token Structure Validation - must have exactly 3 segments
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT components must be non-empty
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; API Key Structure Validation - format: prefix-identifier:suffix
(assert (= (str.num_splits api_key "-") 2))

; ; Extract API key prefix
(assert (= api_prefix (str.split_at api_key "-" 0)))

; Get remaining part after first dash
(assert (= api_remaining (str.split_rest api_key "-" 1)))

; Remaining part must have exactly one colon
(assert (= (str.num_splits api_remaining ":") 2))

; ; Extract identifier and suffix from remaining part
(assert (= api_identifier (str.split_at api_remaining ":" 0)))
(assert (= api_suffix (str.split_at api_remaining ":" 1)))

; Segment count validation
(assert (>= (str.len api_prefix) 3))
(assert (>= (str.len api_identifier) 8))
(assert (>= (str.len api_suffix) 6))

; Base64 validation for JWT header
(assert (= header_b64 jwt_header))
(assert (not (str.contains header_b64 " ")))
(assert (not (str.contains header_b64 "\n")))
(assert (not (str.contains header_b64 "\t")))

; Base64 validation for JWT payload
(assert (= payload_b64 jwt_payload))
(assert (not (str.contains payload_b64 " ")))
(assert (not (str.contains payload_b64 "\n")))

; Base64 validation for JWT signature
(assert (= signature_b64 jwt_signature))
(assert (not (str.contains signature_b64 " ")))

; JWT signature length validation for different algorithms
(assert (or (= (str.len jwt_signature) 43)
 (= (str.len jwt_signature) 44)
 (= (str.len jwt_signature) 86)
 (= (str.len jwt_signature) 88)))

; API key prefix validation
(assert (str.prefixof "api" api_prefix))

; JWT payload must contain standard claims
(assert (str.contains jwt_payload "exp"))
(assert (str.contains jwt_payload "iat"))

; ; Extract timestamp fields from payload
(assert (= exp_field (str.split_at jwt_payload "exp" 1)))
(assert (= iat_field (str.split_at jwt_payload "iat" 1)))

; Timestamp fields must be numeric-like
(assert (> (str.len exp_field) 0))
(assert (> (str.len iat_field) 0))

; JWT header must contain algorithm specification
(assert (str.contains jwt_header "alg"))

; Algorithm validation - must specify known algorithms
(assert (or (str.contains jwt_header "HS256")
 (str.contains jwt_header "HS512")
 (str.contains jwt_header "RS256")))

; Base64 padding validation
(assert (=> (str.contains jwt_header "=")
 (str.suffixof "=" jwt_header)))
(assert (=> (str.contains jwt_payload "=")
 (str.suffixof "=" jwt_payload)))
(assert (=> (str.contains jwt_signature "=")
 (str.suffixof "=" jwt_signature)))

; Security constraints - no weak signatures
(assert (not (= jwt_signature "signature")))
(assert (not (= jwt_signature "placeholder")))
(assert (not (= jwt_signature "")))

; API key security constraints
(assert (not (= api_suffix "123456")))
(assert (not (= api_suffix "secret")))
(assert (not (= api_suffix "password")))

; Cross-validation between JWT and API key
(assert (=> (str.contains jwt_payload "iss")
 (str.contains api_key "api")))

; Minimum length requirements for security
(assert (>= (str.len jwt_token) 50))
(assert (>= (str.len api_key) 20))

; JWT token structure integrity
(assert (= jwt_token (str.++ jwt_header "." jwt_payload "." jwt_signature)))

; API key structure integrity
(assert (= api_key (str.++ api_prefix "-" api_identifier ":" api_suffix)))

; Ensure no overlap between JWT and API key content
(assert (not (str.contains jwt_token api_key)))
(assert (not (str.contains api_key jwt_token)))

; Base64 character validation - no invalid characters
(assert (not (str.contains jwt_header "@")))
(assert (not (str.contains jwt_payload "#")))
(assert (not (str.contains jwt_signature "$")))

; Additional segment validation
(assert (< (str.len api_prefix) 20))
(assert (< (str.len api_identifier) 50))
(assert (< (str.len api_suffix) 30))

(check-sat)
(get-model)
