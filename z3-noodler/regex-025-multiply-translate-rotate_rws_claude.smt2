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

; Basic URL structure: protocol://host/path?query
(assert (= url "https://api.example.com:8080/v1/users/123?id=456&type=admin"))

; ; Extract protocol (before "://")
(assert (= protocol (str.split_at url "://" 0)))

; ; Extract everything after protocol separator
(assert (= full_host_part (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host from the part after protocol (before first "/")
(assert (= host (str.split_at full_host_part "/" 0)))

; Host structure validation - must contain at least one dot for domain
(assert (>= (str.num_splits host ".") 2))

; ; Extract path part (after host, before query if exists)
(assert (= path (str.split_at full_host_part "/" 1)))

; ; Path segments extraction
(assert (= path_segment_1 (str.split_at path "/" 0)))
(assert (= path_segment_2 (str.split_at path "/" 1)))

; Get remaining path segments after first two
(assert (= remaining_path (str.split_rest path "/" 2)))

; Path validation constraints
(assert (= path_segment_1 "v1"))
(assert (= path_segment_2 "users"))
(assert (str.contains remaining_path "123"))

; ; Query string extraction (after "?" if it exists)
(assert (str.contains url "?"))
(assert (= query_string (str.split_at url "?" 1)))

; Query parameters validation
(assert (>= (str.num_splits query_string "&") 2))
(assert (str.contains query_string "id=456"))
(assert (str.contains query_string "type=admin"))

; ; Host port validation - check if port is specified
(assert (str.contains host ":"))
(declare-fun host_name () String)
(declare-fun port () String)
(assert (= host_name (str.split_at host ":" 0)))
(assert (= port (str.split_at host ":" 1)))
(assert (= port "8080"))

; Domain structure validation
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun tld () String)
(assert (= subdomain (str.split_at host_name "." 0)))
(assert (= domain (str.split_at host_name "." 1)))
(assert (= tld (str.split_at host_name "." 2)))
(assert (= subdomain "api"))
(assert (= domain "example"))
(assert (= tld "com"))

; Additional constraints for URL structure validation
(assert (> (str.len protocol) 0))
(assert (> (str.len host) 0))
(assert (> (str.len path) 0))

; Ensure protocol is followed by correct separator
(assert (str.contains url (str.++ protocol "://")))

; Path must start with version indicator
(assert (str.prefixof "v" path_segment_1))

; Ensure URL has proper structure
(assert (= (str.num_splits url "://") 2))
(assert (= (str.num_splits url "?") 2))

; Additional path segment constraints
(assert (>= (str.num_splits path "/") 3))

; Query parameter structure validation
(declare-fun param1 () String)
(declare-fun param2 () String)
(assert (= param1 (str.split_at query_string "&" 0)))
(assert (= param2 (str.split_at query_string "&" 1)))
(assert (str.contains param1 "="))
(assert (str.contains param2 "="))

; ; Validate parameter names and values
(declare-fun param1_name () String)
(declare-fun param1_value () String)
(declare-fun param2_name () String)
(declare-fun param2_value () String)
(assert (= param1_name (str.split_at param1 "=" 0)))
(assert (= param1_value (str.split_at param1 "=" 1)))
(assert (= param2_name (str.split_at param2 "=" 0)))
(assert (= param2_value (str.split_at param2 "=" 1)))

; Specific parameter validation
(assert (= param1_name "id"))
(assert (= param1_value "456"))
(assert (= param2_name "type"))
(assert (= param2_value "admin"))

; Ensure no empty segments in critical parts
(assert (not (= protocol "")))
(assert (not (= host_name "")))
(assert (not (= path_segment_1 "")))
(assert (not (= path_segment_2 "")))

; URL length constraints for realistic validation
(assert (>= (str.len url) 20))
(assert (<= (str.len url) 2048))

(check-sat)
(exit)
(get-model)
