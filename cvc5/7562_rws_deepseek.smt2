
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

; ; Example URL: "https://example.com:8080/path/to/resource?param1=val1&param2=val2"
(assert (= url "https://example.com:8080/path/to/resource?param1=val1&param2=val2"))

; ; Protocol extraction and validation
(assert (= protocol (str.split_at url protocol_delim 0)))
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp") (= protocol "file")))

; ; Host and port extraction
(assert (= host (str.split_at (str.split_at url protocol_delim 1) path_delim 0)))
(assert (str.contains host ".")) ; Host must contain at least one dot

; ; Check if port exists
(assert (ite (str.contains host port_delim)
 (and (= (str.split_at host port_delim 0) (str.split_at (str.split_at url protocol_delim 1) port_delim 0))
 (= port (str.split_at host port_delim 1))
 (str.is_digit port))
 (= port "")))

; ; Path extraction
(assert (ite (str.contains (str.split_at url protocol_delim 1) path_delim)
 (= path (str.split_at (str.split_rest (str.split_at url protocol_delim 1) path_delim 1) query_delim 0))
 (= path "")))

; ; Query string extraction
(assert (ite (str.contains url query_delim)
 (= query (str.split_at url query_delim 1))
 (= query "")))

; Path segment constraints
(assert (ite (not (= path ""))
 (and (>= (str.num_splits path path_delim) 1)
 (str.prefixof "/" path)
 (not (str.contains (str.split_at path path_delim 0) "/")))
 true))

; Query parameter constraints
(assert (ite (not (= query ""))
 (and (>= (str.num_splits query param_delim) 1)
 (not (str.contains (str.split_at query param_delim 0) "&")))
 true))

; Additional constraints
(assert (not (str.contains host " "))) ; No spaces in host
(assert (not (str.contains path ".."))) ; Prevent path traversal
(assert (=> (not (= port "")) (<= (str.to_int port) 65535))) ; Valid port range

; Test constraints (can be modified for different scenarios)
(assert (str.prefixof "https" protocol))
(assert (str.suffixof "com" host))
(assert (str.contains path "resource"))

; ; Check satisfiability
(check-sat)


(get-model)
