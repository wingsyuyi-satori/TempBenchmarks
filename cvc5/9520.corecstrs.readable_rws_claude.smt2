(set-info :source |Authentication Token Validation - JWT and API key processing|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for JWT token components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)
(declare-fun header_decoded () String)
(declare-fun payload_decoded () String)

; Declare string variables for signature validation
(declare-fun signature_input () String)
(declare-fun expected_signature () String)
(declare-fun signing_key () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure validation - must have exactly 3 segments separated by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must be non-empty base64 encoded string
(assert (> (str.len jwt_header) 0))
(assert (str.contains base64_chars (str.at jwt_header 0)))

; JWT payload must be non-empty base64 encoded string
(assert (> (str.len jwt_payload) 0))
(assert (str.contains base64_chars (str.at jwt_payload 0)))

; JWT signature must be non-empty base64 encoded string
(assert (> (str.len jwt_signature) 0))
(assert (str.contains base64_chars (str.at jwt_signature 0)))

; API key format validation - expected format: "api-key:id-secret"
(assert (= (str.num_splits api_key ":") 2))
(assert (= api_key_prefix (str.split_at api_key ":" 0)))
(assert (= (str.split_rest api_key ":" 1) (str.++ api_key_id "-" api_key_secret)))

; API key prefix validation
(assert (= api_key_prefix "api-key"))

; ; API key ID and secret extraction using '-' delimiter
(assert (= (str.num_splits (str.split_at api_key ":" 1) "-") 2))
(assert (= api_key_id (str.split_at (str.split_at api_key ":" 1) "-" 0)))
(assert (= api_key_secret (str.split_at (str.split_at api_key ":" 1) "-" 1)))

; API key ID must be alphanumeric and at least 8 characters
(assert (>= (str.len api_key_id) 8))
(assert (<= (str.len api_key_id) 32))

; API key secret must be at least 16 characters
(assert (>= (str.len api_key_secret) 16))
(assert (<= (str.len api_key_secret) 64))

; Base64 validation constraints for JWT components
; Header should decode to valid JSON starting with '{'
(assert (str.prefixof "{" header_decoded))
(assert (str.contains header_decoded "alg"))
(assert (str.contains header_decoded "typ"))

; Payload should decode to valid JSON starting with '{'
(assert (str.prefixof "{" payload_decoded))
(assert (str.contains payload_decoded "iat"))
(assert (str.contains payload_decoded "exp"))

; Signature verification constraints
; Signature input is header + '.' + payload
(assert (= signature_input (str.++ jwt_header "." jwt_payload)))

; Signing key must be at least 256 bits (32 characters) for HS256
(assert (>= (str.len signing_key) 32))

; Expected signature relationship
(assert (str.prefixof "HS256" expected_signature))

; Cross-validation between JWT and API key
; If API key is present, it should be used in JWT payload
(assert (=> (> (str.len api_key) 0) 
 (str.contains payload_decoded api_key_id)))

; Temporal validation - ensure segments have proper lengths
(assert (and (>= (str.len jwt_header) 10)
 (<= (str.len jwt_header) 200)))

(assert (and (>= (str.len jwt_payload) 20)
 (<= (str.len jwt_payload) 1000)))

(assert (and (>= (str.len jwt_signature) 20)
 (<= (str.len jwt_signature) 100)))

; Security constraint - signature must not be empty or default
(assert (not (= jwt_signature "")))
(assert (not (= jwt_signature "signature")))
(assert (not (= jwt_signature "invalid")))

; API key format consistency
(assert (str.contains api_key ":"))
(assert (str.contains api_key "-"))

; Ensure proper delimiter usage in token structure
(assert (not (str.contains jwt_header ".")))
(assert (not (str.contains jwt_payload ".")))
(assert (not (str.contains jwt_signature ".")))

; Base64 padding validation - signatures should end properly
(assert (or (str.suffixof "=" jwt_signature)
 (str.suffixof "==" jwt_signature)
 (not (str.contains jwt_signature "="))))

; Additional security constraints
; JWT components should not contain control characters
(assert (not (str.contains jwt_header "\n")))
(assert (not (str.contains jwt_payload "\n")))
(assert (not (str.contains jwt_signature "\n")))

; API key should not contain spaces or special characters except allowed ones
(assert (not (str.contains api_key " ")))
(assert (not (str.contains api_key "\t")))

; Constraint to ensure this is a realistic scenario
(assert (str.prefixof "eyJ" jwt_header)) ; Typical base64 encoded JSON start
(assert (str.prefixof "api-key:" api_key))

(check-sat)
(exit)
(get-model)
