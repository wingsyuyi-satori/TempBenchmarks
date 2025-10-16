(set-info :source |Authentication Token Validation - JWT and API key processing|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Variable declarations for JWT token processing
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Variable declarations for API key processing 
(declare-fun api_key () String)
(declare-fun key_prefix () String)
(declare-fun key_id () String)
(declare-fun key_secret () String)

; Variable declarations for base64 validation
(declare-fun base64_chars () String)
(declare-fun valid_b64_pattern () String)

; Variable declarations for timestamp and expiry
(declare-fun timestamp_field () String)
(declare-fun expiry_time () String)

; Constants for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))
(assert (= valid_b64_pattern "eyJ"))

; JWT structure validation - must have exactly 3 segments when split by dot
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1))) 
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must start with base64 encoded JSON (typically "eyJ")
(assert (str.prefixof valid_b64_pattern jwt_header))

; JWT payload must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_payload) 0))
(assert (not (= jwt_payload "")))

; JWT signature validation - must be base64 encoded, non-empty
(assert (> (str.len jwt_signature) 10))
(assert (not (str.contains jwt_signature " ")))

; API key structure validation - format: prefix-keyid:secret
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits api_key ":") 2))

; ; Extract API key components
(assert (= key_prefix (str.split_at api_key "-" 0)))
(assert (= key_id (str.split_at (str.split_at api_key "-" 1) ":" 0)))
(assert (= key_secret (str.split_at api_key ":" 1)))

; API key prefix validation
(assert (or (= key_prefix "sk") (= key_prefix "pk") (= key_prefix "ak")))

; Key ID must be alphanumeric and of specific length
(assert (and (>= (str.len key_id) 8) (<= (str.len key_id) 16)))

; Key secret must be sufficiently long for security
(assert (>= (str.len key_secret) 32))

; Base64 validation for JWT components
(assert (not (str.contains jwt_header "=")))
(assert (not (str.contains jwt_payload "="))) 

; ; Signature checking constraints
(assert (str.contains jwt_signature "="))

; Cross-validation between JWT and API key
(assert (not (= jwt_token api_key)))

; Timestamp validation in JWT payload (simulated)
(assert (str.contains jwt_payload "exp"))
(assert (str.contains jwt_payload "iat"))

; Security constraints - tokens must not contain dangerous patterns
(assert (not (str.contains jwt_token "<script")))
(assert (not (str.contains api_key "SELECT")))
(assert (not (str.contains jwt_payload "DROP")))

; Length constraints for security
(assert (and (>= (str.len jwt_token) 50) (<= (str.len jwt_token) 2048)))
(assert (and (>= (str.len api_key) 45) (<= (str.len api_key) 256)))

; Additional segment validation using split_rest
(assert (= (str.split_rest jwt_token "." 1) (str.++ jwt_payload "." jwt_signature)))
(assert (= (str.split_rest api_key ":" 1) key_secret))

; Ensure proper token format structure
(assert (str.contains jwt_token "."))
(assert (str.contains api_key "-"))
(assert (str.contains api_key ":"))

; Validation that split operations work correctly
(assert (= jwt_token (str.++ jwt_header "." jwt_payload "." jwt_signature)))

; Complex constraint combining multiple split operations
(assert (= (str.len (str.split_at jwt_token "." 0)) (str.len jwt_header)))

; ; Example concrete values for testing
(assert (or 
 (= jwt_token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c")
 (= api_key "sk-1234567890abcdef:9876543210fedcba9876543210fedcba9876543210fedcba")))

(check-sat)
(get-model)
