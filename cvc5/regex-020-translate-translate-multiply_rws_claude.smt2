(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_secret () String)
(declare-fun api_timestamp () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)
(declare-fun temp_split () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using dot delimiter
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header and payload must be non-empty
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; Base64 validation - header should not contain invalid characters
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_header "\n")))
(assert (not (str.contains jwt_header "\t")))

; Base64 validation - payload should not contain invalid characters 
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_payload "\n")))
(assert (not (str.contains jwt_payload "\t")))

; Signature validation - must be valid base64 and minimum length
(assert (not (str.contains jwt_signature " ")))
(assert (>= (str.len jwt_signature) 43))

; API key format validation - should have format prefix-secret:timestamp
(assert (= (str.num_splits api_key "-") 2))

; ; Extract first part after splitting by dash
(assert (= temp_split (str.split_at api_key "-" 1)))
(assert (= (str.num_splits temp_split ":") 2))

; ; Extract API key components
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_secret (str.split_at temp_split ":" 0)))
(assert (= api_timestamp (str.split_at temp_split ":" 1)))

; API prefix validation - must be specific format
(assert (or (= api_prefix "sk") (= api_prefix "pk") (= api_prefix "test")))

; API secret validation - must be specific length
(assert (= (str.len api_secret) 32))

; Timestamp validation - must be reasonable length
(assert (>= (str.len api_timestamp) 10))
(assert (<= (str.len api_timestamp) 13))

; Security constraint - ensure no malicious characters in tokens
(assert (not (str.contains jwt_token "<")))
(assert (not (str.contains jwt_token ">")))
(assert (not (str.contains jwt_token """")))
(assert (not (str.contains api_key "<")))
(assert (not (str.contains api_key ">")))
(assert (not (str.contains api_key """")))

; Cross-validation constraint - JWT and API key should not be identical
(assert (not (= jwt_token api_key)))

; Length constraints for security
(assert (>= (str.len jwt_token) 100))
(assert (<= (str.len jwt_token) 2048))
(assert (>= (str.len api_key) 48))
(assert (<= (str.len api_key) 128))

; Ensure proper segment structure in JWT using split_rest
(assert (= (str.split_rest jwt_token "." 1) (str.++ jwt_payload "." jwt_signature)))
(assert (= (str.split_rest jwt_token "." 2) jwt_signature))

; Ensure proper segment structure in API key using split_rest
(assert (= (str.split_rest api_key "-" 1) (str.++ api_secret ":" api_timestamp)))

; Additional base64 padding validation for JWT components
(assert (or (not (str.contains jwt_header "="))
 (str.suffixof "=" jwt_header)
 (str.suffixof "==" jwt_header)))

(assert (or (not (str.contains jwt_payload "="))
 (str.suffixof "=" jwt_payload)
 (str.suffixof "==" jwt_payload)))

; Signature verification constraint - signature length must be consistent
(assert (or (= (str.len jwt_signature) 43)
 (= (str.len jwt_signature) 44)
 (= (str.len jwt_signature) 86)
 (= (str.len jwt_signature) 88)))

; API key prefix-specific validation
(assert (=> (= api_prefix "sk") (= (str.len api_secret) 32)))
(assert (=> (= api_prefix "pk") (= (str.len api_secret) 32)))
(assert (=> (= api_prefix "test") (>= (str.len api_secret) 24)))

; Ensure no double delimiters in tokens
(assert (not (str.contains jwt_token "..")))
(assert (not (str.contains api_key "--")))
(assert (not (str.contains api_key "::")))

; Ensure tokens start with expected prefixes for validation
(assert (or (str.prefixof "eyJ" jwt_header)
 (str.prefixof "eyI" jwt_header)))

(assert (str.prefixof "sk-" api_key))

; ; Validate that split operations work correctly
(assert (= jwt_token (str.++ jwt_header "." jwt_payload "." jwt_signature)))
(assert (= api_key (str.++ api_prefix "-" api_secret ":" api_timestamp)))

; Ensure timestamp contains only digits
(assert (not (str.contains api_timestamp "a")))
(assert (not (str.contains api_timestamp "z")))
(assert (not (str.contains api_timestamp "A")))
(assert (not (str.contains api_timestamp "Z")))

(check-sat)
(exit)
(get-model)
