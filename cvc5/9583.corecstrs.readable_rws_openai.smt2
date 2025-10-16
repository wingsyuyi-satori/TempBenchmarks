; SMT-LIB2 file for Authentication Token: JWT and API Key validation
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic QF_SLIA)

; Declarations for token strings
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; JWT format: header.payload.signature (3 segments separated by '.')
(define-fun jwt_num_segments () Int (str.num_splits jwt_token "."))
(define-fun jwt_header () String (str.split_at jwt_token "." 0))
(define-fun jwt_payload () String (str.split_at jwt_token "." 1))
(define-fun jwt_signature () String (str.split_at jwt_token "." 2))

; API Key format: <app>-<user>:<signature>
(define-fun api_dash_segments () Int (str.num_splits api_key "-"))
(define-fun api_app () String (str.split_at api_key "-" 0))
(define-fun api_rest () String (str.split_rest api_key "-" 1))
(define-fun api_colon_segments () Int (str.num_splits api_rest ":"))
(define-fun api_user () String (str.split_at api_rest ":" 0))
(define-fun api_signature () String (str.split_at api_rest ":" 1))

; Base64 validation: JWT header and payload should be base64url (no '+', '/', '=', or whitespace)
; For demonstration, we ensure absence of '+', '/', '=', ' ' in header and payload
(define-fun not_contains ((x String) (y String)) Bool
  (not (str.contains x y)))

(define-fun is_base64url ((x String)) Bool
  (and (not_contains x "+")
       (not_contains x "/")
       (not_contains x "=")
       (not_contains x " ")))

; Clause 1: Satisfiable - Proper JWT and API key structure
(assert (= jwt_num_segments 3))
(assert (is_base64url jwt_header))
(assert (is_base64url jwt_payload))
(assert (= (str.len jwt_signature) 43)) ; e.g., expected JWT signature length

(assert (= api_dash_segments 2))
(assert (= api_colon_segments 2))
(assert (not (str.contains api_signature ":"))) ; signature can't contain delimiter
(assert (not (str.contains api_signature "-"))) ; signature can't contain delimiter

; Clause 2: Unsatisfiable - JWT with wrong segment count but signature length requirement
; Introduce a new token to avoid clashing with the first block
(declare-fun invalid_jwt_token () String)
(define-fun invalid_jwt_num_segments () Int (str.num_splits invalid_jwt_token "."))
(define-fun invalid_jwt_signature () String (str.split_at invalid_jwt_token "." 2))
(assert (= invalid_jwt_num_segments 2)) ; only 2 segments, invalid for JWT
(assert (= (str.len invalid_jwt_signature) 43)) ; but still expects signature length

; Clause 3: Unsatisfiable - API key with signature containing forbidden character
(declare-fun invalid_api_key () String)
(define-fun invalid_api_dash_segments () Int (str.num_splits invalid_api_key "-"))
(define-fun invalid_api_rest () String (str.split_rest invalid_api_key "-" 1))
(define-fun invalid_api_signature () String (str.split_at invalid_api_rest ":" 1))
(assert (= invalid_api_dash_segments 2))
(assert (str.contains invalid_api_signature ":")) ; forbidden: signature contains delimiter

(check-sat)
(exit)
(get-model)
