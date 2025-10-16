
; SMT-LIB2 script for URL parsing with protocol validation, host structure, and path segments
(set-logic QF_SLIA) ; Quantifier-free strings
(set-info :smt-lib-version 2.6)

; Declare string constants for delimiters
(declare-const protocol_delim String) ; "://"
(assert (= protocol_delim "://"))
(declare-const path_delim String) ; "/"
(assert (= path_delim "/"))
(declare-const port_delim String) ; ":"
(assert (= port_delim ":"))
(declare-const query_delim String) ; "?"
(assert (= query_delim "?"))
(declare-const param_delim String) ; "&"
(assert (= param_delim "&"))

; Declare URL variable
(declare-const url String)

; Protocol validation constraints
(assert (str.contains url protocol_delim))
(assert (>= (str.len url) (+ (str.len protocol_delim) 1)))

; ; Extract protocol (first segment before ://)
(declare-const protocol String)
(assert (= protocol (str.split_at url protocol_delim 0)))

; Protocol must be one of http, https, ftp
(assert (or (= protocol "http") 
 (= protocol "https") 
 (= protocol "ftp")))

; ; Extract host and rest after protocol
(declare-const host_and_rest String)
(assert (= host_and_rest (str.split_rest url protocol_delim 1)))

; Host may contain port number
(declare-const host_port String)
(assert (ite (str.contains host_and_rest port_delim)
 (= host_port (str.split_at host_and_rest port_delim 0))
 (= host_port host_and_rest)))

; Host must be non-empty and start with alphanumeric
(assert (>= (str.len host_port) 1))
(assert (str.is_digit (str.at host_port 0)))

; ; Path extraction (after first /)
(declare-const path_and_query String)
(assert (ite (str.contains host_and_rest path_delim)
 (= path_and_query (str.split_rest host_and_rest path_delim 1))
 (= path_and_query "")))

; Split path segments
(declare-const num_path_segments Int)
(assert (= num_path_segments (str.num_splits path_and_query path_delim)))

; Require at least one path segment if path exists
(assert (=> (not (= path_and_query "")) (> num_path_segments 0)))

; ; Extract first path segment
(declare-const first_path_seg String)
(assert (ite (> num_path_segments 0)
 (= first_path_seg (str.split_at path_and_query path_delim 0))
 (= first_path_seg "")))

; First path segment must not be empty if path exists
(assert (=> (> num_path_segments 0) (not (= first_path_seg ""))))

; Query parameters (after ?)
(declare-const query_part String)
(assert (ite (str.contains path_and_query query_delim)
 (= query_part (str.split_rest path_and_query query_delim 1))
 (= query_part "")))

; Count query parameters
(declare-const num_params Int)
(assert (= num_params (str.num_splits query_part param_delim)))

; ; Example constraints for satisfiable case
(assert (= url "https://example.com:8080/path/to/resource?param1=val1&param2=val2"))
(check-sat)



(exit)
(get-model)
