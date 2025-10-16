; SMT-LIB2 file: Authentication Token Validation (JWT & API Key)
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)

; Declare string variables for tokens and components
(declare-fun jwt_token () String)
(declare-fun jwt_header () String)
(declare-fun jwt_payload () String)
(declare-fun jwt_signature () String)

(declare-fun api_key () String)
(declare-fun api_key_prefix () String)
(declare-fun api_key_id () String)
(declare-fun api_key_secret () String)

; Some base64 alphabet for validation (simplified for SMT reasoning)
(define-fun valid_base64 ((s String)) Bool
 (and
 (not (= s ""))
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (or
 (and (<= 65 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 90)) ; 'A'-'Z'
 (and (<= 97 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 122)) ; 'a'-'z'
 (and (<= 48 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 57)) ; '0'-'9'
 (= (str.at s i) "+")
 (= (str.at s i) "/")
 (= (str.at s i) "=")
)
)
)
)
)

; JWT tokens are typically three segments separated by '.'
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT segments
(assert (= jwt_header (str.split_at jwt_token "." 0)))
(assert (= jwt_payload (str.split_at jwt_token "." 1)))
(assert (= jwt_signature (str.split_at jwt_token "." 2)))

; Each JWT segment should be valid base64 (satisfiable case)
(assert (valid_base64 jwt_header))
(assert (valid_base64 jwt_payload))
(assert (valid_base64 jwt_signature))

; API key format: prefix-id:secret (e.g., "api-12345:abcdefg")
; ; Check segment count after '-' and ':'
(assert (>= (str.num_splits api_key "-") 2)) ; At least one '-' in prefix
(assert (= (str.num_splits api_key ":") 2)) ; Must have a ':' separating id and secret

; ; Extract API key pieces
(assert (= api_key_prefix (str.split_at api_key "-" 0)))
(assert (= api_key_id (str.split_at (str.split_rest api_key "-" 1) ":" 0)))
(assert (= api_key_secret (str.split_at api_key ":" 1)))

; API key prefix must be "api"
(assert (= api_key_prefix "api"))

; API key id: Must be all digits
(define-fun is_digits ((s String)) Bool
 (and
 (not (= s ""))
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len s)))
 (and (<= 48 (str.to_code (str.at s i))) (<= (str.to_code (str.at s i)) 57))
)
)
)
)
(assert (is_digits api_key_id))

; API key secret: at least 6 characters
(assert (>= (str.len api_key_secret) 6))

; ; Satisfiable scenario: Example values
(assert (= jwt_token "QWxhZGRpbjpPcGVuU2VzYW1l.Tm90UmVhbC5KdXN0VGVzdA.MTIzNDU2"))
(assert (= api_key "api-12345:abcdef"))

; Unsatisfiable scenario: JWT with only two segments (should have 3)
(declare-fun invalid_jwt_token () String)
(assert (= (str.num_splits invalid_jwt_token ".") 2))
(assert (= invalid_jwt_token "YXdzOmFzZC5zaWduYXR1cmU="))
; Try to force base64 validation on missing third segment (should be unsat)
(assert (valid_base64 (str.split_at invalid_jwt_token "." 2)))

; Unsatisfiable scenario: API key without "api" prefix
(declare-fun bad_api_key () String)
(assert (= bad_api_key "user-99999:secret12"))
(assert (not (= (str.split_at bad_api_key "-" 0) "api")))

(check-sat)
(exit)
(get-model)
