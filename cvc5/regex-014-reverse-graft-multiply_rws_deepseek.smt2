; ; Complete SMT-LIB2 file for URL parsing with protocol, host, and path extraction
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
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

; Declare URL components
(declare-const full_url String)
(declare-const protocol String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)

; Protocol must be one of the common web protocols
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))

; Basic URL structure constraints
(assert (str.contains full_url protocol_delim))
(assert (= protocol (str.split_at full_url protocol_delim 0)))
(assert (str.prefixof (str.++ protocol protocol_delim) full_url))

; ; Extract host and remaining parts
(declare-const after_protocol String)
(assert (= after_protocol (str.split_rest full_url protocol_delim 1)))

; Host may contain port number
(assert (or 
 (and (not (str.contains after_protocol port_delim))
 (= host after_protocol))
 (and (str.contains after_protocol port_delim)
 (= host (str.split_at after_protocol port_delim 0))
 (= port (str.split_at after_protocol port_delim 1)))
))

; Host must be non-empty and contain at least one dot
(assert (>= (str.len host) 1))
(assert (str.contains host "."))

; ; Path extraction (may be empty)
(assert (or
 (and (not (str.contains after_protocol path_delim))
 (= path ""))
 (and (str.contains after_protocol path_delim)
 (= path (str.split_rest after_protocol path_delim 1)))
))

; Path segments constraints if path exists
(declare-const path_segments Int)
(assert (=> (not (= path "")) 
 (and 
 (= path_segments (str.num_splits path path_delim))
 (>= path_segments 1)
 (str.prefixof path_delim path)
)
))

; Query string constraints (optional)
(assert (or
 (not (str.contains full_url query_delim))
 (and (str.contains full_url query_delim)
 (= query (str.split_rest full_url query_delim 1))
 (>= (str.num_splits query param_delim) 1))
))

; ; Example constraints for a valid URL
(assert (str.contains full_url "https://example.com:8080/api/v1/users?name=john"))
(assert (= protocol "https"))
(assert (= host "example.com"))
(assert (= port "8080"))
(assert (str.prefixof "/api" path))
(assert (str.contains query "name=john"))

; Additional constraints to make unsatisfiable cases
(assert (not (str.contains host " "))) ; host cannot contain spaces
(assert (=> (not (= port "")) 
 (and 
 (>= (str.to_int port) 1)
 (<= (str.to_int port) 65535)
)
))

(check-sat)
(exit)
(get-model)
