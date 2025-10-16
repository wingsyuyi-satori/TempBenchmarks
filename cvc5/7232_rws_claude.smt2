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
(declare-fun api_id () String)
(declare-fun api_secret () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation - must have exactly 3 segments when split by dot
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT token length constraints for realistic tokens
(assert (>= (str.len jwt_token) 100))
(assert (<= (str.len jwt_token) 2048))

; Base64 validation for JWT header
(assert (>= (str.len jwt_header) 20))
(assert (<= (str.len jwt_header) 200))

; Base64 validation for JWT payload
(assert (>= (str.len jwt_payload) 50))
(assert (<= (str.len jwt_payload) 1500))

; Base64 validation for JWT signature
(assert (>= (str.len jwt_signature) 40))
(assert (<= (str.len jwt_signature) 400))

; API key structure validation - format: prefix-id:secret
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits api_key ":") 2))

; ; Extract API key prefix (before first hyphen)
(assert (= api_prefix (str.split_at api_key "-" 0)))

; ; Extract remaining part after first hyphen for further processing
(assert (= (str.num_splits (str.split_rest api_key "-" 1) ":") 2))

; ; Extract API key ID and secret parts
(assert (= api_id (str.split_at (str.split_rest api_key "-" 1) ":" 0)))
(assert (= api_secret (str.split_at (str.split_rest api_key "-" 1) ":" 1)))

; API key component length validation
(assert (>= (str.len api_prefix) 2))
(assert (<= (str.len api_prefix) 10))
(assert (>= (str.len api_id) 8))
(assert (<= (str.len api_id) 32))
(assert (>= (str.len api_secret) 16))
(assert (<= (str.len api_secret) 64))

; ; Signature checking constraints - signature must not be empty
(assert (not (= jwt_signature "")))
(assert (not (str.contains jwt_signature ".")))
(assert (not (str.contains jwt_signature ":")))
(assert (not (str.contains jwt_signature "-")))

; Cross-validation between JWT and API key
(assert (not (= jwt_token api_key)))
(assert (> (str.len jwt_token) (str.len api_key)))

; Security constraint - tokens must not contain test patterns
(assert (not (str.contains jwt_token "test")))
(assert (not (str.contains jwt_token "demo")))
(assert (not (str.contains api_key "test")))
(assert (not (str.contains api_key "demo")))

; Additional segment count validation for malformed tokens
(assert (not (= (str.num_splits jwt_token ".") 1)))
(assert (not (= (str.num_splits jwt_token ".") 2)))
(assert (not (= (str.num_splits jwt_token ".") 4)))

; Ensure API key has proper structure with both delimiters
(assert (and (str.contains api_key "-") (str.contains api_key ":")))
(assert (< (str.indexof api_key "-" 0) (str.indexof api_key ":" 0)))

; Signature integrity - must not be weak signatures
(assert (not (= jwt_signature "AAAA")))
(assert (not (= jwt_signature "1234")))

; ; Final validation - ensure all components are properly extracted
(assert (not (= jwt_header "")))
(assert (not (= jwt_payload "")))
(assert (not (= api_prefix "")))
(assert (not (= api_id "")))
(assert (not (= api_secret "")))

; Base64 character validation for header start
(assert (str.contains base64_chars (str.substr jwt_header 0 1)))

; Base64 character validation for payload start 
(assert (str.contains base64_chars (str.substr jwt_payload 0 1)))

; Ensure proper delimiter usage in split operations
(assert (str.contains jwt_token "."))
(assert (str.contains api_key "-"))
(assert (str.contains api_key ":"))

(check-sat)
(exit)
(get-model)
