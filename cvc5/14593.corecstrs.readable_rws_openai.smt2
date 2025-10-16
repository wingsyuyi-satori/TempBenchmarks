; SMT-LIB2 file for URL Parsing using split operations
; Focus: protocol validation, host structure, path segments
; Delimiters used: '://', '/', ':', '?', '&'

(set-logic QF_SLIA)

; Declare the URL string variable
(declare-fun url () String)

; ; Extract the protocol: protocol = (str.split_at url "://" 0)
(define-fun protocol () String (str.split_at url "://" 0))

; ; Extract the rest after protocol: rest = (str.split_rest url "://" 1)
(define-fun rest () String (str.split_rest url "://" 1))

; Number of splits at "://"
(define-fun num_proto_splits () Int (str.num_splits url "://"))

; ; Extract the host: host = (str.split_at rest "/" 0)
(define-fun host () String (str.split_at rest "/" 0))

; ; Extract the path and beyond: path_and_beyond = (str.split_rest rest "/" 1)
(define-fun path_and_beyond () String (str.split_rest rest "/" 1))

; Number of path segments after host (for path validation)
(define-fun num_path_slash () Int (str.num_splits rest "/"))

; ; Extract path segment 0 (first segment after host)
(define-fun path_seg0 () String (str.split_at path_and_beyond "/" 0))

; ; Extract path segment 1 (second segment after host), if present
(define-fun path_seg1 () String (str.split_at path_and_beyond "/" 1))

; Host structure: host may have port, separated by ':'
(define-fun host_name () String (str.split_at host ":" 0))
(define-fun host_port () String (str.split_at host ":" 1))
(define-fun num_colon_host () Int (str.num_splits host ":"))

; ; Satisfiable example: Valid HTTP URL with host and one path segment
(assert (= url "http://example.com/home"))
; Protocol must be "http" or "https"
(assert (or (= protocol "http") (= protocol "https")))
; Host must not be empty
(assert (not (= host "")))
; ; Host name must be "example.com"
(assert (= host_name "example.com"))
; Host port must be empty (no colon in host)
(assert (= num_colon_host 1))
; Path segment 0 must be "home"
(assert (= path_seg0 "home"))
; There must be at least one path segment after host
(assert (>= (- num_path_slash 1) 1))

(check-sat)




(exit)
(get-model)
