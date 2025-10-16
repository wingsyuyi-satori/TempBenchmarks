; SMT-LIB2 file for Authentication Token: JWT and API key validation
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare string variables for tokens and keys
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT must have three segments separated by '.'
; ; Example: header.payload.signature
(define-fun num_jwt_segments () Int (str.num_splits jwt_token "."))

; ; JWT: extract segments
(define-fun jwt_header () String (str.split_at jwt_token "." 0))
(define-fun jwt_payload () String (str.split_at jwt_token "." 1))
(define-fun jwt_signature () String (str.split_at jwt_token "." 2))

; API key format: prefix-id:secret (e.g., API-1234:abcdEFGH)
; Delimiter order: '-' between prefix and id, ':' between id and secret
(define-fun num_api_dash_segments () Int (str.num_splits api_key "-"))
(define-fun api_prefix () String (str.split_at api_key "-" 0))
(define-fun api_rest () String (str.split_rest api_key "-" 1))

(define-fun num_api_colon_segments () Int (str.num_splits api_rest ":"))
(define-fun api_id () String (str.split_at api_rest ":" 0))
(define-fun api_secret () String (str.split_at api_rest ":" 1))

; ---------------------
; Base64 Validation (simplified)
; JWT header and payload are base64url, so must contain only [A-Za-z0-9_-]
; ; Let's check that they do NOT contain invalid base64 characters (for demonstration)
; ; For this example, suppose '+' and '/' are invalid in JWT base64url

(assert (not (str.contains jwt_header "+")))
(assert (not (str.contains jwt_header "/")))
(assert (not (str.contains jwt_payload "+")))
(assert (not (str.contains jwt_payload "/")))

; API secret (simulate base64: must not contain '=' or ':', and only alphanumerics)
(assert (not (str.contains api_secret "=")))
(assert (not (str.contains api_secret ":")))
; ; Check that api_secret is at least length 6 (for realism)
(assert (<= 6 (str.len api_secret)))

; ---------------------
; ; JWT Signature Checking: JWT signature must not be empty
(assert (< 0 (str.len jwt_signature)))

; ; API key signature check: prefix must be "API"
(assert (= api_prefix "API"))

; ---------------------
; ; Satisfiable constraints example
; JWT has exactly 3 segments
(assert (= num_jwt_segments 3))
; API key has format: prefix-id:secret, so must have 2 dash segments and 2 colon segments after dash
(assert (= num_api_dash_segments 2))
(assert (= num_api_colon_segments 2))

; JWT header must be "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" (valid base64url, no '+' or '/')
(assert (= jwt_header "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9"))
; JWT payload must not be empty
(assert (< 0 (str.len jwt_payload)))
; JWT signature must not be "invalid"
(assert (not (= jwt_signature "invalid")))

; API id must be numeric
(assert (forall ((c String))
 (=> (and (<= 0 (str.len api_id)) (<= (str.len api_id) 10))
 (let ((first_char (str.at api_id 0)))
 (or (= api_id "") (and (<= (str.to_code first_char) 57) (<= 48 (str.to_code first_char))))
)
)
))

; ---------------------
; Unsatisfiable scenario: JWT must have 3 segments, but force a different count
(assert (not (= num_jwt_segments 2)))

(check-sat)
(exit)
(get-model)
