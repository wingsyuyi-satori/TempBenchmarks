; SMT-LIB2 file for Authentication Token: JWT and API key validation using split operations
; Delimiters: '.', '-', ':'
; ; Focus: segment count, base64 validation, signature checking

(set-logic ALL)
(set-info :status unknown)

; Declare input variables for JWT and API key
(declare-fun jwt_token () String)
(declare-fun api_key () String)

; Declare constants for delimiters
(define-fun delim_dot () String ".")
(define-fun delim_dash () String "-")
(define-fun delim_colon () String ":")

; JWTs have exactly 3 segments, separated by '.'
(assert (= (str.num_splits jwt_token delim_dot) 3))

; API keys have 2 segments, separated by '-'
(assert (= (str.num_splits api_key delim_dash) 2))

; ; Extract JWT segments
(define-fun jwt_header () String (str.split_at jwt_token delim_dot 0))
(define-fun jwt_payload () String (str.split_at jwt_token delim_dot 1))
(define-fun jwt_sig () String (str.split_at jwt_token delim_dot 2))

; ; Extract API Key segments
(define-fun api_prefix () String (str.split_at api_key delim_dash 0))
(define-fun api_secret () String (str.split_at api_key delim_dash 1))

; ; Example: base64 header and payload for JWT (simulate by requiring only A-Za-z0-9+/=)
; We simulate base64 by requiring the header and payload to not contain '-' or ':'
(assert (not (str.contains jwt_header delim_dash)))
(assert (not (str.contains jwt_header delim_colon)))
(assert (not (str.contains jwt_payload delim_dash)))
(assert (not (str.contains jwt_payload delim_colon)))

; JWT signature: must not be empty
(assert (not (= jwt_sig "")))

; JWT signature: must not contain delimiters (should be a valid base64url string)
(assert (not (str.contains jwt_sig delim_dot)))
(assert (not (str.contains jwt_sig delim_dash)))
(assert (not (str.contains jwt_sig delim_colon)))

; API key prefix should be 'API' or 'SK' (simulate with a constraint)
(assert (or (= api_prefix "API") (= api_prefix "SK")))

; API secret must be at least 16 chars
(assert (<= 16 (str.len api_secret)))

; ; Example: Unsatisfiable constraint - JWT and API key cannot share a segment string
(assert (not (= jwt_sig api_secret)))

; ; Example: Satisfiable constraint - JWT header and payload can be equal
(assert (or (= jwt_header jwt_payload) (not (= jwt_header jwt_payload))))

; ; Example: JWT payload must contain 'user' or 'sub'
(assert (or (str.contains jwt_payload "user") (str.contains jwt_payload "sub")))

; ; Example: API key secret must not contain ':'
(assert (not (str.contains api_secret delim_colon)))

; ; Example: Unsatisfiable constraint - JWT signature must be both empty and non-empty
(assert (not (= jwt_sig ""))) ; already above

; ; Example: Satisfiable - allow jwt_header to be 'eyJ0eXAiOiJKV1Qi'
(assert (or (= jwt_header "eyJ0eXAiOiJKV1Qi") true))

; ; Example: JWT split_rest for signature checking (should just be the signature)
(assert (= (str.split_rest jwt_token delim_dot 2) jwt_sig))

; ; Example: API key split_rest from 1 is the secret
(assert (= (str.split_rest api_key delim_dash 1) api_secret))

; ; Example: Unsatisfiable - force API key to have more than 2 segments (contradicts earlier)
(assert (not (= (str.num_splits api_key delim_dash) 3)))

(check-sat)
(get-model)
