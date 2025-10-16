(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun header_part () String)
(declare-fun payload_part () String)
(declare-fun signature_part () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_identifier () String)
(declare-fun api_secret () String)

; Declare string variables for timestamp validation
(declare-fun timestamp_field () String)
(declare-fun hours () String)
(declare-fun minutes () String)
(declare-fun seconds () String)

; JWT token structure validation - must have exactly 3 parts separated by dots
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using dot delimiter
(assert (= header_part (str.split_at jwt_token "." 0)))
(assert (= payload_part (str.split_at jwt_token "." 1)))
(assert (= signature_part (str.split_at jwt_token "." 2)))

; JWT header and payload must be non-empty strings
(assert (> (str.len header_part) 0))
(assert (> (str.len payload_part) 0))
(assert (> (str.len signature_part) 0))

; JWT signature validation - signature part must be at least 32 characters for security
(assert (>= (str.len signature_part) 32))

; API key validation - must have exactly 2 parts separated by hyphen
(assert (= (str.num_splits api_key "-") 2))

; ; Extract API key prefix and remaining part
(assert (= api_prefix (str.split_at api_key "-" 0)))
(declare-fun api_remaining () String)
(assert (= api_remaining (str.split_at api_key "-" 1)))

; API remaining part must have exactly 2 parts separated by colon
(assert (= (str.num_splits api_remaining ":") 2))

; ; Extract API identifier and secret using colon delimiter
(assert (= api_identifier (str.split_at api_remaining ":" 0)))
(assert (= api_secret (str.split_at api_remaining ":" 1)))

; API key component validation
(assert (= api_prefix "ak"))
(assert (= (str.len api_identifier) 16))
(assert (= (str.len api_secret) 32))

; ; Base64 validation constraints - check for valid base64 characters only
(assert (not (str.contains header_part " ")))
(assert (not (str.contains payload_part " ")))
(assert (not (str.contains signature_part " ")))

; Ensure no invalid characters in base64 segments
(assert (not (str.contains header_part "@")))
(assert (not (str.contains payload_part "@")))
(assert (not (str.contains signature_part "@")))

; Cross-validation: JWT payload should reference API identifier
(assert (str.contains payload_part api_identifier))

; ; Security constraint: signature verification simulation
(assert (not (str.contains signature_part "invalid")))
(assert (not (str.contains signature_part "expired")))

; Timestamp validation using colon delimiter
(assert (str.contains payload_part timestamp_field))
(assert (= (str.num_splits timestamp_field ":") 3))

; ; Extract timestamp components using colon delimiter
(assert (= hours (str.split_at timestamp_field ":" 0)))
(assert (= minutes (str.split_at timestamp_field ":" 1)))
(assert (= seconds (str.split_at timestamp_field ":" 2)))

; Timestamp component length validation
(assert (= (str.len hours) 2))
(assert (= (str.len minutes) 2))
(assert (= (str.len seconds) 2))

; Additional security constraints
(assert (not (= header_part payload_part)))
(assert (not (= payload_part signature_part)))
(assert (not (= header_part signature_part)))

; Ensure API secret is different from identifier
(assert (not (= api_identifier api_secret)))

; Constraint on segment count consistency
(declare-fun total_jwt_segments () Int)
(assert (= total_jwt_segments (str.num_splits jwt_token ".")))
(assert (= total_jwt_segments 3))

; Constraint on API key segment count consistency
(declare-fun total_api_segments () Int)
(assert (= total_api_segments (str.num_splits api_key "-")))
(assert (= total_api_segments 2))

; Test with specific valid token structure
(assert (= jwt_token "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwYWJjZGVmIn0.abcdef1234567890123456789012345678901234567890"))
(assert (= api_key "ak-1234567890abcdef:a1b2c3d4e5f67890123456789012abcd"))
(assert (= timestamp_field "12:34:56"))

(check-sat)
(exit)
(get-model)
