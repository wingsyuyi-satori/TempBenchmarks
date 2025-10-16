(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :status unknown)
(set-logic QF_SLIA)

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_suffix () String)

; Declare string variables for timestamp validation
(declare-fun timestamp_token () String)
(declare-fun date_part () String)
(declare-fun time_part () String)

; Declare additional variables for validation
(declare-fun jwt_payload_and_signature () String)
(declare-fun remaining_api_parts () String)

; JWT token structure validation - must have exactly 3 segments separated by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; JWT segment count validation
(assert (>= (str.num_splits jwt_token ".") 3))
(assert (<= (str.num_splits jwt_token ".") 3))

; ; Base64 validation - check minimum lengths for each JWT segment
(assert (>= (str.len jwt_header) 20))
(assert (>= (str.len jwt_payload) 20))
(assert (>= (str.len jwt_signature) 40))

; Base64 validation - no spaces or invalid characters
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_signature " ")))

; API key validation with hyphen delimiter
(assert (= (str.num_splits api_key "-") 2))
(assert (= api_prefix (str.split_at api_key "-" 0)))
(assert (= api_suffix (str.split_at api_key "-" 1)))

; API key prefix validation
(assert (str.prefixof "ak_" api_prefix))
(assert (= (str.len api_prefix) 8))

; API key suffix validation
(assert (= (str.len api_suffix) 32))

; Get remaining API key parts using split_rest
(assert (= remaining_api_parts (str.split_rest api_key "-" 1)))

; Timestamp token validation using colon delimiter
(assert (= (str.num_splits timestamp_token ":") 2))
(assert (= date_part (str.split_at timestamp_token ":" 0)))
(assert (= time_part (str.split_at timestamp_token ":" 1)))

; Date part validation - should be 8 digits for YYYYMMDD
(assert (= (str.len date_part) 8))

; Time part validation - should be 6 digits for HHMMSS
(assert (= (str.len time_part) 6))

; ; Signature checking - JWT signature should not be empty or common defaults
(assert (not (= jwt_signature "")))
(assert (not (= jwt_signature "signature")))
(assert (not (= jwt_signature "SIGNATURE")))
(assert (not (= jwt_signature "sign")))

; Cross-validation using split_rest for JWT payload and signature
(assert (= jwt_payload_and_signature (str.split_rest jwt_token "." 1)))
(assert (= (str.num_splits jwt_payload_and_signature ".") 2))

; Security constraints - tokens should not contain obvious test patterns
(assert (not (str.contains jwt_token "password")))
(assert (not (str.contains jwt_token "secret")))
(assert (not (str.contains api_key "test")))
(assert (not (str.contains api_key "demo")))

; API key and JWT should be different
(assert (not (= api_key jwt_token)))

; Timestamp should not be obviously fake
(assert (not (= timestamp_token "00000000:000000")))
(assert (not (= timestamp_token "99999999:999999")))

; JWT header should contain algorithm information
(assert (or (str.contains jwt_header "alg") (str.contains jwt_header "ALG")))

; ; Base64 validation - check for proper padding structure
(assert (or (str.suffixof "=" jwt_header) (str.suffixof "==" jwt_header) (not (str.contains jwt_header "="))))
(assert (or (str.suffixof "=" jwt_payload) (str.suffixof "==" jwt_payload) (not (str.contains jwt_payload "="))))
(assert (or (str.suffixof "=" jwt_signature) (str.suffixof "==" jwt_signature) (not (str.contains jwt_signature "="))))

; Additional segment count validation for edge cases
(assert (not (= (str.num_splits jwt_token ".") 0)))
(assert (not (= (str.num_splits jwt_token ".") 1)))
(assert (not (= (str.num_splits jwt_token ".") 2)))

; API key format validation
(assert (not (= (str.num_splits api_key "-") 0)))
(assert (not (= (str.num_splits api_key "-") 1)))

; Timestamp format validation
(assert (not (= (str.num_splits timestamp_token ":") 0)))
(assert (not (= (str.num_splits timestamp_token ":") 1)))

; ; Example concrete values for satisfiability
(assert (= jwt_token "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"))
(assert (= api_key "ak_live-1234567890abcdef1234567890abcdef"))
(assert (= timestamp_token "20240315:143022"))

(check-sat)
(get-model)
