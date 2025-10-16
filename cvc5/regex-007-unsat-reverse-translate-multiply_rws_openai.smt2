; ; SMT-LIB2 file for URL Parsing with protocol, host, and path extraction
; Delimiters: '://', '/', ':', '?', '&'
; Focus: protocol validation, host structure, path segments

(set-logic QF_SLIA)

; Declare the input URL string
(declare-fun url () String)

; ; Extract the protocol (before '://')
(define-fun protocol () String
 (str.split_at url "://" 0)
)

; The rest after protocol and '://'
(define-fun after_protocol () String
 (str.split_rest url "://" 1)
)

; Host: first segment of after_protocol before '/'
(define-fun host () String
 (str.split_at after_protocol "/" 0)
)

; Path and query: everything after the first '/' in after_protocol
(define-fun path_and_query () String
 (str.split_rest after_protocol "/" 1)
)

; Path only: before '?'
(define-fun path_only () String
 (str.split_at path_and_query "?" 0)
)

; Query: after '?', if present
(define-fun query () String
 (str.split_rest path_and_query "?" 1)
)

; Number of segments in path (split by '/')
(define-fun num_path_segments () Int
 (str.num_splits path_only "/")
)

; First path segment (after domain)
(define-fun first_path_segment () String
 (str.split_at path_only "/" 0)
)

; Second path segment (if exists)
(define-fun second_path_segment () String
 (str.split_at path_only "/" 1)
)

; Protocol validation: must be 'http' or 'https'
(define-fun valid_protocol () Bool
 (or (= protocol "http") (= protocol "https"))
)

; Host must not be empty
(define-fun host_not_empty () Bool
 (not (= host ""))
)

; Host contains at least one dot '.'
(define-fun host_has_dot () Bool
 (str.contains host ".")
)

; Host does not start with a dot '.'
(define-fun host_not_start_dot () Bool
 (not (= (str.at host 0) "."))
)

; Host does not end with a dot '.'
(define-fun host_not_end_dot () Bool
 (not (= (str.at host (- (str.len host) 1)) "."))
)

; Path must start with 'api'
(define-fun path_starts_with_api () Bool
 (str.prefixof "api" first_path_segment)
)

; Path must have at least 2 segments
(define-fun path_has_two_segments () Bool
 (>= num_path_segments 2)
)

; SAT scenario: Proper URL with all constraints satisfied
(assert valid_protocol)
(assert host_not_empty)
(assert host_has_dot)
(assert host_not_start_dot)
(assert host_not_end_dot)
(assert path_has_two_segments)
(assert path_starts_with_api)
; ; Example: url = "https://my.example.com/api/v1/resource?foo=bar"

(check-sat)




(get-model)
