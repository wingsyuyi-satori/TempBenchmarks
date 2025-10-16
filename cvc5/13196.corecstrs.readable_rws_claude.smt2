(set-info :source |URL Parsing with Protocol, Host, and Path Extraction|)
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare string variables for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun port () String)
(declare-fun path () String)
(declare-fun query_string () String)

; Declare auxiliary variables for parsing
(declare-fun protocol_host_part () String)
(declare-fun host_port_part () String)
(declare-fun path_query_part () String)
(declare-fun base_host () String)

; ; Example URL structure: https://api.example.com:8080/users/profile?id=123&type=admin
(assert (= url "https://api.example.com:8080/users/profile?id=123&type=admin"))

; ; Protocol extraction using :// delimiter
(assert (= (str.num_splits url "://") 2))
(assert (= protocol (str.split_at url "://" 0)))
(assert (= protocol_host_part (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host and path using first / after protocol
(assert (>= (str.num_splits protocol_host_part "/") 2))
(assert (= host_port_part (str.split_at protocol_host_part "/" 0)))
(assert (= path_query_part (str.split_rest protocol_host_part "/" 1)))

; ; Host structure validation - check for port separation
(assert (>= (str.num_splits host_port_part ":") 1))

; ; If port exists, extract host and port
(assert (=> (= (str.num_splits host_port_part ":") 2)
 (and (= base_host (str.split_at host_port_part ":" 0))
 (= port (str.split_at host_port_part ":" 1)))))

; If no port, host is the entire host_port_part
(assert (=> (= (str.num_splits host_port_part ":") 1)
 (and (= base_host host_port_part)
 (= port ""))))

(assert (= host base_host))

; Host structure validation - must contain at least one dot for domain
(assert (>= (str.num_splits host ".") 2))

; Host validation - cannot start or end with dot
(assert (not (str.prefixof "." host)))
(assert (not (str.suffixof "." host)))

; Port validation - if present, must be non-empty
(assert (=> (= (str.num_splits host_port_part ":") 2)
 (not (= port ""))))

; ; Path extraction - separate path from query string
(assert (>= (str.num_splits path_query_part "?") 1))

; ; If query exists, extract path and query
(assert (=> (= (str.num_splits path_query_part "?") 2)
 (and (= path (str.split_at path_query_part "?" 0))
 (= query_string (str.split_at path_query_part "?" 1)))))

; If no query, path is the entire path_query_part
(assert (=> (= (str.num_splits path_query_part "?") 1)
 (and (= path path_query_part)
 (= query_string ""))))

; Path segments validation - must start with /
(assert (str.prefixof "/" path))

; Path should have meaningful segments
(assert (>= (str.num_splits path "/") 3))

; ; Validate specific path segments
(declare-fun first_segment () String)
(declare-fun second_segment () String)
(assert (= first_segment (str.split_at path "/" 1)))
(assert (= second_segment (str.split_at path "/" 2)))

; Path segments should not be empty (except root)
(assert (not (= first_segment "")))
(assert (not (= second_segment "")))

; Query string validation if present
(assert (=> (not (= query_string ""))
 (>= (str.num_splits query_string "&") 1)))

; ; Additional constraint: protocol must match expected security level
(declare-fun is_secure () Bool)
(assert (= is_secure (= protocol "https")))

; Secure connections should use standard HTTPS port or custom port
(assert (=> is_secure
 (or (= port "")
 (= port "443")
 (and (not (= port "80"))
 (not (= port "8080"))))))

; Host domain validation - specific structure
(declare-fun domain_parts () Int)
(assert (= domain_parts (str.num_splits host ".")))
(assert (>= domain_parts 2))
(assert (<= domain_parts 5))

; TLD validation - last part should be valid
(declare-fun tld () String)
(assert (= tld (str.split_at host "." (- domain_parts 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Subdomain validation for API endpoints
(assert (=> (str.prefixof "api." host)
 (>= domain_parts 3)))

; Path depth constraints for API endpoints
(assert (=> (str.prefixof "api." host)
 (>= (str.num_splits path "/") 3)))

; Resource path validation
(declare-fun resource_path () String)
(assert (= resource_path (str.split_rest path "/" 2)))
(assert (not (= resource_path "")))

; Query parameter validation
(assert (=> (str.contains query_string "id=")
 (str.contains query_string "&")))

; URL length constraints
(assert (>= (str.len url) 10))
(assert (<= (str.len url) 2000))

; Component length constraints
(assert (>= (str.len protocol) 4))
(assert (<= (str.len protocol) 5))
(assert (>= (str.len host) 4))
(assert (<= (str.len host) 253))
(assert (>= (str.len path) 1))

(check-sat)
(get-model)
