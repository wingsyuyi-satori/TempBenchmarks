(set-logic QF_SLIA)

; Declare multiple string constants for complex parsing
(declare-const protocol_delim String)
(declare-const path_delim String) 
(declare-const port_delim String)
(declare-const query_delim String)
(declare-const param_delim String)
(declare-const fragment_delim String)
(declare-const userinfo_delim String)

(assert (= protocol_delim "://"))
(assert (= path_delim "/"))
(assert (= port_delim ":"))
(assert (= query_delim "?"))
(assert (= param_delim "&"))
(assert (= fragment_delim "#"))
(assert (= userinfo_delim "@"))

; Declare URL components with multiple levels
(declare-const full_url String)
(declare-const protocol String)
(declare-const userinfo String)
(declare-const host String)
(declare-const port String)
(declare-const path String)
(declare-const query String)
(declare-const fragment String)

; Complex protocol validation using str.num_splits
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp") (= protocol "sftp")))
(assert (= (str.num_splits protocol ":") 1)) ; Protocol cannot contain colons

; Multi-level URL parsing using str.split_at and str.split_rest
(assert (str.contains full_url protocol_delim))
(assert (= protocol (str.split_at full_url protocol_delim 0)))
(declare-const after_protocol String)
(assert (= after_protocol (str.split_rest full_url protocol_delim 1)))

; Handle userinfo with @ delimiter
(assert (ite (str.contains after_protocol userinfo_delim)
    (and (= userinfo (str.split_at after_protocol userinfo_delim 0))
         (= (str.split_rest after_protocol userinfo_delim 1) 
            (str.++ host (str.++ path_delim path))))
    (and (= userinfo "")
         (= after_protocol (str.++ host (str.++ path_delim path))))))

; Complex host and port parsing with multiple splits
(assert (ite (str.contains host port_delim)
    (and (= (str.split_at host port_delim 0) 
           (str.substr host 0 (str.indexof host port_delim 0)))
         (= (str.split_at host port_delim 1) port)
         (= (str.num_splits host port_delim) 2))
    (= port "")))

; Advanced path segmentation using str.num_splits
(assert (or (= path "")
    (and (str.prefixof path_delim path)
         (>= (str.num_splits path path_delim) 1))))

; Extract multiple path segments
(declare-const first_path_seg String)
(declare-const second_path_seg String)
(declare-const path_rest String)
(assert (ite (> (str.num_splits path path_delim) 1)
    (and (= first_path_seg (str.split_at path path_delim 1))
         (= path_rest (str.split_rest path path_delim 1))
         (ite (> (str.num_splits path_rest path_delim) 1)
             (and (= second_path_seg (str.split_at path_rest path_delim 0))
                  (= (str.split_rest path_rest path_delim 1) ""))
             (= second_path_seg "")))
    (= first_path_seg "")))

; Complex query parameter parsing with nested splits
(assert (ite (str.contains full_url query_delim)
    (and (= (str.split_at full_url query_delim 0) 
           (str.++ protocol (str.++ protocol_delim 
                   (str.++ (ite (> (str.len userinfo) 0) 
                              (str.++ userinfo userinfo_delim) "") 
                           host path))))
         (= (str.split_at full_url query_delim 1) 
            (str.++ query (ite (str.contains full_url fragment_delim) 
                             (str.++ fragment_delim fragment) "")))
         (>= (str.num_splits query param_delim) 0))
    (= query "")))

; Fragment handling with additional splits
(assert (ite (str.contains full_url fragment_delim)
    (and (= (str.split_at full_url fragment_delim 0) 
           (str.++ protocol (str.++ protocol_delim 
                   (str.++ (ite (> (str.len userinfo) 0) 
                              (str.++ userinfo userinfo_delim) "") 
                           host (str.++ path 
                                (ite (> (str.len query) 0) 
                                   (str.++ query_delim query) ""))))))
         (= (str.split_at full_url fragment_delim 1) fragment))
    (= fragment "")))

; Complex unsatisfiable constraints using multiple splits
(assert (not (and (= protocol "http") 
                 (str.contains (str.split_at host "." 0) "example")
                 (str.prefixof "/admin" path) 
                 (str.contains (str.split_at query param_delim 0) "password"))))

; Multi-level satisfiable constraints
(assert (or (and (= protocol "https")
                (str.contains (str.split_rest host "." 1) "trusted.org")
                (str.prefixof "/public" path)
                (= (str.num_splits path path_delim) 2))
           (and (= protocol "ftp")
                (str.contains host "files.server")
                (str.contains (str.split_at path path_delim 1) "downloads")
                (= (str.num_splits path path_delim) 3))))

; Advanced host validation with domain parsing
(assert (str.contains host "."))
(assert (not (str.prefixof "." host)))
(assert (not (str.suffixof "." host)))
(assert (>= (str.num_splits host ".") 2))

; Extract domain components using splits
(declare-const domain_part1 String)
(declare-const domain_part2 String)
(declare-const domain_rest String)
(assert (= domain_part1 (str.split_at host "." 0)))
(assert (= domain_rest (str.split_rest host "." 1)))
(assert (= domain_part2 (str.split_at domain_rest "." 0)))

; Complex port validation with nested conditions
(assert (ite (not (= port ""))
    (and (str.is_digit port)
         (<= (str.to_int port) 65535)
         (>= (str.to_int port) 1)
         (= (str.num_splits port ".") 1) ; Port cannot contain dots
         (= (str.len port) (str.len (str.split_at port "" 0)))) ; Identity split
    true))

; Additional userinfo constraints if present
(assert (ite (> (str.len userinfo) 0)
    (and (str.contains userinfo ":")
         (= (str.num_splits userinfo ":") 2)
         (>= (str.len (str.split_at userinfo ":" 0)) 1) ; username
         (>= (str.len (str.split_at userinfo ":" 1)) 1)) ; password
    true))

; Final validation combining all parsed components
(assert (= full_url 
    (str.++ protocol 
        protocol_delim
        (ite (> (str.len userinfo) 0) (str.++ userinfo userinfo_delim) "")
        host
        (ite (> (str.len port) 0) (str.++ port_delim port) "")
        path
        (ite (> (str.len query) 0) (str.++ query_delim query) "")
        (ite (> (str.len fragment) 0) (str.++ fragment_delim fragment) ""))))

(check-sat)
(exit)
(get-model)
