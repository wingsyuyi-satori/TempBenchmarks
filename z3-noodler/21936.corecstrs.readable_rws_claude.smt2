(set-info :source |URL Parsing with Protocol, Host, and Path Extraction|)
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare string variables for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun full_host_part () String)
(declare-fun path_segment_1 () String)
(declare-fun path_segment_2 () String)
(declare-fun remaining_path () String)

; Sample URL structure: protocol://host:port/path/to/resource?query=value&param=data
(assert (= url "https://api.example.com:8080/v1/users/profile?id=123&format=json"))

; ; Extract protocol using :// delimiter
(assert (= protocol (str.split_at url "://" 0)))

; ; Extract everything after protocol
(assert (= full_host_part (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host from the part after protocol using / delimiter
(assert (= host (str.split_at full_host_part "/" 0)))

; Host structure validation - must contain at least one dot for domain
(assert (> (str.num_splits host ".") 1))

; ; Extract path part using / delimiter from full_host_part
(assert (= path (str.split_rest full_host_part "/" 1)))

; Path must start with a segment (not empty after first /)
(assert (> (str.num_splits path "/") 0))

; ; Extract first two path segments
(assert (= path_segment_1 (str.split_at path "/" 0)))
(assert (= path_segment_2 (str.split_at path "/" 1)))

; Path segment validation
(assert (> (str.len path_segment_1) 0))
(assert (> (str.len path_segment_2) 0))

; ; Extract remaining path after second segment
(assert (= remaining_path (str.split_rest path "/" 2)))

; ; Query string extraction using ? delimiter
(assert (= query_string (str.split_at url "?" 1)))

; Query string should contain parameters
(assert (> (str.num_splits query_string "&") 0))

; Host should not contain protocol separators
(assert (= (str.num_splits host "://") 0))

; Path validation - should contain at least 3 segments (v1, users, profile)
(assert (>= (str.num_splits path "/") 3))

; Protocol should be exactly "https" for this secure API
(assert (= protocol "https"))

; Host should be a subdomain structure
(assert (str.contains host "api."))
(assert (str.contains host ".com"))

; First path segment should be version indicator
(assert (str.prefixof "v" path_segment_1))

; Additional constraints for realistic URL structure
(assert (not (str.contains protocol "/")))
(assert (not (str.contains host "?")))
(assert (not (str.contains path_segment_1 ":")))

; ; Port extraction from host if present
(declare-fun host_without_port () String)
(declare-fun port () String)

; Split host by : to separate hostname and port
(assert (= host_without_port (str.split_at host ":" 0)))
(assert (= port (str.split_at host ":" 1)))

; ; Port should be numeric (simplified check - port exists and is not empty)
(assert (> (str.len port) 0))
(assert (< (str.len port) 6))

; Host without port should be valid domain
(assert (> (str.num_splits host_without_port ".") 1))
(assert (str.contains host_without_port "example"))

; Query parameter validation
(declare-fun param1 () String)
(declare-fun param2 () String)

(assert (= param1 (str.split_at query_string "&" 0)))
(assert (= param2 (str.split_at query_string "&" 1)))

; Parameters should contain = for key-value pairs
(assert (str.contains param1 "="))
(assert (str.contains param2 "="))

; ; Extract parameter keys
(declare-fun param1_key () String)
(declare-fun param2_key () String)

(assert (= param1_key (str.split_at param1 "=" 0)))
(assert (= param2_key (str.split_at param2 "=" 0)))

; Parameter key validation
(assert (> (str.len param1_key) 0))
(assert (> (str.len param2_key) 0))
(assert (not (= param1_key param2_key)))

; Comprehensive URL structure validation
(assert (str.prefixof protocol url))
(assert (str.contains url "://"))
(assert (str.contains url "/"))
(assert (str.contains url "?"))

; Path depth validation - should have exactly 3 main segments
(assert (= (str.num_splits path "/") 4))

; Security constraint - no suspicious characters in path
(assert (not (str.contains path "..")))
(assert (not (str.contains path "<")))
(assert (not (str.contains path ">")))

(check-sat)
(get-model)
