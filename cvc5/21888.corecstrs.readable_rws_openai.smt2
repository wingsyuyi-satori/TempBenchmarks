; SMT-LIB2 file for URL Parsing using split operations
; Focus: protocol validation, host structure, path segments
; Delimiters used: "://", "/", ":", "?", "&"
; Operations: str.split_at, str.num_splits, str.split_rest

(set-logic QF_SLIA)

; Declare the URL string
(declare-fun url () String)

; ; Example: "https://example.com:8080/path/segment?query=foo&bar=baz"

; Split URL at "://"
(define-fun protocol () String (str.split_at url "://" 0))
(define-fun after_protocol () String (str.split_rest url "://" 1))

; ; Validate protocol: must be "http" or "https"
(define-fun is_http () Bool (= protocol "http"))
(define-fun is_https () Bool (= protocol "https"))
(define-fun valid_protocol () Bool (or is_http is_https))

; Split after_protocol at "/" to separate host (and port) from path/query
(define-fun host_port () String (str.split_at after_protocol "/" 0))
(define-fun path_and_query () String (str.split_rest after_protocol "/" 1))

; ; Split host_port at ":" to extract host and optional port
(define-fun host () String (str.split_at host_port ":" 0))
(define-fun port () String (str.split_at host_port ":" 1))
(define-fun has_port () Bool (> (str.num_splits host_port ":") 1))

; Host structure: must contain at least one "."
(define-fun host_has_dot () Bool (str.contains host "."))

; Path segments: split path_and_query at "?" to separate path from query
(define-fun path () String (str.split_at path_and_query "?" 0))
(define-fun query () String (str.split_rest path_and_query "?" 1))
(define-fun has_query () Bool (> (str.len query) 0))

; Path segments: number of "/" in path is number of segments + 1, unless path is empty
(define-fun num_path_segments () Int (str.num_splits path "/"))

; ; Example constraint: protocol must be valid, host must have at least one ".", path must have at least two segments
(assert valid_protocol)
(assert host_has_dot)
(assert (>= num_path_segments 2))

; ; Satisfiable example: URL that matches all constraints
(assert (= url "https://www.example.com/foo/bar"))

; ; Unsatisfiable example 1: Protocol is invalid
(declare-fun bad_url1 () String)
(assert (= bad_url1 "ftp://example.com/foo/bar"))
(assert (not (or (= (str.split_at bad_url1 "://" 0) "http") (= (str.split_at bad_url1 "://" 0) "https"))))

; ; Unsatisfiable example 2: Host does not contain a dot
(declare-fun bad_url2 () String)
(assert (= bad_url2 "https://localhost/foo/bar"))
(assert (not (str.contains (str.split_at (str.split_rest bad_url2 "://" 1) "/" 0) ".")))

; ; Unsatisfiable example 3: Path has less than two segments
(declare-fun bad_url3 () String)
(assert (= bad_url3 "https://example.com/foo"))
(assert (< (str.num_splits (str.split_at (str.split_rest bad_url3 "://" 1) "/" 1) "/") 2))

(check-sat)
(get-model)
