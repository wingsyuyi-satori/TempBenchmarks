(set-logic QF_SLIA)
(set-info :source |Authentication Token Validation: JWT and API key processing|)

; Variable declarations for JWT token components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Variable declarations for API key components
(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_secret () String)
(declare-fun api_key_id () String)

; Variable declarations for base64 validation helpers
(declare-fun header_first_char () String)
(declare-fun payload_first_char () String)
(declare-fun signature_last_char () String)

; Constants for delimiters
(declare-fun dot_delimiter () String)
(declare-fun dash_delimiter () String)
(declare-fun colon_delimiter () String)

; Define delimiter constants
(assert (= dot_delimiter "."))
(assert (= dash_delimiter "-"))
(assert (= colon_delimiter ":"))

; JWT token structure validation - must have exactly 3 segments when split by dot
(assert (= (str.num_splits jwt_token dot_delimiter) 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token dot_delimiter 0)))
(assert (= jwt_payload (str.split_at jwt_token dot_delimiter 1)))
(assert (= jwt_signature (str.split_at jwt_token dot_delimiter 2)))

; JWT segment count validation
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; JWT signature length validation for base64 encoding
(assert (>= (str.len jwt_signature) 40))
(assert (<= (str.len jwt_signature) 50))

; ; Base64 validation - check first characters contain valid base64 chars
(assert (= header_first_char (str.substr jwt_header 0 1)))
(assert (= payload_first_char (str.substr jwt_payload 0 1)))
(assert (= signature_last_char (str.substr jwt_signature (- (str.len jwt_signature) 1) 1)))

; Base64 character validation for headers
(assert (or (= header_first_char "e") (= header_first_char "A") (= header_first_char "I")))
(assert (or (= payload_first_char "e") (= payload_first_char "A") (= payload_first_char "I")))

; API key structure validation - format: prefix:secret
(assert (>= (str.num_splits api_key colon_delimiter) 2))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key colon_delimiter 0)))
(assert (= api_key_secret (str.split_at api_key colon_delimiter 1)))

; API key prefix should contain dash separator
(assert (>= (str.num_splits api_key_prefix dash_delimiter) 2))

; API key secret should contain ID part separated by dash
(assert (>= (str.num_splits api_key_secret dash_delimiter) 2))
(assert (= api_key_id (str.split_at api_key_secret dash_delimiter 0)))

; Length validations for security
(assert (>= (str.len api_key_prefix) 5))
(assert (>= (str.len api_key_secret) 20))
(assert (>= (str.len api_key_id) 8))

; JWT payload must be longer than header for valid token structure
(assert (>= (str.len jwt_payload) (str.len jwt_header)))

; ; Signature checking - signature should not be trivial
(assert (not (= jwt_signature "signature")))
(assert (not (= jwt_signature "")))

; API key validation - prefix should follow standard patterns
(assert (or 
 (str.prefixof "sk" api_key_prefix)
 (str.prefixof "pk" api_key_prefix)
 (str.prefixof "ak" api_key_prefix)))

; Base64 padding validation for JWT signature
(assert (or 
 (str.suffixof "=" signature_last_char)
 (str.contains "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789" signature_last_char)))

; Cross-validation between JWT and API key lengths
(assert (>= (str.len jwt_token) 50))
(assert (>= (str.len api_key) 25))

; Ensure proper token structure with all three JWT parts present
(assert (= (str.len jwt_token) 
 (+ (str.len jwt_header) 
 (+ (str.len jwt_payload) 
 (+ (str.len jwt_signature) 2)))))

; API key secret complexity validation
(assert (>= (str.len (str.split_rest api_key_secret dash_delimiter 1)) 10))

; Security constraint - tokens should have minimum entropy
(assert (and
 (>= (str.len jwt_header) 20)
 (>= (str.len jwt_payload) 30)
 (>= (str.len jwt_signature) 40)))

(check-sat)
(exit)
(get-model)
