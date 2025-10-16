(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :status unknown)
(set-logic QF_SLIA)

; Variable declarations for URL components
(declare-const url String)
(declare-const protocol String)
(declare-const host String)
(declare-const path String)
(declare-const query_string String)
(declare-const full_host_part String)
(declare-const path_segment_1 String)
(declare-const path_segment_2 String)
(declare-const param_key String)
(declare-const param_value String)

; Constants for valid protocols
(declare-const http_protocol String)
(declare-const https_protocol String)
(declare-const ftp_protocol String)

; Initialize protocol constants
(assert (= http_protocol "http"))
(assert (= https_protocol "https"))
(assert (= ftp_protocol "ftp"))

; Sample URL structure: protocol://host:port/path/to/resource?key=value&other=param
(assert (= url "https://api.example.com:8080/users/profile?id=123&format=json"))

; ; Protocol extraction using :// delimiter
(assert (= protocol (str.split_at url "://" 0)))
(assert (= full_host_part (str.split_at url "://" 1)))

; Protocol validation - must be one of the valid protocols
(assert (or 
 (= protocol http_protocol)
 (= protocol https_protocol)
 (= protocol ftp_protocol)))

; ; Host extraction from the part after protocol
; Split by / to separate host from path
(assert (= host (str.split_at full_host_part "/" 0)))

; Host structure validation - must contain at least one dot for domain
(assert (>= (str.num_splits host ".") 2))

; ; Extract domain parts for validation
(declare-const subdomain String)
(declare-const domain_name String)
(declare-const tld String)

; ; Split host by dots to validate structure
(assert (= subdomain (str.split_at host "." 0)))
(assert (= domain_name (str.split_at host "." 1)))
(assert (= tld (str.split_at host "." 2)))

; Host validation constraints
(assert (> (str.len subdomain) 0))
(assert (> (str.len domain_name) 0))
(assert (> (str.len tld) 0))

; ; Check if host contains port (has colon)
(declare-const host_with_port String)
(declare-const actual_host String)
(declare-const port String)

(assert (= host_with_port host))
(assert (or
 ; Case 1: No port specified
 (and 
 (= (str.num_splits host_with_port ":") 1)
 (= actual_host host_with_port)
 (= port ""))
 ; Case 2: Port specified
 (and 
 (= (str.num_splits host_with_port ":") 2)
 (= actual_host (str.split_at host_with_port ":" 0))
 (= port (str.split_at host_with_port ":" 1)))))

; ; Path extraction - everything after first / in full_host_part
(assert (= path (str.split_rest full_host_part "/" 1)))

; Path segments validation
(assert (> (str.num_splits path "/") 1))
(assert (= path_segment_1 (str.split_at path "/" 0)))
(assert (= path_segment_2 (str.split_at path "/" 1)))

; Path segments must be non-empty for valid URLs
(assert (> (str.len path_segment_1) 0))
(assert (> (str.len path_segment_2) 0))

; ; Query string extraction using ? delimiter
(declare-const path_and_query String)
(assert (= path_and_query path))

(assert (or
 ; Case 1: No query parameters
 (and 
 (= (str.num_splits path_and_query "?") 1)
 (= query_string ""))
 ; Case 2: Query parameters present
 (and 
 (= (str.num_splits path_and_query "?") 2)
 (= query_string (str.split_at path_and_query "?" 1)))))

; Query parameter validation when present
(assert (=> (> (str.len query_string) 0)
 (and
 ; Must have at least one parameter
 (>= (str.num_splits query_string "&") 1)
; ; Extract first parameter
 (= param_key (str.split_at (str.split_at query_string "&" 0) "=" 0))
 (= param_value (str.split_at (str.split_at query_string "&" 0) "=" 1))
 ; Parameter key and value must be non-empty
 (> (str.len param_key) 0)
 (> (str.len param_value) 0))))

; Additional URL structure constraints
; Protocol must be followed by ://
(assert (str.contains url (str.++ protocol "://")))

; URL must contain the host after protocol
(assert (str.contains url host))

; ; Path must start with / (already validated through split structure)
(assert (str.prefixof "/" (str.split_rest full_host_part "/" 1)))

; ; Security constraint: protocol should be https for secure connections
(declare-const is_secure Bool)
(assert (= is_secure (= protocol https_protocol)))

; URL length constraints for practical limits
(assert (> (str.len url) 10))
(assert (< (str.len url) 2048))

; Host name constraints
(assert (not (str.contains actual_host " ")))
(assert (not (str.prefixof "." actual_host)))
(assert (not (str.suffixof "." actual_host)))

; Port validation when present
(assert (=> (> (str.len port) 0)
 (and
 (> (str.len port) 0)
 (< (str.len port) 6))))

; ; Consistency check: URL should be reconstructable from parts
(declare-const reconstructed_base String)
(assert (= reconstructed_base (str.++ protocol "://" host)))

; The reconstructed base should be a prefix of the original URL
(assert (str.prefixof reconstructed_base url))

; ; Complex constraint: if protocol is https, port should be 443 or empty
(assert (=> (= protocol https_protocol)
 (or (= port "") (= port "443") (= port "8080"))))

; Path depth constraint for API URLs
(assert (>= (str.num_splits path "/") 3))

; ; Specific validation for example URL structure
(assert (str.contains url "example.com"))
(assert (str.contains path "users"))

(check-sat)
(get-model)
