(set-info :source |URL parsing with protocol, host, and path extraction|)
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Variable declarations for URL parsing
(declare-fun url () String)
(declare-fun protocol () String)
(declare-fun host () String)
(declare-fun path () String)
(declare-fun query_string () String)
(declare-fun port_str () String)
(declare-fun first_path_segment () String)
(declare-fun second_path_segment () String)

; URL structure: protocol://host:port/path?query
; ; Example: https://www.example.com:8080/api/users?id=123

; Basic URL structure constraints
(assert (> (str.len url) 10))
(assert (str.contains url "://"))
(assert (str.contains url "/"))

; ; Protocol extraction: everything before "://"
(assert (= protocol (str.split_at url "://" 0)))

; Protocol validation - must be http or https
(assert (or (= protocol "http") (= protocol "https")))

; ; Host extraction from the part after protocol
(assert (let ((after_protocol (str.split_at url "://" 1)))
 (= host (str.split_at after_protocol "/" 0))))

; Host structure validation - must contain at least one dot for domain
(assert (str.contains host "."))
(assert (> (str.len host) 3))
(assert (not (str.prefixof "." host)))
(assert (not (str.suffixof "." host)))

; ; Port handling - check if host contains port
(assert (=> (str.contains host ":")
 (and
; ; Extract port number
 (= port_str (str.split_at host ":" 1))
; ; Port must be numeric (simplified check - length between 1-5)
 (and (> (str.len port_str) 0) (< (str.len port_str) 6))
 ; Update host to be without port
 (= host (str.split_at host ":" 0))
)
))

; ; Path extraction - everything after first "/" following host
(assert (let ((after_protocol (str.split_at url "://" 1)))
 (let ((remaining_after_host (str.split_rest after_protocol "/" 1)))
 (= path (str.split_at remaining_after_host "?" 0))
)
))

; Path segment validation
(assert (=> (> (str.len path) 0)
 (and
 ; First path segment
 (= first_path_segment (str.split_at path "/" 0))
 (> (str.len first_path_segment) 0)
 
 ; If there are multiple path segments
 (=> (> (str.num_splits path "/") 1)
 (and
 (= second_path_segment (str.split_at path "/" 1))
 (> (str.len second_path_segment) 0)
 ; Path segments should not contain invalid characters
 (not (str.contains first_path_segment "?"))
 (not (str.contains second_path_segment "?"))
)
)
)
))

; ; Query string extraction if present
(assert (=> (str.contains url "?")
 (and
 (= query_string (str.split_at url "?" 1))
 (> (str.len query_string) 0)
 ; Query parameters validation
 (=> (str.contains query_string "&")
 (> (str.num_splits query_string "&") 0)
)
)
))

; Realistic URL constraints
(assert (or
 ; Case 1: HTTPS URL with standard port and API path
 (and
 (= protocol "https")
 (str.contains host "api")
 (str.prefixof "api" first_path_segment)
)
 
 ; Case 2: HTTP URL with custom port
 (and
 (= protocol "http")
 (str.contains host ":")
 (= port_str "8080")
)
 
 ; Case 3: Standard web URL
 (and
 (= protocol "https")
 (str.prefixof "www." host)
 (not (str.contains host ":"))
)
))

; Additional validation constraints
(assert (not (str.contains protocol "/")))
(assert (not (str.contains protocol ":")))
(assert (not (= host "")))

; URL length constraints for realism
(assert (< (str.len url) 200))
(assert (> (str.len url) 15))

; Host domain structure - at least one subdomain
(assert (>= (str.num_splits host ".") 1))

; Path structure constraints
(assert (=> (> (str.len path) 1)
 (and
 ; Path should start with meaningful segment
 (not (= first_path_segment ""))
 ; Common API patterns
 (or 
 (str.contains path "api")
 (str.contains path "v1")
 (str.contains path "users")
 (str.contains path "data")
)
)
))

(check-sat)
(get-model)
