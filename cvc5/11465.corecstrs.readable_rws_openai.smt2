; ; SMT-LIB2 file for URL Parsing: protocol, host, and path extraction
; Split delimiters: '://', '/', ':', '?', '&'
; Focus: protocol validation, host structure, path segments

(set-logic QF_SLIA)

; Declare the URL string
(declare-fun url () String)

; ; Extract protocol by splitting at '://', get segment 0
(define-fun protocol () String (str.split_at url "://" 0))

; The remainder after '://' is host + optional path/query
(define-fun rest_after_protocol () String (str.split_rest url "://" 1))

; Host is before first '/' in rest_after_protocol
(define-fun host () String (str.split_at rest_after_protocol "/" 0))

; Path (with leading '/') is the remainder after host
(define-fun path_and_query () String (str.split_rest rest_after_protocol "/" 1))

; Path only (without query): split path_and_query at '?', get segment 0
(define-fun path () String (str.split_at path_and_query "?" 0))

; Query (if any): split path_and_query at '?', get segment 1 (may not exist)
(define-fun query () String (str.split_at path_and_query "?" 1))

; Number of path segments (ignore leading/trailing '/')
(define-fun num_path_segments () Int (str.num_splits path "/"))

; For host structure: optional port (host:port)
(define-fun host_name () String (str.split_at host ":" 0))
(define-fun host_port () String (str.split_at host ":" 1))

; Practical constraints

; ; Satisfiable constraints example:
(assert
 (and
 ; The URL is a typical HTTPS URL with path and query
 (= url "https://www.example.com:443/foo/bar/baz?user=alice&debug=1")
 ; Protocol must be 'https'
 (= protocol "https")
 ; Host name must not be empty
 (not (= host_name ""))
 ; Port is '443'
 (= host_port "443")
 ; Path is '/foo/bar/baz'
 (= path "/foo/bar/baz")
 ; There are 3 path segments (foo, bar, baz)
 (= num_path_segments 3)
 ; Query is 'user=alice&debug=1'
 (= query "user=alice&debug=1")
)
)

; ; Unsatisfiable constraints example:
; ; Protocol extraction must be 'ftp', which doesn't match above definition
(assert
 (not (= protocol "ftp"))
)

(check-sat)
(get-model)
