; SMT-LIB2 file for JWT and API Key validation using split operations
; Delimiters used: '.', '-', ':'
; ; Focus: segment count, base64 validation (simplified), and signature checking

(set-logic ALL)

; Declare variables for JWT and API key
(declare-fun jwt () String)
(declare-fun apikey () String)

; JWT should have exactly three segments separated by '.'
(assert (= (str.num_splits jwt ".") 3))

; JWT segments: header, payload, signature
(define-fun jwt_header () String (str.split_at jwt "." 0))
(define-fun jwt_payload () String (str.split_at jwt "." 1))
(define-fun jwt_signature () String (str.split_at jwt "." 2))

; JWT header and payload are non-empty and must look like base64 (no ':' or '-')
(assert (and 
 (> (str.len jwt_header) 0)
 (> (str.len jwt_payload) 0)
 (not (str.contains jwt_header ":"))
 (not (str.contains jwt_header "-"))
 (not (str.contains jwt_payload ":"))
 (not (str.contains jwt_payload "-"))
))

; JWT signature must be non-empty and should not contain '.' (to ensure proper splitting)
(assert (and 
 (> (str.len jwt_signature) 0)
 (not (str.contains jwt_signature "."))
))

; API key is of the form: <prefix>-<user>:<signature>
; First, split by '-' to get prefix and rest
(assert (= (str.num_splits apikey "-") 2))
(define-fun apikey_prefix () String (str.split_at apikey "-" 0))
(define-fun apikey_rest () String (str.split_rest apikey "-" 1))

; Now split apikey_rest by ':' to get user and signature
(assert (= (str.num_splits apikey_rest ":") 2))
(define-fun apikey_user () String (str.split_at apikey_rest ":" 0))
(define-fun apikey_signature () String (str.split_at apikey_rest ":" 1))

; Prefix, user, and signature are all non-empty
(assert (and
 (> (str.len apikey_prefix) 0)
 (> (str.len apikey_user) 0)
 (> (str.len apikey_signature) 0)
))

; For base64 validation: prefix, user, and signature cannot contain '.' or ':'
(assert (and
 (not (str.contains apikey_prefix "."))
 (not (str.contains apikey_prefix ":"))
 (not (str.contains apikey_user "."))
 (not (str.contains apikey_user ":"))
 (not (str.contains apikey_signature "."))
 (not (str.contains apikey_signature ":"))
))

; ; Example constraint for signature checking:
; The JWT signature and API key signature must be different (unsatisfiable constraint)
(assert (not (= jwt_signature apikey_signature)))

(check-sat)
(exit)
(get-model)
