(set-info :source |
; URL Parsing with Protocol, Host, and Path Extraction
 Demonstrates string split operations for web URL processing
|)
(set-info :status unknown)
(set-logic QF_SLIA)

; URL string variables
(declare-fun url1 () String)
(declare-fun url2 () String)
(declare-fun url3 () String)

; ; Protocol extraction variables
(declare-fun protocol1 () String)
(declare-fun protocol2 () String)
(declare-fun protocol3 () String)

; ; Host extraction variables
(declare-fun host1 () String)
(declare-fun host2 () String)
(declare-fun host3 () String)

; Path and query variables
(declare-fun path1 () String)
(declare-fun path2 () String)
(declare-fun query_part1 () String)
(declare-fun query_part2 () String)

; Path segment variables
(declare-fun segment1_1 () String)
(declare-fun segment1_2 () String)
(declare-fun segment2_1 () String)
(declare-fun segment2_2 () String)

; Query parameter variables
(declare-fun param_key1 () String)
(declare-fun param_value1 () String)
(declare-fun param_key2 () String)
(declare-fun param_value2 () String)

; Host subdomain variables
(declare-fun subdomain () String)
(declare-fun domain () String)
(declare-fun tld () String)

; URL structure constraints - basic format validation
(assert (= url1 "https://www.example.com/api/users?id=123&name=john"))
(assert (= url2 "http://api.service.org/v1/data/items"))
(assert (= url3 "ftp://files.server.net:21/public/docs"))

; ; Protocol validation - extract and validate protocols
(assert (= protocol1 (str.split_at url1 "://" 0)))
(assert (= protocol2 (str.split_at url2 "://" 0)))
(assert (= protocol3 (str.split_at url3 "://" 0)))

; Protocol validation constraints
(assert (or (= protocol1 "http") (= protocol1 "https") (= protocol1 "ftp")))
(assert (or (= protocol2 "http") (= protocol2 "https") (= protocol2 "ftp")))
(assert (or (= protocol3 "http") (= protocol3 "https") (= protocol3 "ftp")))

; ; Host extraction from URLs
(assert (= host1 (str.split_at (str.split_at url1 "://" 1) "/" 0)))
(assert (= host2 (str.split_at (str.split_at url2 "://" 1) "/" 0)))

; Host structure validation - subdomain.domain.tld format
(assert (= subdomain (str.split_at host1 "." 0)))
(assert (= domain (str.split_at host1 "." 1)))
(assert (= tld (str.split_at host1 "." 2)))

; Host structure constraints
(assert (= subdomain "www"))
(assert (= domain "example"))
(assert (= tld "com"))
(assert (= (str.num_splits host1 ".") 3))

; ; Path extraction and validation
(assert (= path1 (str.split_at (str.split_at url1 "://" 1) "?" 0)))
(assert (= path2 (str.split_at (str.split_at url2 "://" 1) "?" 0)))

; ; Path segment extraction
(assert (= segment1_1 (str.split_at path1 "/" 2)))
(assert (= segment1_2 (str.split_at path1 "/" 3)))
(assert (= segment2_1 (str.split_at path2 "/" 2)))
(assert (= segment2_2 (str.split_at path2 "/" 3)))

; Path segment validation
(assert (= segment1_1 "api"))
(assert (= segment1_2 "users"))
(assert (= segment2_1 "v1"))
(assert (= segment2_2 "data"))

; Query string processing
(assert (= query_part1 (str.split_at url1 "?" 1)))
(assert (not (= query_part1 "")))

; ; Query parameter extraction
(assert (= param_key1 (str.split_at (str.split_at query_part1 "&" 0) "=" 0)))
(assert (= param_value1 (str.split_at (str.split_at query_part1 "&" 0) "=" 1)))
(assert (= param_key2 (str.split_at (str.split_at query_part1 "&" 1) "=" 0)))
(assert (= param_value2 (str.split_at (str.split_at query_part1 "&" 1) "=" 1)))

; Query parameter validation
(assert (= param_key1 "id"))
(assert (= param_value1 "123"))
(assert (= param_key2 "name"))
(assert (= param_value2 "john"))

; Port handling for URL3
(assert (= host3 (str.split_at (str.split_at url3 "://" 1) ":" 0)))
(assert (= host3 "files.server.net"))

; Advanced path validation - ensure proper API structure
(assert (>= (str.num_splits path1 "/") 3))
(assert (>= (str.num_splits path2 "/") 4))

; Protocol-specific constraints
(assert (=> (= protocol1 "https") (str.contains host1 ".")))
(assert (=> (= protocol2 "http") (not (= host2 ""))))
(assert (=> (= protocol3 "ftp") (str.contains url3 ":")))

; Cross-validation between URLs
(assert (not (= protocol1 protocol3)))
(assert (not (= host1 host2)))
(assert (str.prefixof "/api" (str.split_rest path1 "/" 1)))

; Path depth validation
(assert (= (str.num_splits path1 "/") 4))
(assert (= (str.num_splits path2 "/") 5))

; Query parameter count validation
(assert (= (str.num_splits query_part1 "&") 2))

; Host subdomain validation - ensure proper structure
(assert (str.prefixof "www" host1))
(assert (str.suffixof ".com" host1))
(assert (str.suffixof ".org" host2))

; Path segment non-empty validation
(assert (not (= segment1_1 "")))
(assert (not (= segment1_2 "")))
(assert (not (= segment2_1 "")))
(assert (not (= segment2_2 "")))

; URL completeness validation
(assert (str.contains url1 "://"))
(assert (str.contains url2 "://"))
(assert (str.contains url3 "://"))

; Protocol security validation
(assert (=> (str.contains url1 "example.com") (= protocol1 "https")))

; Advanced query validation
(assert (str.contains query_part1 "="))
(assert (str.contains query_part1 "&"))

; Path structure validation for API endpoints
(assert (=> (= segment1_1 "api") (not (= segment1_2 ""))))
(assert (=> (= segment2_1 "v1") (= segment2_2 "data")))

(check-sat)
(get-model)
