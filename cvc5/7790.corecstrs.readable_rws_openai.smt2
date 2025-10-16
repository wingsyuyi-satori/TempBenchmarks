; ; SMT-LIB2 File: URL Parsing with Protocol, Host, and Path Extraction
; Delimiters used: '://', '/', ':', '?', '&'
; Focus: protocol validation, host structure, path segments

(set-logic ALL)

; Declare the URL string to parse
(declare-fun url () String)

; ; Protocol extraction: the substring before the first occurrence of '://'
(define-fun protocol () String
 (str.split_at url "://" 0))

; Host and rest: the substring after '://'
(define-fun host_and_rest () String
 (str.split_rest url "://" 1))

; ; Host extraction: the substring before the first '/' after '://'
(define-fun host () String
 (str.split_at host_and_rest "/" 0))

; Path and query: the substring after the first '/' after '://'
(define-fun path_and_query () String
 (str.split_rest host_and_rest "/" 1))

; ; Path extraction: the substring before '?' in path_and_query
(define-fun path () String
 (str.split_at path_and_query "?" 0))

; ; Query extraction: the substring after '?' in path_and_query
(define-fun query () String
 (str.split_rest path_and_query "?" 1))

; Number of path segments (after splitting by '/'), ignoring leading empty segment
(define-fun num_path_segments () Int
 (str.num_splits path "/"))

; The first path segment (after first '/')
(define-fun first_path_segment () String
 (str.split_at path "/" 1))

; ; Host structure: check for presence of port (host:port)
(define-fun host_no_port () String
 (str.split_at host ":" 0))

(define-fun port () String
 (str.split_rest host ":" 1))

; Satisfiable scenario
; ; Example: url = "https://www.example.com:8080/products/view?id=123&ref=abc"
; - protocol = "https"
; ; - host = "www.example.com:8080"
; ; - host_no_port = "www.example.com"
; - port = "8080"
; - path = "products/view"
; - query = "id=123&ref=abc"
; - num_path_segments = 2
; - first_path_segment = "products"

(assert
 (= url "https://www.example.com:8080/products/view?id=123&ref=abc")
)

; Protocol validation: only allow "http" or "https"
(assert
 (or
 (= protocol "http")
 (= protocol "https")
)
)

; Host must contain at least one dot ('.')
(assert
 (str.contains host_no_port ".")
)

; Port must be all digits, length > 0
(assert
 (=> (not (= port ""))
 (forall ((i Int))
 (=> (and (<= 0 i) (< i (str.len port)))
 (and (<= 48 (str.to_code (str.at port i))) (<= (str.to_code (str.at port i)) 57))
)
)
)
)

; Path must have at least two segments
(assert
 (>= num_path_segments 2)
)

; First path segment must be "products"
(assert
 (= first_path_segment "products")
)

; Query must contain "&" (at least two query parameters)
(assert
 (str.contains query "&")
)

(check-sat)



(get-model)
