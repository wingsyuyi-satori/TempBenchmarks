(set-logic QF_SLIA)
(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :category "industrial")

; Declare string variables for URL components
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)

; Declare auxiliary variables for parsing
(declare-fun protocol_host_part () String)
(declare-fun host_path_part () String)
(declare-fun path_query_part () String)
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun port () String)

; URL structure: protocol://host/path?query
(assert (= url "https://www.example.com:8080/api/users/123?id=456&type=admin"))

; ; Protocol extraction using "://" delimiter
(assert (= (str.num_splits url "://") 2))
(assert (= protocol (str.split_at url "://" 0)))
(assert (= protocol_host_part (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host and path using "/" delimiter from protocol_host_part
(assert (>= (str.num_splits protocol_host_part "/") 2))
(assert (= host_path_part (str.split_at protocol_host_part "/" 0)))
(assert (= path_query_part (str.split_rest protocol_host_part "/" 1)))

; ; Host structure validation - check for port number using ":" delimiter
(assert (or 
 (and (= (str.num_splits host_path_part ":") 1)
 (= host host_path_part)
 (= port ""))
 (and (= (str.num_splits host_path_part ":") 2)
 (= host (str.split_at host_path_part ":" 0))
 (= port (str.split_at host_path_part ":" 1)))))

; Host must contain at least one dot for domain structure
(assert (>= (str.num_splits host ".") 2))
(assert (= subdomain (str.split_at host "." 0)))
(assert (= domain (str.split_rest host "." 1)))

; Subdomain validation - common prefixes
(assert (or (= subdomain "www") (= subdomain "api") (= subdomain "mail")))

; Path and query separation using "?" delimiter
(assert (or
 (and (= (str.num_splits path_query_part "?") 1)
 (= path path_query_part)
 (= query_string ""))
 (and (= (str.num_splits path_query_part "?") 2)
 (= path (str.split_at path_query_part "?" 0))
 (= query_string (str.split_at path_query_part "?" 1)))))

; Path segments validation - must start with /
(assert (str.prefixof "/" path))
(assert (>= (str.num_splits path "/") 3))

; ; Extract specific path segments
(declare-fun path_segment_1 () String)
(declare-fun path_segment_2 () String)
(declare-fun path_segment_3 () String)

(assert (= path_segment_1 (str.split_at path "/" 1)))
(assert (= path_segment_2 (str.split_at path "/" 2)))
(assert (= path_segment_3 (str.split_at path "/" 3)))

; API path structure validation
(assert (= path_segment_1 "api"))
(assert (or (= path_segment_2 "users") (= path_segment_2 "products")))

; Query parameter validation using "&" delimiter
(assert (>= (str.num_splits query_string "&") 1))

(declare-fun param_1 () String)
(declare-fun param_2 () String)

(assert (= param_1 (str.split_at query_string "&" 0)))
(assert (= param_2 (str.split_at query_string "&" 1)))

; Parameter structure validation using "=" delimiter
(assert (= (str.num_splits param_1 "=") 2))
(assert (= (str.num_splits param_2 "=") 2))

(declare-fun param_1_key () String)
(declare-fun param_1_value () String)
(declare-fun param_2_key () String)
(declare-fun param_2_value () String)

(assert (= param_1_key (str.split_at param_1 "=" 0)))
(assert (= param_1_value (str.split_at param_1 "=" 1)))
(assert (= param_2_key (str.split_at param_2 "=" 0)))
(assert (= param_2_value (str.split_at param_2 "=" 1)))

; Specific parameter validation
(assert (or (= param_1_key "id") (= param_1_key "type")))
(assert (or (= param_2_key "id") (= param_2_key "type")))
(assert (not (= param_1_key param_2_key)))

; Port number validation - must be numeric string between 1-65535
(assert (or (= port "") 
 (and (not (= port ""))
 (or (= port "80") (= port "443") (= port "8080") (= port "3000")))))

; ; Additional constraint: ensure protocol matches default ports
(assert (or (not (= port ""))
 (and (= protocol "https") (= port "443"))
 (and (= protocol "http") (= port "80"))))

; Domain validation - must be valid domain name
(assert (str.suffixof ".com" domain))

; Path segment numeric validation for ID
(assert (or (= path_segment_3 "123") (= path_segment_3 "456") (= path_segment_3 "789")))

; Ensure consistent URL reconstruction
(declare-fun reconstructed_url () String)
(assert (= reconstructed_url 
 (str.++ protocol "://" host 
 (ite (= port "") "" (str.++ ":" port))
 "/" path_query_part)))

; The reconstructed URL should match original (without port assumption)
(assert (or (= url reconstructed_url)
 (str.contains url (str.++ protocol "://" host))))

(check-sat)
(get-model)
