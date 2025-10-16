
; SMT-LIB2 script for URL parsing constraints
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const protocol_delim String) ; "://"
(declare-const path_delim String) ; "/"
(declare-const port_delim String) ; ":"
(declare-const query_delim String) ; "?"
(declare-const param_delim String) ; "&"

(assert (= protocol_delim "://"))
(assert (= path_delim "/"))
(assert (= port_delim ":"))
(assert (= query_delim "?"))
(assert (= param_delim "&"))

; Declare URL components
(declare-const url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol must be one of these valid options
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))

; Split URL into protocol and rest
(assert (= protocol (str.split_at url protocol_delim 0)))
(assert (>= (str.num_splits url protocol_delim) 1))

; ; Extract host and port (if present)
(declare-const host_port String)
(assert (= host_port (str.split_at (str.split_rest url protocol_delim 0) path_delim 0)))

(assert (ite (str.contains host_port port_delim)
 (and (= host (str.split_at host_port port_delim 0))
 (= port (str.split_at host_port port_delim 1)))
 (= host host_port)))

; Host must be non-empty and contain at least one dot
(assert (not (= host "")))
(assert (str.contains host "."))

; ; Extract path (if present)
(assert (ite (str.contains (str.split_rest url protocol_delim 0) path_delim)
 (= path (str.split_rest (str.split_rest url protocol_delim 0) path_delim 0))
 (= path "")))

; ; Extract query parameters (if present)
(assert (ite (str.contains path query_delim)
 (and (= query (str.split_rest path query_delim 0))
 (= path (str.split_at path query_delim 0)))
 (= query "")))

; Path segments constraints
(declare-const path_segments Int)
(assert (= path_segments (str.num_splits path path_delim)))

; Each path segment must be non-empty (except possibly last one)
(assert (forall ((i Int))
 (=> (and (>= i 0) (< i (- path_segments 1)))
 (not (= (str.split_at path path_delim i) "")))))

; ; Example constraints for testing
; Satisfiable case
(assert (= url "https://example.com:8080/path/to/resource?param=value"))
(check-sat)




(exit)
(get-model)
