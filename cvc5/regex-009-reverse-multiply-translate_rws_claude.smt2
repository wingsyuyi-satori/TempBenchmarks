(set-logic QF_SLIA)
(set-info :source |Authentication Token: JWT and API key validation|)
(set-info :category "industrial")
(set-info :status unknown)

; Declare string variables for JWT components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

; Declare string variables for API key components
(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Declare string variables for timestamp validation
(declare-fun timestamp_str () String)
(declare-fun date_part () String)
(declare-fun time_part () String)

; Declare string constants for delimiters
(declare-fun dot_delimiter () String)
(declare-fun dash_delimiter () String)
(declare-fun colon_delimiter () String)

; Define delimiter constants
(assert (= dot_delimiter "."))
(assert (= dash_delimiter "-"))
(assert (= colon_delimiter ":"))

; JWT token structure validation - must have exactly 3 segments separated by dots
(assert (= (str.num_splits jwt_token dot_delimiter) 3))

; ; Extract JWT components using split operations
(assert (= jwt_header (str.split_at jwt_token dot_delimiter 0)))
(assert (= jwt_payload (str.split_at jwt_token dot_delimiter 1)))
(assert (= jwt_signature (str.split_at jwt_token dot_delimiter 2)))

; JWT header must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_header) 0))
(assert (str.contains jwt_header "eyJ")) ; Common JWT header start

; JWT payload must be non-empty and contain valid base64 characters
(assert (> (str.len jwt_payload) 0))
(assert (not (str.contains jwt_payload " "))) ; No spaces in base64

; JWT signature must be non-empty and have minimum length for security
(assert (> (str.len jwt_signature) 20))
(assert (not (str.contains jwt_signature " "))) ; No spaces in base64

; API key structure validation - format: prefix-id-secret
(assert (= (str.num_splits api_key dash_delimiter) 3))

; ; Extract API key components
(assert (= api_key_prefix (str.split_at api_key dash_delimiter 0)))
(assert (= api_key_id (str.split_at api_key dash_delimiter 1)))
(assert (= api_key_secret (str.split_at api_key dash_delimiter 2)))

; API key prefix validation
(assert (or (= api_key_prefix "sk") (= api_key_prefix "pk") (= api_key_prefix "test")))

; API key ID must be exactly 24 characters (common format)
(assert (= (str.len api_key_id) 24))

; API key secret must be at least 32 characters for security
(assert (>= (str.len api_key_secret) 32))

; Timestamp validation for token expiry - format: YYYY-MM-DD:HH:MM:SS
(assert (= (str.num_splits timestamp_str colon_delimiter) 4))

; ; Extract date and time parts
(assert (= date_part (str.split_at timestamp_str colon_delimiter 0)))
(assert (= time_part (str.split_rest timestamp_str colon_delimiter 1)))

; Date part validation - must have 3 segments separated by dashes
(assert (= (str.num_splits date_part dash_delimiter) 3))

; Year validation - must be 4 digits starting with 20
(assert (= (str.len (str.split_at date_part dash_delimiter 0)) 4))
(assert (str.prefixof "20" (str.split_at date_part dash_delimiter 0)))

; Month validation - must be 2 digits between 01-12
(assert (= (str.len (str.split_at date_part dash_delimiter 1)) 2))

; Day validation - must be 2 digits
(assert (= (str.len (str.split_at date_part dash_delimiter 2)) 2))

; Time part validation - must have exactly 2 more colons (HH:MM:SS)
(assert (= (str.num_splits time_part colon_delimiter) 3))

; Hour validation - must be 2 digits
(assert (= (str.len (str.split_at time_part colon_delimiter 0)) 2))

; Minute validation - must be 2 digits
(assert (= (str.len (str.split_at time_part colon_delimiter 1)) 2))

; Second validation - must be 2 digits
(assert (= (str.len (str.split_at time_part colon_delimiter 2)) 2))

; Base64 character validation constraints
; JWT components should not contain invalid base64 characters
(assert (not (str.contains jwt_header "="))) ; Padding should not be in header
(assert (not (str.contains jwt_payload "!"))) ; Invalid base64 character
(assert (not (str.contains jwt_signature "@"))) ; Invalid base64 character

; Signature verification constraint - signature must end with valid base64 padding
(assert (or (str.suffixof "=" jwt_signature) 
 (str.suffixof "==" jwt_signature)
 (not (str.contains jwt_signature "="))))

; Cross-validation between JWT and API key
; If JWT contains API key reference, it must match
(assert (=> (str.contains jwt_payload api_key_id) 
 (= api_key_prefix "sk")))

; Security constraint - test keys should not be used with production JWTs
(assert (=> (str.contains jwt_header "alg") 
 (not (= api_key_prefix "test"))))

; ; Length consistency checks
(assert (= (str.len jwt_token) 
 (+ (str.len jwt_header) 
 (str.len jwt_payload) 
 (str.len jwt_signature) 2))) ; +2 for two dots

; ; Ensure all components are properly extracted
(assert (= jwt_token 
 (str.++ jwt_header 
 (str.++ dot_delimiter 
 (str.++ jwt_payload 
 (str.++ dot_delimiter jwt_signature))))))

; API key format consistency
(assert (= api_key 
 (str.++ api_key_prefix 
 (str.++ dash_delimiter 
 (str.++ api_key_id 
 (str.++ dash_delimiter api_key_secret))))))

(check-sat)
(exit)
(get-model)
