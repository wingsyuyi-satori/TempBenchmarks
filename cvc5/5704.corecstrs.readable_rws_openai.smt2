; SMT-LIB2 file for URL Parsing with split operations
; Delimiters: '://', '/', ':', '?', '&'
; Focus: protocol validation, host structure, path segments

(set-logic ALL)

; Declare the custom string split functions (assume they are supported by the solver)
; (str.split_at x d k): returns the k-th segment after splitting string x by delimiter d (0-based)
; (str.num_splits x d): returns the number of segments after splitting x by d
; (str.split_rest x d k): returns the concatenation of all segments from index k onwards, delimiters preserved

; Declare the URL to be parsed
(declare-fun url () String)

; Split by '://': protocol and remainder
(define-fun proto ((u String)) String (str.split_at u "://" 0))
(define-fun after_proto ((u String)) String (str.split_rest u "://" 1))

; Split after_proto by first '/': host (possibly with port), and path+query
(define-fun host_with_port ((rest String)) String (str.split_at rest "/" 0))
(define-fun path_and_query ((rest String)) String (str.split_rest rest "/" 1))

; Split host_with_port by ':': host and port (if present)
(define-fun host ((hwp String)) String (str.split_at hwp ":" 0))
(define-fun port ((hwp String)) String (str.split_at hwp ":" 1))
(define-fun num_host_port_splits ((hwp String)) Int (str.num_splits hwp ":"))

; Split path_and_query by '?': path and query string (if present)
(define-fun path ((paq String)) String (str.split_at paq "?" 0))
(define-fun query ((paq String)) String (str.split_at paq "?" 1))
(define-fun num_path_query_splits ((paq String)) Int (str.num_splits paq "?"))

; Split path into segments by '/'
(define-fun path_segment0 ((p String)) String (str.split_at p "/" 0))
(define-fun path_segment1 ((p String)) String (str.split_at p "/" 1))
(define-fun num_path_segments ((p String)) Int (str.num_splits p "/"))

; ------------------------------
; ; Satisfiable Example: Parsing a normal HTTP URL
; ; Example URL: "http://example.com:8080/foo/bar?x=1&y=2"

(assert (= url "http://example.com:8080/foo/bar?x=1&y=2"))

; Protocol validation: Must be "http" or "https"
(assert (or (= (proto url) "http") (= (proto url) "https")))

; Host structure: host must contain at least one '.'
(assert (str.contains (host (host_with_port (after_proto url))) "."))

; If port is present, it must be "8080"
(assert (=> (> (num_host_port_splits (host_with_port (after_proto url))) 1)
 (= (port (host_with_port (after_proto url))) "8080")))

; Path segments: there must be at least two segments: "foo" and "bar"
(assert (>= (num_path_segments (path (path_and_query (after_proto url)))) 2))
(assert (= (path_segment0 (path (path_and_query (after_proto url)))) "foo"))
(assert (= (path_segment1 (path (path_and_query (after_proto url)))) "bar"))

; If query is present, it must start with "x="
(assert (=> (> (num_path_query_splits (path_and_query (after_proto url))) 1)
 (str.prefixof "x=" (query (path_and_query (after_proto url))))))

; ------------------------------
; ; Unsatisfiable Example: Protocol validation fails

(declare-fun url_bad_protocol () String)

(assert (= url_bad_protocol "ftp://example.com/foo"))
; Protocol validation: only "http" or "https" allowed
(assert (not (or (= (proto url_bad_protocol) "http") (= (proto url_bad_protocol) "https"))))

; But require host to contain a dot (still a valid host structure)
(assert (str.contains (host (host_with_port (after_proto url_bad_protocol))) "."))

; ------------------------------
; ; Unsatisfiable Example: Host structure fails (host without '.')

(declare-fun url_bad_host () String)

(assert (= url_bad_host "http://localhost/path"))
(assert (or (= (proto url_bad_host) "http") (= (proto url_bad_host) "https")))
; Host must contain a dot, which localhost does not
(assert (not (str.contains (host (host_with_port (after_proto url_bad_host))) ".")))

; ------------------------------
; ; Unsatisfiable Example: Not enough path segments

(declare-fun url_short_path () String)

(assert (= url_short_path "https://example.com/foo"))
(assert (or (= (proto url_short_path) "http") (= (proto url_short_path) "https")))
(assert (str.contains (host (host_with_port (after_proto url_short_path))) "."))
; Require at least two segments in the path, but only one provided
(assert (< (num_path_segments (path (path_and_query (after_proto url_short_path)))) 2))

; ------------------------------

(check-sat)
(exit)
(get-model)
