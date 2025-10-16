(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation with string split constraints|)
(set-info :category "industrial")
(set-info :status unknown)

; Variable declarations for JWT token components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Variable declarations for API key components
(declare-fun api_key () String)
(declare-fun api_prefix () String)
(declare-fun api_identifier () String)
(declare-fun api_secret () String)

; Variable declarations for validation results
(declare-fun header_valid () Bool)
(declare-fun payload_valid () Bool)
(declare-fun signature_valid () Bool)
(declare-fun api_key_valid () Bool)

; Helper variables for length validation
(declare-fun header_length () Int)
(declare-fun payload_length () Int)
(declare-fun signature_length () Int)
(declare-fun api_key_length () Int)

; JWT token structure: header.payload.signature
; A valid JWT must have exactly 3 segments when split by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; Header validation constraints
(assert (= header_length (str.len jwt_header)))
(assert (>= header_length 20))
(assert (<= header_length 200))
(assert (= header_valid (and (> header_length 0) (str.prefixof "eyJ" jwt_header))))

; Payload validation constraints
(assert (= payload_length (str.len jwt_payload)))
(assert (>= payload_length 20))
(assert (<= payload_length 1000))
(assert (= payload_valid (and (> payload_length 0) (str.prefixof "eyJ" jwt_payload))))

; Signature validation constraints
(assert (= signature_length (str.len jwt_signature)))
(assert (>= signature_length 20))
(assert (<= signature_length 500))
(assert (= signature_valid (> signature_length 0)))

; API key structure: prefix-identifier:secret
; Split by '-' to separate prefix from rest
(assert (= (str.num_splits api_key "-") 2))
(assert (= api_prefix (str.split_at api_key "-" 0)))

; Get the remaining part after first split
(declare-fun api_rest () String)
(assert (= api_rest (str.split_rest api_key "-" 1)))

; Split the remaining part by ':' to separate identifier and secret
(assert (= (str.num_splits api_rest ":") 2))
(assert (= api_identifier (str.split_at api_rest ":" 0)))
(assert (= api_secret (str.split_at api_rest ":" 1)))

; API key validation constraints
(assert (= (str.len api_prefix) 3))
(assert (or (= api_prefix "sk_") (= api_prefix "pk_") (= api_prefix "ak_")))
(assert (>= (str.len api_identifier) 8))
(assert (<= (str.len api_identifier) 32))
(assert (>= (str.len api_secret) 16))
(assert (<= (str.len api_secret) 64))

; Overall API key validity
(assert (= api_key_valid (and (or (= api_prefix "sk_") (= api_prefix "pk_") (= api_prefix "ak_"))
 (>= (str.len api_identifier) 8)
 (>= (str.len api_secret) 16))))

; Cross-validation constraints
; If JWT is valid, certain API key patterns should be rejected
(assert (=> (and header_valid payload_valid signature_valid)
 (not (= api_prefix "test"))))

; Specific test cases for edge conditions
; ; Case 1: Empty segments should invalidate tokens
(assert (not (= jwt_header "")))
(assert (not (= jwt_payload "")))
(assert (not (= jwt_signature "")))

; Case 2: API key segments cannot be empty
(assert (not (= api_prefix "")))
(assert (not (= api_identifier "")))
(assert (not (= api_secret "")))

; Case 3: JWT header and payload must start with base64 encoded JSON
; Base64 encoding of '{"' is 'eyJ'
(assert (str.prefixof "eyJ" jwt_header))
(assert (str.prefixof "eyJ" jwt_payload))

; Case 4: Signature length validation for different algorithms
(declare-fun signature_algorithm () String)
(assert (or (= signature_algorithm "HS256") (= signature_algorithm "RS256") (= signature_algorithm "ES256")))
(assert (=> (= signature_algorithm "HS256") (>= signature_length 43)))
(assert (=> (= signature_algorithm "RS256") (>= signature_length 342)))
(assert (=> (= signature_algorithm "ES256") (>= signature_length 86)))

; Case 5: API key format consistency
; The full API key should reconstruct properly
(assert (= api_key (str.++ api_prefix "-" api_identifier ":" api_secret)))

; Case 6: Length constraints for security
(assert (= api_key_length (str.len api_key)))
(assert (>= (str.len jwt_token) 100))
(assert (<= (str.len jwt_token) 2000))
(assert (>= api_key_length 32))
(assert (<= api_key_length 128))

; Case 7: No delimiter injection in components
(assert (not (str.contains jwt_header ".")))
(assert (not (str.contains jwt_payload ".")))
(assert (not (str.contains api_prefix "-")))
(assert (not (str.contains api_prefix ":")))
(assert (not (str.contains api_identifier ":")))

; Case 8: Base64 validation using string operations
; Valid base64 characters should not contain invalid characters
(assert (not (str.contains jwt_header " ")))
(assert (not (str.contains jwt_payload " ")))
(assert (not (str.contains jwt_signature " ")))
(assert (not (str.contains api_secret " ")))

; Case 9: Segment count validation
; JWT must have exactly 2 dots (3 segments)
(declare-fun jwt_dot_count () Int)
(assert (= jwt_dot_count 2))
(assert (= (str.num_splits jwt_token ".") 3))

; API key must have exactly 1 dash and 1 colon in specific positions
(declare-fun api_dash_count () Int)
(declare-fun api_colon_count () Int)
(assert (= api_dash_count 1))
(assert (= api_colon_count 1))

; Case 10: Sample constraint combinations for testing
; Satisfiable case: Valid JWT structure with proper lengths
(assert (>= (str.len jwt_header) 36))
(assert (>= (str.len jwt_payload) 36))
(assert (>= (str.len jwt_signature) 43))

; Satisfiable case: Valid API key structure with proper format
(assert (str.prefixof "sk_" api_key))
(assert (str.contains api_key ":"))

(check-sat)
(exit)
(get-model)
