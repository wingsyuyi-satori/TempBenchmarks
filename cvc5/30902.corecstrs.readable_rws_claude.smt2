(set-logic QF_SLIA)
(set-info :source |Authentication Token JWT and API key validation|)
(set-info :category "industrial")

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_version () String)
(declare-fun api_secret () String)

; Declare helper variables for validation
(declare-fun temp_after_dash () String)
(declare-fun base64_sample () String)

; JWT token structure validation - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT segment count validation
(assert (> (str.len jwt_header) 0))
(assert (> (str.len jwt_payload) 0))
(assert (> (str.len jwt_signature) 0))

; JWT length constraints for realistic tokens
(assert (< (str.len jwt_header) 200))
(assert (< (str.len jwt_payload) 1000))
(assert (< (str.len jwt_signature) 200))

; API key structure validation - format: prefix-version:secret
(assert (= (str.num_splits api_key "-") 2))

; ; Extract first part after splitting by dash
(assert (= temp_after_dash (str.split_at api_key "-" 1)))
(assert (= (str.num_splits temp_after_dash ":") 2))

; ; Extract API key components
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_version (str.split_at temp_after_dash ":" 0)))
(assert (= api_secret (str.split_at temp_after_dash ":" 1)))

; API key prefix validation
(assert (= api_prefix "sk"))

; API key version must be non-empty
(assert (> (str.len api_version) 0))
(assert (< (str.len api_version) 5))

; API key secret length validation
(assert (> (str.len api_secret) 16))
(assert (< (str.len api_secret) 64))

; Base64 validation through character constraints
(assert (= base64_sample "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))

; JWT header base64 validation - must contain only alphanumeric and +/= chars
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_header "\n")))
(assert (not (str.contains jwt_header "\t")))

; JWT payload base64 validation
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_payload "\n")))

; JWT signature base64 validation
(assert (not (str.contains jwt_signature " ")))
(assert (not (str.contains jwt_signature "\n")))

; API secret base64 validation
(assert (not (str.contains api_secret " ")))
(assert (not (str.contains api_secret "\n")))

; ; Signature checking - JWT components must be properly formatted
(assert (str.contains jwt_header "eyJ"))
(assert (str.contains jwt_payload "eyJ"))

; JWT payload must contain standard claims
(assert (str.contains jwt_payload "exp"))
(assert (str.contains jwt_payload "iat"))

; API version should be numeric
(assert (str.contains "0123456789" (str.at api_version 0)))

; Security constraints - tokens must not be identical
(assert (not (= jwt_header jwt_payload)))
(assert (not (= jwt_header jwt_signature)))
(assert (not (= jwt_payload jwt_signature)))

; Cross-validation between components
(assert (> (str.len (str.split_rest jwt_token "." 1)) (str.len jwt_signature)))

; Ensure proper reconstruction
(assert (= jwt_token (str.++ (str.++ jwt_header ".") (str.++ jwt_payload ".") jwt_signature)))
(assert (= api_key (str.++ (str.++ api_prefix "-") (str.++ api_version ":") api_secret)))

; Additional segment count validation
(assert (= (str.num_splits (str.split_rest jwt_token "." 1) ".") 2))

; Base64 padding validation - proper length constraints
(assert (= (mod (str.len jwt_header) 4) 0))
(assert (= (mod (str.len jwt_payload) 4) 0))

; Token must be sufficiently long for security
(assert (> (str.len jwt_token) 50))
(assert (> (str.len api_key) 25))

(check-sat)
(exit)
(get-model)
