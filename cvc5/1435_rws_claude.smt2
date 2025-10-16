(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Variable declarations for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun full_host_part () String)
(declare-fun path_with_query () String)

; URL structure: protocol://host/path?query
(assert (= url "https://api.example.com:8080/users/profile?id=123&format=json"))

; ; Protocol extraction - split by "://" and take first part
(assert (= protocol (str.split_at url "://" 0)))

; ; Extract everything after protocol delimiter
(assert (= full_host_part (str.split_at url "://" 1)))

; ; Host extraction - split the remaining part by "/" and take first segment
(assert (= host (str.split_at full_host_part "/" 0)))

; ; Path with query extraction - get everything after first "/"
(assert (= path_with_query (str.split_rest full_host_part "/" 1)))

; ; Path extraction - split path_with_query by "?" and take first part
(assert (= path (str.split_at path_with_query "?" 0)))

; ; Query string extraction - split by "?" and take second part
(assert (= query_string (str.split_at path_with_query "?" 1)))

; Protocol validation constraints
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))

; Host structure validation - must contain at least one dot for domain
(assert (>= (str.num_splits host ".") 2))

; ; Host port validation - check if host contains port number
(declare-fun host_base () String)
(declare-fun port_str () String)
(assert (= host_base (str.split_at host ":" 0)))
(assert (= port_str (str.split_at host ":" 1)))

; Port number constraints
(assert (or (= port_str "") 
 (and (str.prefixof "80" port_str) (>= (str.len port_str) 2))))

; Path segments validation
(assert (>= (str.num_splits path "/") 1))

; First path segment should be "users"
(declare-fun first_path_segment () String)
(declare-fun second_path_segment () String)
(assert (= first_path_segment (str.split_at path "/" 0)))
(assert (= second_path_segment (str.split_at path "/" 1)))
(assert (= first_path_segment "users"))
(assert (= second_path_segment "profile"))

; Query parameter validation
(assert (>= (str.num_splits query_string "&") 1))

; ; Extract individual query parameters
(declare-fun first_param () String)
(declare-fun second_param () String)
(assert (= first_param (str.split_at query_string "&" 0)))
(assert (= second_param (str.split_at query_string "&" 1)))

; ; Validate parameter structure (key=value)
(assert (>= (str.num_splits first_param "=") 1))
(assert (>= (str.num_splits second_param "=") 1))

; ; Extract parameter names and values
(declare-fun param1_name () String)
(declare-fun param1_value () String)
(declare-fun param2_name () String)
(declare-fun param2_value () String)

(assert (= param1_name (str.split_at first_param "=" 0)))
(assert (= param1_value (str.split_at first_param "=" 1)))
(assert (= param2_name (str.split_at second_param "=" 0)))
(assert (= param2_value (str.split_at second_param "=" 1)))

; Parameter validation
(assert (= param1_name "id"))
(assert (str.is_digit param1_value))
(assert (= param2_name "format"))
(assert (or (= param2_value "json") (= param2_value "xml")))

; Domain validation - host should have proper domain structure
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun tld () String)
(assert (= subdomain (str.split_at host_base "." 0)))
(assert (= domain (str.split_at host_base "." 1)))
(assert (= tld (str.split_at host_base "." 2)))

; Subdomain constraints
(assert (= subdomain "api"))

; Domain constraints
(assert (= domain "example"))

; TLD constraints
(assert (or (= tld "com") (= tld "org") (= tld "net")))

; Additional URL structure constraints
(assert (str.prefixof protocol url))
(assert (str.contains url "://"))
(assert (str.contains url "/"))

; Path depth validation
(assert (>= (str.num_splits path "/") 2))
(assert (<= (str.num_splits path "/") 5))

; Query parameter count validation
(assert (>= (str.num_splits query_string "&") 2))
(assert (<= (str.num_splits query_string "&") 10))

; URL length constraints
(assert (>= (str.len url) 10))
(assert (<= (str.len url) 2048))

; Protocol length validation
(assert (>= (str.len protocol) 3))
(assert (<= (str.len protocol) 5))

; Host validation - no empty segments
(assert (not (= host "")))
(assert (not (= host_base "")))

; Path validation - must start with users
(assert (str.prefixof "users" path))

(check-sat)
(get-model)
