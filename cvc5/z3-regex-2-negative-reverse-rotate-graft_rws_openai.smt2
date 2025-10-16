; ; SMT-LIB2 file for URL Parsing with protocol, host, and path extraction
; Delimiters used: '://', '/', ':', '?', '&'
; Focus: protocol validation, host structure, path segments

(set-logic QF_SLIA)

; Declare the URL variable
(declare-fun url () String)

; ; Extract the protocol: protocol = (str.split_at url "://" 0)
(define-fun protocol () String (str.split_at url "://" 0))

; The remainder after protocol delimiter: rest1 = (str.split_rest url "://" 1)
(define-fun rest1 () String (str.split_rest url "://" 1))

; Host is the first segment of rest1 split by '/', i.e., (str.split_at rest1 "/" 0)
(define-fun host () String (str.split_at rest1 "/" 0))

; Path is the remainder after host: (str.split_rest rest1 "/" 1)
(define-fun path_and_query () String (str.split_rest rest1 "/" 1))

; Path segments: first segment is path1, second segment is path2
(define-fun path1 () String (str.split_at path_and_query "/" 0))
(define-fun path2 () String (str.split_at path_and_query "/" 1))

; Query string (if present): after splitting path_and_query by '?'
(define-fun query () String (str.split_rest path_and_query "?" 1))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Protocol validation: Protocol must be 'https' or 'http'

(assert (or (= protocol "http") (= protocol "https")))

; Protocol must be non-empty
(assert (not (= protocol "")))

; The URL must contain the '://' delimiter exactly once
(assert (= (str.num_splits url "://") 2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Host structure: Host must not be empty and must contain at least one '.'

(assert (not (= host "")))
(assert (> (str.num_splits host ".") 1))

; Host must not contain '/' or '?' or '&'
(assert (= (str.indexof host "/" 0) -1))
(assert (= (str.indexof host "?" 0) -1))
(assert (= (str.indexof host "&" 0) -1))

; ; Host may have a port: e.g., 'example.com:8080'
; If there is a ':', the port should be numeric (if present)
(define-fun host_without_port () String (str.split_at host ":" 0))
(define-fun port () String (str.split_rest host ":" 1))

; If a port is specified, it must be all digits and non-empty
(assert (or (= port "")
 (and (forall ((i Int))
 (=> (and (>= i 0) (< i (str.len port)))
 (and (>= (str.to_code (str.at port i)) 48)
 (<= (str.to_code (str.at port i)) 57))))
 (> (str.len port) 0))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Path segments: Path may be empty or contain multiple segments

; path_and_query can be empty, but if not, path1 is the first path segment (may be empty if only a query)
; For demonstration, require that if there is a path, the first segment cannot be 'admin'
(assert (or (= path1 "") (not (= path1 "admin"))))

; Require at least one path segment unless the path is empty
(assert (or (= path_and_query "") (> (str.num_splits path_and_query "/") 0)))

; If path2 exists, it cannot be 'forbidden'
(assert (or (< (str.num_splits path_and_query "/") 2) (not (= path2 "forbidden"))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; Satisfiable scenario: Provide an example URL that satisfies all constraints

(assert
 (= url "https://example.com:443/user/profile?token=abc&mode=edit")
)

(check-sat)


(get-model)
