(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-info :status unknown)
(set-logic QF_SLIA)

; String variable declarations for URL parsing
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)

; Helper variables for parsing components
(declare-fun after_protocol () String)
(declare-fun host_and_path () String)
(declare-fun path_segments () String)
(declare-fun first_path_segment () String)
(declare-fun second_path_segment () String)

; Variables for host structure validation
(declare-fun host_parts () String)
(declare-fun domain () String)
(declare-fun port () String)

; Basic URL structure: protocol://host/path?query
(assert (= url "https://api.example.com:8443/v1/users?limit=10&offset=20"))

; ; Protocol extraction using :// delimiter
(assert (= (str.num_splits url "://") 2))
(assert (= protocol (str.split_at url "://" 0)))
(assert (= after_protocol (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Extract host and path using / delimiter on remaining URL
(assert (>= (str.num_splits after_protocol "/") 2))
(assert (= host_and_path (str.split_at after_protocol "/" 0)))
(assert (= path_segments (str.split_rest after_protocol "/" 1)))

; ; Host structure validation - check for port
(assert (>= (str.num_splits host_and_path ":") 1))
(assert (= domain (str.split_at host_and_path ":" 0)))
(assert (= port (str.split_at host_and_path ":" 1)))

; Domain validation - must contain at least one dot
(assert (>= (str.num_splits domain ".") 2))
(assert (str.contains domain "example.com"))

; ; Port validation - must be numeric (simplified check)
(assert (= port "8443"))

; ; Path segments extraction and validation
(assert (>= (str.num_splits path_segments "/") 2))
(assert (= first_path_segment (str.split_at path_segments "/" 0)))
(assert (= second_path_segment (str.split_at path_segments "/" 1)))

; Path segment validation
(assert (= first_path_segment "v1"))
(assert (str.contains second_path_segment "users"))

; ; Query string extraction using ? delimiter
(assert (= (str.num_splits path_segments "?") 2))
(assert (= query_string (str.split_at path_segments "?" 1)))

; Query parameter validation using & delimiter
(assert (>= (str.num_splits query_string "&") 2))
(assert (str.contains (str.split_at query_string "&" 0) "limit"))
(assert (str.contains (str.split_at query_string "&" 1) "offset"))

; ; Additional constraint: protocol must match expected secure protocol
(assert (= protocol "https"))

; Host must be a valid API endpoint
(assert (str.prefixof "api." domain))

; Path must start with version identifier
(assert (str.prefixof "v" first_path_segment))

; Ensure path has proper REST structure
(assert (str.contains second_path_segment "users"))

; Query parameters must contain pagination info
(assert (str.contains query_string "limit"))
(assert (str.contains query_string "offset"))

; ; Complex constraint: validate complete URL structure
(assert (and 
 (str.contains url protocol)
 (str.contains url "://")
 (str.contains url domain)
 (str.contains url first_path_segment)
 (str.contains url second_path_segment)))

; Unsatisfiable constraint combination for testing
; (assert (= protocol "ftp")) ; This would make the constraint unsatisfiable

(check-sat)
(exit)
(get-model)
