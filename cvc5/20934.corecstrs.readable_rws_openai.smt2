; SMT-LIB2 file for URL Parsing via split constraints
; Focus: protocol validation, host structure, path segments

(set-logic QF_SLIA)

; Declare the URL string variable
(declare-const url String)

; Declare string variables for protocol, host, and path
(declare-const protocol String)
(declare-const host String)
(declare-const path String)

; Delimiters used in URL parsing
(define-fun delim_protocol () String "://")
(define-fun delim_path () String "/")
(define-fun delim_port () String ":")
(define-fun delim_query () String "?")
(define-fun delim_amp () String "&")

; Split at "://": protocol = segment 0, rest = segment 1
(assert (= protocol (str.split_at url delim_protocol 0)))
(declare-const after_protocol String)
(assert (= after_protocol (str.split_rest url delim_protocol 1)))

; Host is the first segment of after_protocol split by "/"
(assert (= host (str.split_at after_protocol delim_path 0)))

; Path is the rest after the first "/" (i.e., after host), with "/" preserved
(assert (= path (str.split_rest after_protocol delim_path 1)))

; Protocol validation: protocol must be either "http" or "https"
(assert (or (= protocol "http") (= protocol "https")))

; Host structure: host must contain at least one "." and must not be empty
(assert (str.contains host "."))
(assert (not (= host "")))

; Path segments: number of path segments (split by "/") must be at least 1
; (i.e., path itself is not empty unless missing)
(assert (=> (not (= path "")) (>= (str.num_splits path delim_path) 1)))

; ; Example 1: Satisfiable case
; ; URL: "https://example.com/foo/bar"
(assert (= url "https://example.com/foo/bar"))
(check-sat)



(get-model)
