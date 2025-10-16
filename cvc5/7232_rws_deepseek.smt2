; Complete SMT-LIB2 file for URL parsing constraints
; Focuses on protocol validation, host structure, and path segments
(set-logic QF_SLIA)

; Declare string constants for common URL components
(declare-const url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol validation constraints
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))
(assert (str.prefixof (str.++ protocol "://") url))

; ; Extract host and port
(assert (= host (str.split_at (str.substr url (+ (str.len protocol) 3) (str.len url)) ":" 0)))
(assert (or 
 (and (str.contains (str.substr url (+ (str.len protocol) 3) (str.len url)) ":")
 (= port (str.split_at (str.substr url (+ (str.len protocol) 3) (str.len url)) ":" 1)))
 (and (not (str.contains (str.substr url (+ (str.len protocol) 3) (str.len url)) ":"))
 (= port ""))
))

; Host structure constraints
(assert (str.contains host "."))
(assert (>= (str.len host) 4)) ; Minimum length for "a.b"
(assert (not (str.contains host " ")))

; ; Path extraction and constraints
(assert (or
 (and (str.contains url "/") 
 (= path (str.split_at (str.split_rest url "://" 1) "?" 0)))
 (and (not (str.contains url "/"))
 (= path ""))
))

; Path segment constraints
(assert (or 
 (= path "")
 (and 
 (>= (str.num_splits path "/") 1)
 (not (str.contains (str.split_at path "/" 0) " ")) ; First path segment has no spaces
 (not (str.contains (str.split_at path "/" 0) "..")) ; No parent directory traversal
)
))

; Query string constraints (if exists)
(assert (or
 (and (str.contains url "?")
 (= query (str.split_rest url "?" 1))
 (>= (str.num_splits query "&") 1))
 (and (not (str.contains url "?"))
 (= query ""))
))

; ; Example URL constraints (can be modified)
(assert (str.contains url "://"))
(assert (str.contains url "."))
(assert (<= (str.len url) 200)) ; Reasonable URL length limit

; ; Unsatisfiable constraint combination example
; (assert (= protocol "http"))
; (assert (str.prefixof "https://" url))

(check-sat)
(get-model)
