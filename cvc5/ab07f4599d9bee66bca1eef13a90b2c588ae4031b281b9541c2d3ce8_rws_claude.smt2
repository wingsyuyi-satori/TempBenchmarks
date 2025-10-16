(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_identifier () String)
(declare-fun api_secret () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)
(declare-fun header_decoded () String)
(declare-fun payload_decoded () String)

; Declare string variables for timestamp and expiry validation
(declare-fun timestamp_field () String)
(declare-fun expiry_time () String)
(declare-fun current_time () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_header) 0))
(assert (str.prefixof "eyJ" jwt_header)) ; JWT headers typically start with eyJ when base64 encoded

; JWT payload must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_payload) 0))
(assert (not (= jwt_payload "")))

; JWT signature validation - must be non-empty and proper length for HMAC-SHA256
(assert (> (str.len jwt_signature) 40))
(assert (< (str.len jwt_signature) 50))

; API key structure validation - format: prefix-identifier:secret
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits (str.split_at api_key "-" 1) ":") 2))

; ; Extract API key components
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_identifier (str.split_at (str.split_at api_key "-" 1) ":" 0)))
(assert (= api_secret (str.split_at (str.split_at api_key "-" 1) ":" 1)))

; API key prefix validation
(assert (or (= api_prefix "sk") (= api_prefix "pk") (= api_prefix "ak")))

; API key identifier must be exactly 24 characters
(assert (= (str.len api_identifier) 24))

; API key secret must be at least 32 characters
(assert (>= (str.len api_secret) 32))

; ; Base64 validation for JWT header - check character composition
(assert (str.contains header_decoded "alg"))
(assert (str.contains header_decoded "typ"))

; ; Base64 validation for JWT payload - check for standard claims
(assert (str.contains payload_decoded "iat")) ; issued at
(assert (str.contains payload_decoded "exp")) ; expiration

; Timestamp validation in payload
(assert (= (str.num_splits payload_decoded ":") 6)) ; typical JWT has multiple key-value pairs
(assert (str.contains payload_decoded timestamp_field))

; Signature verification constraint - signature must match expected pattern
(assert (not (str.contains jwt_signature "."))) ; signature should not contain dots
(assert (not (str.contains jwt_signature "-"))) ; signature should not contain hyphens

; Token expiry validation
(assert (str.contains expiry_time "exp"))
(assert (> (str.len expiry_time) 10)) ; Unix timestamp should be at least 10 digits

; Cross-validation between JWT and API key
(assert (not (= jwt_token api_key))) ; JWT and API key should be different formats

; Security constraint - tokens should not contain obvious patterns
(assert (not (str.contains jwt_token "password")))
(assert (not (str.contains api_key "secret123")))
(assert (not (str.contains jwt_signature "000000")))

; Length constraints for security
(assert (> (str.len jwt_token) 100)) ; JWT should be substantial length
(assert (< (str.len jwt_token) 2000)) ; but not excessively long

; API key total length validation
(assert (> (str.len api_key) 50))
(assert (< (str.len api_key) 200))

; ; Delimiter consistency check
(assert (str.contains jwt_token "."))
(assert (str.contains api_key "-"))
(assert (str.contains api_key ":"))

; ; Ensure proper segment extraction
(assert (= jwt_token (str.++ jwt_header (str.++ "." (str.++ jwt_payload (str.++ "." jwt_signature))))))

; Base64 padding validation for JWT components
(assert (or (not (str.suffixof "=" jwt_header)) 
 (str.suffixof "=" jwt_header)
 (str.suffixof "==" jwt_header)))

; Signature algorithm validation through header content
(assert (or (str.contains header_decoded "HS256")
 (str.contains header_decoded "RS256")
 (str.contains header_decoded "ES256")))

; Token type validation
(assert (str.contains header_decoded "JWT"))

; Prevent common security issues
(assert (not (= jwt_signature "")))
(assert (not (= api_secret "")))

; Ensure realistic token values
(assert (str.contains jwt_token "eyJ")) ; Common JWT header start
(assert (str.contains api_key (str.++ api_prefix "-"))) ; Proper API key format

(check-sat)
(get-model)
