(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :status unknown)
(set-logic QF_SLIA)

; Declare string variables for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun full_host_part () String)
(declare-fun path_with_query () String)

; Declare integer variables for split counts
(declare-fun protocol_splits () Int)
(declare-fun slash_splits () Int)
(declare-fun query_splits () Int)
(declare-fun host_colon_splits () Int)
(declare-fun domain_parts () Int)
(declare-fun path_segments () Int)
(declare-fun param_count () Int)

; Declare additional string variables
(declare-fun base_host () String)
(declare-fun port () String)
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun tld () String)
(declare-fun first_segment () String)
(declare-fun second_segment () String)
(declare-fun first_param () String)
(declare-fun param_key () String)
(declare-fun param_value () String)

; Basic URL structure
(assert (= url "https://api.example.com:8080/users/profile?id=123&format=json"))

; ; Protocol extraction using :// delimiter
(assert (= protocol_splits (str.num_splits url "://")))
(assert (>= protocol_splits 2))
(assert (= protocol (str.split_at url "://" 0)))

; ; Extract everything after protocol
(assert (= full_host_part (str.split_at url "://" 1)))

; Host and path separation using first / after protocol
(assert (= slash_splits (str.num_splits full_host_part "/")))
(assert (>= slash_splits 1))
(assert (= host (str.split_at full_host_part "/" 0)))

; ; Path extraction everything after first /
(assert (= path_with_query (str.split_rest full_host_part "/" 1)))

; Query string separation using ?
(assert (= query_splits (str.num_splits path_with_query "?")))
(assert (or 
 (and (= query_splits 1) (= path path_with_query) (= query_string ""))
 (and (>= query_splits 2) 
 (= path (str.split_at path_with_query "?" 0))
 (= query_string (str.split_at path_with_query "?" 1)))))

; Protocol validation constraints
(assert (or (= protocol "http") (= protocol "https") (= protocol "ftp")))
(assert (>= (str.len protocol) 3))

; ; Host structure validation - check for port using : delimiter
(assert (= host_colon_splits (str.num_splits host ":")))
(assert (or 
 (and (= host_colon_splits 1) (= base_host host) (= port ""))
 (and (>= host_colon_splits 2) 
 (= base_host (str.split_at host ":" 0))
 (= port (str.split_at host ":" 1)))))

; Host domain validation using . delimiter
(assert (= domain_parts (str.num_splits base_host ".")))
(assert (>= domain_parts 2))

; ; Extract domain components when we have at least 3 parts
(assert (>= domain_parts 3))
(assert (= subdomain (str.split_at base_host "." 0)))
(assert (= domain (str.split_at base_host "." 1)))
(assert (= tld (str.split_at base_host "." 2)))

; Domain validation
(assert (>= (str.len subdomain) 1))
(assert (>= (str.len domain) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Path segments validation using / delimiter
(assert (= path_segments (str.num_splits path "/")))
(assert (>= path_segments 1))

; ; Extract specific path segments when available
(assert (>= path_segments 2))
(assert (= first_segment (str.split_at path "/" 0)))
(assert (= second_segment (str.split_at path "/" 1)))

; Path segment constraints
(assert (>= (str.len first_segment) 1))
(assert (>= (str.len second_segment) 1))

; Query parameter validation using & delimiter
(assert (= param_count (str.num_splits query_string "&")))
(assert (>= param_count 1))

; ; Extract first query parameter
(assert (= first_param (str.split_at query_string "&" 0)))

; Parameter key-value separation using = delimiter
(declare-fun param_kv_splits () Int)
(assert (= param_kv_splits (str.num_splits first_param "=")))
(assert (>= param_kv_splits 2))
(assert (= param_key (str.split_at first_param "=" 0)))
(assert (= param_value (str.split_at first_param "=" 1)))

; Parameter validation
(assert (>= (str.len param_key) 1))
(assert (>= (str.len param_value) 1))

; Port validation when present
(assert (=> (not (= port "")) 
 (and (>= (str.len port) 1) (<= (str.len port) 5))))

; ; Additional consistency checks
(assert (str.contains url "://"))
(assert (str.contains url host))
(assert (str.contains base_host "."))

; Security constraints
(assert (not (str.contains url "..")))
(assert (not (str.contains path_with_query "..")))

; Length constraints
(assert (<= (str.len url) 2048))
(assert (<= (str.len path) 1024))
(assert (<= (str.len query_string) 1024))
(assert (>= (str.len host) 4))
(assert (<= (str.len host) 253))

; Ensure proper URL structure relationships
(assert (str.prefixof protocol url))
(assert (str.contains url full_host_part))

(check-sat)
(get-model)
