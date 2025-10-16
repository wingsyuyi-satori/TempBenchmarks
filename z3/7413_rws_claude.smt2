(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Variable declarations for JWT token processing
(declare-const jwt_token String)
(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)

; Variable declarations for API key processing
(declare-const api_key String)
(declare-const key_prefix String)
(declare-const key_identifier String)
(declare-const key_secret String)

; Variable declarations for base64 validation
(declare-const b64_chars String)
(declare-const valid_b64_pattern String)

; ; Variable declarations for segment extraction
(declare-const header_segment String)
(declare-const payload_segment String)
(declare-const signature_segment String)

; Variable declarations for counts and validation flags
(declare-const jwt_segment_count Int)
(declare-const api_key_segment_count Int)
(declare-const colon_segment_count Int)

; Constants for validation
(assert (= b64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))
(assert (= valid_b64_pattern "eyJ"))

; JWT token structure validation - must have exactly 3 segments when split by '.'
(assert (= jwt_segment_count (str.num_splits jwt_token ".")))
(assert (= jwt_segment_count 3))

; ; Extract JWT segments using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must start with base64 encoded JSON (typically starts with "eyJ")
(assert (str.prefixof valid_b64_pattern jwt_header))

; JWT segments must be non-empty and contain only valid base64 characters
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; Base64 validation - each segment should only contain valid base64 characters
(assert (forall ((i Int)) 
 (=> (and (>= i 0) (< i (str.len jwt_header)))
 (str.contains b64_chars (str.at jwt_header i)))))

(assert (forall ((i Int)) 
 (=> (and (>= i 0) (< i (str.len jwt_payload)))
 (str.contains b64_chars (str.at jwt_payload i)))))

; API key validation with hyphen delimiter
(assert (= api_key_segment_count (str.num_splits api_key "-")))
(assert (>= api_key_segment_count 2))

; ; Extract API key components
(assert (= key_prefix (str.split_at api_key "-" 0)))
(assert (= key_identifier (str.split_at api_key "-" 1)))

; API key prefix validation
(assert (or (= key_prefix "sk") (= key_prefix "pk") (= key_prefix "ak")))

; Key identifier must be alphanumeric and of sufficient length
(assert (>= (str.len key_identifier) 16))
(assert (<= (str.len key_identifier) 64))

; ; If API key has more than 2 segments, extract the secret part
(assert (=> (> api_key_segment_count 2)
 (= key_secret (str.split_rest api_key "-" 2))))

; Colon-separated authentication format validation
(declare-const auth_string String)
(declare-const username String)
(declare-const password String)

(assert (= colon_segment_count (str.num_splits auth_string ":")))
(assert (= colon_segment_count 2))

(assert (= username (str.split_at auth_string ":" 0)))
(assert (= password (str.split_at auth_string ":" 1)))

; Username and password constraints
(assert (> (str.len username) 0))
(assert (>= (str.len password) 8))

; Security constraints - password should not contain username
(assert (not (str.contains password username)))

; JWT signature validation constraints
(assert (>= (str.len jwt_signature) 32))

; Ensure JWT payload contains standard claims structure
(declare-const payload_decoded String)
(assert (str.contains payload_decoded "iat:"))
(assert (str.contains payload_decoded "exp:"))

; Cross-validation between different token types
(assert (not (= jwt_token api_key)))
(assert (not (= jwt_token auth_string)))

; Additional segment count relationships
(assert (> jwt_segment_count api_key_segment_count))

; Complex constraint combining all validation rules
(assert (and 
 (= jwt_segment_count 3)
 (>= api_key_segment_count 2)
 (= colon_segment_count 2)
 (str.prefixof "eyJ" jwt_header)
 (or (= key_prefix "sk") (= key_prefix "pk"))
 (>= (str.len password) 8)))

; Signature verification constraint - signature must be different from header and payload
(assert (not (= jwt_signature jwt_header)))
(assert (not (= jwt_signature jwt_payload)))

; Final validation - ensure all tokens have minimum security requirements
(assert (and
 (>= (str.len jwt_token) 100)
 (>= (str.len api_key) 20)
 (>= (str.len auth_string) 10)))

(check-sat)
(get-model)
