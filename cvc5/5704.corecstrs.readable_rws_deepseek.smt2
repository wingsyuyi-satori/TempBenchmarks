
(set-logic QF_SLIA) ; Set the string theory

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

; Protocol must be one of these valid options
(assert (or (= protocol "http") 
 (= protocol "https") 
 (= protocol "ftp") 
 (= protocol "sftp")))

; Basic URL structure constraints
(assert (str.contains full_url protocol_delim))
(assert (= protocol (str.split_at full_url protocol_delim 0)))
(assert (= (str.split_at full_url protocol_delim 1) 
 (str.++ host (str.++ path_delim path))))

; Host may contain port number
(assert (or (and (not (str.contains host port_delim))
 (= (str.indexof host port_delim (- 1)) (- 1)))
 (and (str.contains host port_delim)
 (< (str.indexof host port_delim 0) (str.len host))
 (= (str.split_at host port_delim 0) (str.substr host 0 (str.indexof host port_delim 0)))
 (= (str.split_at host port_delim 1) port))))

; Path must start with / if present
(assert (or (= path "")
 (and (str.prefixof path_delim path)
 (>= (str.num_splits path path_delim) 1))))

; ; Extract first path segment if exists
(declare-const first_path_seg String)
(assert (ite (> (str.num_splits path path_delim) 1)
 (= first_path_seg (str.split_at path path_delim 1))
 (= first_path_seg "")))

; Query parameters handling
(assert (ite (str.contains full_url query_delim)
 (and (= (str.split_at full_url query_delim 0) (str.++ protocol (str.++ protocol_delim (str.++ host path))))
 (= (str.split_at full_url query_delim 1) query)
 (>= (str.num_splits query param_delim) 1))
 (= query "")))

; ; Example constraints for unsatisfiable case
(assert (not (and (= protocol "http") 
 (str.contains host "example.com") 
 (str.prefixof "/admin" path) 
 (str.contains query "password"))))

; Satisfiable case constraints
(assert (or (and (= protocol "https")
 (str.contains host "trusted.org")
 (str.prefixof "/public" path))
 (and (= protocol "ftp")
 (str.contains host "files.server")
 (str.contains path "/downloads"))))

; Additional constraints on host format
(assert (str.contains host ".")) ; Must contain at least one dot
(assert (not (str.prefixof "." host))) ; Cannot start with dot
(assert (not (str.suffixof "." host))) ; Cannot end with dot

; ; Check for valid port numbers if present
(assert (ite (not (= port ""))
 (and (str.is_digit port)
 (<= (str.to_int port) 65535)
 (>= (str.to_int port) 1))
 true))

(check-sat)
(exit)
(get-model)
