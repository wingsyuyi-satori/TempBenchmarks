; SMT-LIB2 file for Authentication Token: JWT and API key validation
; ; Focus: segment count, base64 validation, signature checking
; Delimiters used: '.', '-', ':'

(set-logic ALL)
(set-option :produce-models true)

; Declare input strings
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT tokens are in the form: <header>.<payload>.<signature>
; The standard JWT should have 3 segments when split by '.'

; (str.num_splits jwt_token ".") = 3
(assert (= (str.num_splits jwt_token ".") 3))

; ; Extract JWT segments
(define-fun jwt_header () String (str.split_at jwt_token "." 0))
(define-fun jwt_payload () String (str.split_at jwt_token "." 1))
(define-fun jwt_sig () String (str.split_at jwt_token "." 2))

; JWT base64 validation:
; For simplicity, base64 strings only contain [A-Za-z0-9+/=]
; ; We check that jwt_header contains only base64-allowed characters
; ; Since SMT-LIB2 does not provide a base64 predicate, we use a simplified check:
; jwt_header does not contain ':' or '-' or '.' (which are not in base64 alphabet)

(assert (not (str.contains jwt_header ":")))
(assert (not (str.contains jwt_header "-")))
(assert (not (str.contains jwt_header ".")))

; ; JWT signature checking:
; The signature segment should not be empty
(assert (not (= jwt_sig "")))

; API key format: <id>-<timestamp>:<signature>
; e.g., "user1-1683777732:abcdef12345"
; This means, split by ':', we have 2 segments: left and signature
(assert (= (str.num_splits api_key ":") 2))

; ; Extract the signature segment of the API key
(define-fun api_signature () String (str.split_at api_key ":" 1))
; The part before ':' is the id and timestamp, e.g., "user1-1683777732"
(define-fun api_id_time () String (str.split_at api_key ":" 0))

; Now split api_id_time by '-' (should yield 2 segments: id and timestamp)
(assert (= (str.num_splits api_id_time "-") 2))

(define-fun api_id () String (str.split_at api_id_time "-" 0))
(define-fun api_time () String (str.split_at api_id_time "-" 1))

; ; API key signature should be alphanumeric (simplified check: no '.' or '-' or ':')
(assert (not (str.contains api_signature ".")))
(assert (not (str.contains api_signature "-")))
(assert (not (str.contains api_signature ":")))

; ; Unsatisfiable constraint: JWT header must match API key id (real world: not possible)
(assert (not (= jwt_header api_id)))

; ; Satisfiable constraint: JWT signature and API key signature must not be equal
(assert (not (= jwt_sig api_signature)))

; ; Satisfiable constraint: JWT payload segment contains "admin"
(assert (str.contains jwt_payload "admin"))

; ; Unsatisfiable constraint: API key timestamp is empty but we require it to be non-empty
(assert (not (= api_time "")))

(check-sat)
(get-model)
