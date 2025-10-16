(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :smt-lib-version 2.6)
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
(declare-fun api_version () String)

; Declare string variables for base64 validation
(declare-fun base64_chars () String)
(declare-fun header_decoded () String)
(declare-fun payload_decoded () String)

; Define base64 character set for validation
(assert (= base64_chars "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/="))

; JWT token structure constraints - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT header must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_header) 0))
(assert (str.contains base64_chars (str.at jwt_header 0)))
(assert (str.contains base64_chars (str.at jwt_header (- (str.len jwt_header) 1))))

; JWT payload must be non-empty and longer than header
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_payload) (str.len jwt_header)))

; JWT signature validation - must be exactly 43 characters for RS256
(assert (= (str.len jwt_signature) 43))
(assert (not (str.contains jwt_signature ".")))
(assert (not (str.contains jwt_signature "-")))

; API key structure - format: prefix-version:secret
(assert (= (str.num_splits api_key "-") 2))
(assert (= (str.num_splits api_key ":") 2))

; ; Extract API key components
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_version (str.split_at (str.split_at api_key ":" 0) "-" 1)))
(assert (= api_secret (str.split_at api_key ":" 1)))

; API prefix validation - must be "sk" for secret keys
(assert (= api_prefix "sk"))

; API version validation - must be numeric
(assert (or (= api_version "1") (= api_version "2") (= api_version "3")))

; API secret validation - must be at least 32 characters
(assert (>= (str.len api_secret) 32))
(assert (not (str.contains api_secret ":")))
(assert (not (str.contains api_secret "-")))

; Base64 validation for JWT components
; Header should start with eyJ (base64 encoded "{")
(assert (str.prefixof "eyJ" jwt_header))

; Payload should also start with eyJ for JSON objects
(assert (str.prefixof "eyJ" jwt_payload))

; Cross-validation constraints
(assert (not (= jwt_header jwt_payload)))
(assert (not (= jwt_header jwt_signature)))
(assert (not (= jwt_payload jwt_signature)))

; Token length constraints for security
(assert (> (str.len jwt_token) 100))
(assert (< (str.len jwt_token) 2048))
(assert (> (str.len api_key) 40))
(assert (< (str.len api_key) 128))

; Ensure tokens don't contain common invalid characters
(assert (not (str.contains jwt_token " ")))
(assert (not (str.contains jwt_token "\n")))
(assert (not (str.contains api_key " ")))
(assert (not (str.contains api_key "\n")))

; Signature verification constraint - signature should not be empty after base64 padding
(assert (not (str.suffixof "====" jwt_signature)))
(assert (not (str.suffixof "===" jwt_signature)))

; Additional security constraints
; JWT components should have minimum entropy (no repeated patterns)
(assert (not (str.contains jwt_header "aaaa")))
(assert (not (str.contains jwt_payload "aaaa")))
(assert (not (str.contains jwt_signature "aaaa")))

; API secret should not contain predictable patterns
(assert (not (str.contains api_secret "1234")))
(assert (not (str.contains api_secret "abcd")))
(assert (not (str.contains api_secret "0000")))

; Split rest validation - everything after first dot should contain payload and signature
(assert (str.contains (str.split_rest jwt_token "." 1) jwt_payload))
(assert (str.contains (str.split_rest jwt_token "." 1) jwt_signature))

; API key split rest validation
(assert (str.contains (str.split_rest api_key "-" 1) api_secret))
(assert (str.contains (str.split_rest api_key ":" 0) api_version))

(check-sat)
(exit)
(get-model)
