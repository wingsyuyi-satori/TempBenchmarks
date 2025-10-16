(set-info :source |URL Parsing with Protocol, Host, and Path Extraction|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare URL components and validation variables
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun full_host_part () String)
(declare-fun path_segment_1 () String)
(declare-fun path_segment_2 () String)
(declare-fun remaining_path () String)

; Declare helper variables for validation
(declare-fun is_valid_protocol () Bool)
(declare-fun is_valid_host () Bool)
(declare-fun has_subdomain () Bool)
(declare-fun has_port () Bool)
(declare-fun has_query_params () Bool)

; ; Sample URL: "https://api.example.com:8080/users/profile?id=123&name=john"
(assert (= url "https://api.example.com:8080/users/profile?id=123&name=john"))

; ; Protocol extraction - split by "://" delimiter
(assert (= protocol (str.split_at url "://" 0)))
(assert (= full_host_part (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (= is_valid_protocol (or (= protocol "http") (= protocol "https"))))
(assert is_valid_protocol)

; Split remaining URL by "/" to separate host from path
(assert (= host (str.split_at full_host_part "/" 0)))
(assert (= remaining_path (str.split_rest full_host_part "/" 1)))

; Host structure validation
; ; Check if host contains subdomain (at least one dot)
(assert (= has_subdomain (> (str.num_splits host ".") 1)))
(assert has_subdomain)

; ; Check if host has port specification
(assert (= has_port (> (str.num_splits host ":") 1)))
(assert has_port)

; ; Extract host components when port is present
(assert (=> has_port 
 (and (= (str.split_at host ":" 0) "api.example.com")
 (= (str.split_at host ":" 1) "8080"))))

; ; Path extraction and validation
; Split path from query parameters
(assert (= path (str.split_at remaining_path "?" 0)))
(assert (= query_string (str.split_at remaining_path "?" 1)))

; ; Check for query parameters
(assert (= has_query_params (> (str.num_splits remaining_path "?") 1)))
(assert has_query_params)

; ; Path segment extraction
(assert (= path_segment_1 (str.split_at path "/" 0)))
(assert (= path_segment_2 (str.split_at path "/" 1)))

; Path validation constraints
(assert (= path_segment_1 "users"))
(assert (= path_segment_2 "profile"))
(assert (= (str.num_splits path "/") 2))

; Query parameter validation
(assert (str.contains query_string "id="))
(assert (str.contains query_string "name="))
(assert (= (str.num_splits query_string "&") 2))

; Additional URL structure constraints
; Protocol must be followed by ://
(assert (str.contains url "://"))

; Host must contain at least one dot for domain structure
(assert (str.contains host "."))

; Path must start after first / following host
(assert (str.prefixof "users" path))

; ; Validate complete URL reconstruction possibility
(assert (str.contains url protocol))
(assert (str.contains url host))
(assert (str.contains url path))

; Host structure detailed validation
; ; Subdomain validation - api.example.com structure
(assert (= (str.split_at (str.split_at host ":" 0) "." 0) "api"))
(assert (= (str.split_at (str.split_at host ":" 0) "." 1) "example"))
(assert (= (str.split_at (str.split_at host ":" 0) "." 2) "com"))

; Port validation - must be numeric (represented as string)
(assert (=> has_port (= (str.len (str.split_at host ":" 1)) 4)))

; Path depth validation
(assert (>= (str.num_splits path "/") 2))
(assert (<= (str.num_splits path "/") 5))

; Query parameter structure validation
(assert (= (str.split_at query_string "&" 0) "id=123"))
(assert (= (str.split_at query_string "&" 1) "name=john"))

; Cross-validation constraints
; Ensure protocol and host combination is valid
(assert (=> (= protocol "https") (not (= (str.split_at host ":" 1) "80"))))
(assert (=> (= protocol "http") (not (= (str.split_at host ":" 1) "443"))))

; Path consistency with host type
(assert (=> (str.contains host "api") (str.contains path "users")))

; URL length constraints for realistic scenarios
(assert (> (str.len url) 20))
(assert (< (str.len url) 200))

; Final validation - ensure all components are non-empty
(assert (> (str.len protocol) 0))
(assert (> (str.len host) 0))
(assert (> (str.len path) 0))

(check-sat)
(get-model)
