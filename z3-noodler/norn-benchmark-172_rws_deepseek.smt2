
; SMT-LIB2 script for URL parsing with protocol validation, host structure, and path segments
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.at (String Int) String)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)
(declare-fun str.prefixof (String String) Bool)

; Declare variables for URL components
(declare-const full_url String)
(declare-const protocol String)
(declare-const host_port String)
(declare-const host String)
(declare-const port String)
(declare-const path_query String)
(declare-const path String)
(declare-const query String)

; Common delimiters
(declare-const protocol_delim String)
(assert (= protocol_delim "://"))
(declare-const path_delim String)
(assert (= path_delim "/"))
(declare-const port_delim String)
(assert (= port_delim ":"))
(declare-const query_delim String)
(assert (= query_delim "?"))
(declare-const param_delim String)
(assert (= param_delim "&"))

; Sample URL constraints (can be modified)
(assert (str.prefixof "http" full_url)) ; Must start with http
(assert (str.contains full_url protocol_delim)) ; Must contain protocol delimiter

; ; Extract protocol (first segment before ://)
(assert (= protocol (str.split_at full_url protocol_delim 0)))
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp"))) ; Valid protocols

; ; Extract host:port (between :// and first / or ?)
(assert (= host_port (str.split_at full_url protocol_delim 1)))
(assert (= host_port (str.split_at host_port path_delim 0))) ; Handle path
(assert (= host_port (str.split_at host_port query_delim 0))) ; Handle query

; Split host and port if present
(assert (ite (str.contains host_port port_delim)
 (and (= host (str.split_at host_port port_delim 0))
 (= port (str.split_at host_port port_delim 1))
 (>= (str.len port) 1)) ; Port must have at least 1 digit
 (= host host_port))) ; No port specified

; Host validation - must contain at least one dot for domain
(assert (str.contains host "."))

; ; Extract path and query (everything after host)
(assert (= path_query (str.split_rest full_url protocol_delim 1)))
(assert (ite (str.contains path_query path_delim)
 (= path_query (str.substr path_query (str.len path_delim) (str.len path_query)))
 (= path_query "")))

; Split path and query if present
(assert (ite (str.contains path_query query_delim)
 (and (= path (str.split_at path_query query_delim 0))
 (= query (str.split_at path_query query_delim 1)))
 (= path path_query)))

; Path segment constraints
(assert (=> (>= (str.len path) 1) 
 (str.prefixof "/" path))) ; Path must start with /

; ; Example path segment extraction
(declare-const first_path_seg String)
(assert (ite (>= (str.num_splits path path_delim) 2)
 (= first_path_seg (str.split_at path path_delim 1))
 (= first_path_seg "")))

; Query parameter constraints (if query exists)
(assert (=> (>= (str.len query) 1)
 (not (str.prefixof "&" query)))) ; Query shouldn't start with &

; Sample unsatisfiable constraint combination
(assert (not (and (= protocol "http") 
 (str.contains host "example.com") 
 (str.contains path "admin"))))

; ; Satisfiable example constraints
(assert (= full_url "https://example.com:8080/api/users?name=john&age=30"))
(check-sat)


(exit)
(get-model)
