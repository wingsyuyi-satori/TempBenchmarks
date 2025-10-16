; SMT-LIB2 file for URL Parsing using string split operations
; Focus: protocol validation, host structure, and path segments
; Delimiters: "://", "/", ":", "?", "&"

(set-logic ALL)

; Declare variables for the URL and its components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path_full () String)
(declare-fun first_path_segment () String)
(declare-fun num_path_segments () Int)

; ; Extract protocol: the string before the first occurrence of "://"
(assert (= protocol (str.split_at url "://" 0)))

; ; Extract host: the string after "://" and before the next "/"
; Let temp1 be the substring after "://"
(declare-fun temp1 () String)
(assert (= temp1 (str.split_rest url "://" 1)))
; Host is the first segment of temp1 when split by "/"
(assert (= host (str.split_at temp1 "/" 0)))

; ; Extract path_full: the substring after host, i.e., after the first "/"
(assert (= path_full (str.split_rest temp1 "/" 1)))

; ; Extract the first segment of the path (if any)
(assert (= first_path_segment (str.split_at path_full "/" 0)))

; Number of path segments (after splitting path_full by "/")
(assert (= num_path_segments (str.num_splits path_full "/")))

; ; Example 1: Satisfiable constraints
; ; URL: "https://example.com/foo/bar"
(assert (= url "https://example.com/foo/bar"))

; Protocol must be "https"
(assert (= protocol "https"))

; Host must contain at least one "."
(assert (str.contains host "."))

; The first path segment should be "foo"
(assert (= first_path_segment "foo"))

; There should be exactly 2 path segments ("foo", "bar")
(assert (= num_path_segments 2))

(check-sat)


(exit)
(get-model)
