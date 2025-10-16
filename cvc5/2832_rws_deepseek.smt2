
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for common URL components
(declare-const url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Common delimiters
(define-const proto_delim String "://")
(define-const path_delim String "/")
(define-const port_delim String ":")
(define-const query_delim String "?")
(define-const param_delim String "&")

; ; Example URL to parse
(assert (= url "https://example.com:8080/path/to/resource?param1=value1&param2=value2"))

; ; Extract protocol (must be http or https)
(assert (= protocol (str.split_at url proto_delim 0)))
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host:port part (everything between :// and next / or ?)
(declare-const hostport String)
(assert (= hostport (str.split_at (str.split_rest url proto_delim 1) path_delim 0)))
(assert (= hostport (str.split_at hostport query_delim 0)))

; Split host and port if present
(assert (ite (str.contains hostport port_delim)
 (and (= host (str.split_at hostport port_delim 0))
 (= port (str.split_at hostport port_delim 1)))
 (and (= host hostport)
 (= port ""))))

; ; Validate host structure (simplified - must contain at least one dot)
(assert (str.contains host "."))
(assert (not (str.prefixof "." host)))
(assert (not (str.suffixof "." host)))

; ; Extract path (everything after host until ?)
(declare-const full_path String)
(assert (= full_path (str.split_at (str.split_rest url proto_delim 1) query_delim 0)))
(assert (ite (str.contains full_path path_delim)
 (= path (str.split_rest full_path path_delim 1))
 (= path "")))

; ; Extract query parameters if present
(assert (ite (str.contains url query_delim)
 (= query (str.split_rest url query_delim 1))
 (= query "")))

; ; Validate path segments (must not be empty between slashes)
(declare-const path_seg1 String)
(declare-const path_seg2 String)
(declare-const path_seg3 String)
(assert (ite (>= (str.num_splits path path_delim) 1)
 (= path_seg1 (str.split_at path path_delim 0))
 (= path_seg1 "")))
(assert (ite (>= (str.num_splits path path_delim) 2)
 (= path_seg2 (str.split_at path path_delim 1))
 (= path_seg2 "")))
(assert (ite (>= (str.num_splits path path_delim) 3)
 (= path_seg3 (str.split_at path path_delim 2))
 (= path_seg3 "")))

; Path segments cannot be empty if they exist
(assert (=> (not (= path_seg1 "")) (> (str.len path_seg1) 0)))
(assert (=> (not (= path_seg2 "")) (> (str.len path_seg2) 0)))
(assert (=> (not (= path_seg3 "")) (> (str.len path_seg3) 0)))

; Additional constraints for demonstration
; Case 1: Satisfiable - standard URL
(assert (= protocol "https"))
(assert (= host "example.com"))
(assert (= port "8080"))
(assert (str.contains path "resource"))

; Case 2: Unsatisfiable - invalid protocol
;(assert (= protocol "ftp")) ; Uncomment to make unsatisfiable

(check-sat)
(get-model)
