(set-logic QF_SLIA)
(set-info :source |URL Parsing with Protocol, Host, and Path Extraction|)
(set-info :category "crafted")
(set-info :status unknown)

; Declare input URL variable
(declare-fun url () String)

; ; Declare protocol extraction variables
(declare-fun protocol () String)
(declare-fun after_protocol () String)

; Declare host and path separation variables
(declare-fun host_and_path () String)
(declare-fun host () String)
(declare-fun path_with_query () String)

; Declare path segment variables
(declare-fun path_segment_0 () String)
(declare-fun path_segment_1 () String)
(declare-fun path_segment_2 () String)

; Declare query parameter variables
(declare-fun query_string () String)
(declare-fun param_1 () String)
(declare-fun param_2 () String)

; Declare port handling variables
(declare-fun host_with_port () String)
(declare-fun host_only () String)
(declare-fun port_string () String)

; ; Protocol extraction using "://" delimiter
(assert (= protocol (str.split_at url "://" 0)))
(assert (= after_protocol (str.split_at url "://" 1)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; Host and path separation using first "/" after protocol
(assert (= host_with_port (str.split_at after_protocol "/" 0)))
(assert (= path_with_query (str.split_rest after_protocol "/" 1)))

; ; Port handling - check if host contains port specification
(assert (>= (str.num_splits host_with_port ":") 1))
(assert (= host_only (str.split_at host_with_port ":" 0)))

; Host structure validation - must not be empty and contain valid characters
(assert (> (str.len host_only) 0))
(assert (not (str.contains host_only "//")))
(assert (not (str.contains host_only "?")))

; ; Port extraction if present
(assert (=> (> (str.num_splits host_with_port ":") 1)
 (= port_string (str.split_at host_with_port ":" 1))))

; ; Path segment extraction using "/" delimiter
(assert (= path_segment_0 (str.split_at path_with_query "/" 0)))
(assert (= path_segment_1 (str.split_at path_with_query "/" 1)))
(assert (= path_segment_2 (str.split_at path_with_query "/" 2)))

; Query string separation using "?" delimiter
(assert (=> (str.contains path_with_query "?")
 (= query_string (str.split_at path_with_query "?" 1))))

; ; Query parameter extraction using "&" delimiter
(assert (=> (> (str.len query_string) 0)
 (and (= param_1 (str.split_at query_string "&" 0))
 (= param_2 (str.split_at query_string "&" 1)))))

; ; Constraint: URL must have at least 2 segments when split by "://"
(assert (>= (str.num_splits url "://") 2))

; ; Constraint: Path must have at least one segment
(assert (>= (str.num_splits path_with_query "/") 1))

; ; Constraint: First path segment should not be empty for valid URLs
(assert (=> (> (str.num_splits path_with_query "/") 1)
 (> (str.len path_segment_0) 0)))

; ; Constraint: Host validation - common patterns
(assert (or (str.contains host_only ".")
 (= host_only "localhost")))

; ; Constraint: Protocol consistency
(assert (=> (= protocol "https")
 (or (not (str.contains host_with_port ":"))
 (= port_string "443"))))

; ; Constraint: HTTP default port handling
(assert (=> (and (= protocol "http") (str.contains host_with_port ":"))
 (= port_string "80")))

; ; Constraint: Path segments should not contain query parameters
(assert (not (str.contains path_segment_0 "?")))
(assert (not (str.contains path_segment_1 "?")))
(assert (not (str.contains path_segment_2 "?")))

; ; Constraint: Query parameters should contain "=" for key-value pairs
(assert (=> (> (str.len param_1) 0)
 (str.contains param_1 "=")))

; ; Constraint: URL reconstruction consistency
(assert (= url (str.++ protocol "://" after_protocol)))

; ; Constraint: Host and path reconstruction
(assert (= after_protocol (str.++ host_with_port "/" path_with_query)))

; ; Additional constraint: Specific URL pattern matching
(assert (or (str.prefixof "www." host_only)
 (str.prefixof "api." host_only)
 (not (str.contains host_only "."))))

; ; Constraint: Path depth limitation
(assert (<= (str.num_splits path_with_query "/") 5))

; ; Constraint: Query string format validation
(assert (=> (> (str.len query_string) 0)
 (not (str.prefixof "&" query_string))))

; ; Test case constraint: Ensure we have a concrete example
(assert (or (= url "https://www.example.com/api/users?id=123&type=admin")
 (= url "http://localhost:8080/app/dashboard")
 (= url "https://api.service.com:443/v1/data?format=json")))

(check-sat)
(exit)
(get-model)
