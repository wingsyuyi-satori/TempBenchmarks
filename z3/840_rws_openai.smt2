; SMT-LIB2 file for Authentication Token: JWT and API Key Validation
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare strings representing tokens
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; Declare constants for delimiters
(define-fun dot_delim () String ".")
(define-fun dash_delim () String "-")
(define-fun colon_delim () String ":")

; ; Example base64 alphabet (a simple one for illustration)
(define-fun base64_chars () String "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=")

; ; Helper: checks if a string consists only of base64 characters
(define-fun is_base64 ((s String)) Bool
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (str.contains base64_chars (str.at s i)))))

; JWT tokens: three segments separated by '.'
(assert (= (str.num_splits jwt_token dot_delim) 3))

; JWT: header and payload must be base64, signature can be base64 or empty
(define-fun jwt_header () String (str.split_at jwt_token dot_delim 0))
(define-fun jwt_payload () String (str.split_at jwt_token dot_delim 1))
(define-fun jwt_signature () String (str.split_at jwt_token dot_delim 2))

(assert (is_base64 jwt_header))
(assert (is_base64 jwt_payload))
(assert (or (= jwt_signature "") (is_base64 jwt_signature)))

; JWT signature must not be empty for a valid token
(assert (not (= jwt_signature "")))

; ; JWT signature is not equal to header or payload (simplified signature check)
(assert (distinct jwt_signature jwt_header))
(assert (distinct jwt_signature jwt_payload))

; API key format: 2 segments separated by '-'
(assert (= (str.num_splits api_key dash_delim) 2))

; API key: first segment is key ID (alphanumeric), second is secret (base64)
(define-fun api_key_id () String (str.split_at api_key dash_delim 0))
(define-fun api_key_secret () String (str.split_at api_key dash_delim 1))

; ; Helper: checks if a string is alphanumeric
(define-fun alphanum_chars () String "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789")
(define-fun is_alphanum ((s String)) Bool
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (str.contains alphanum_chars (str.at s i)))))

(assert (is_alphanum api_key_id))
(assert (is_base64 api_key_secret))

; API key secret must not be empty
(assert (not (= api_key_secret "")))

; Relation: the JWT signature is not equal to the API key secret
(assert (distinct jwt_signature api_key_secret))

; Unsatisfiable scenario: JWT header and payload are equal (not allowed in real JWTs)
 (assert (= jwt_header jwt_payload))
 (check-sat)


(get-model)
