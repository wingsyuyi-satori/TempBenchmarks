; SMT-LIB2 file for URL parsing using split operations
; Focus: protocol validation, host structure, path segments
; Delimiters used: "://", "/", ":", "?", "&"

(set-logic ALL)

; ; Declare string variables for input and extracted components
(declare-fun url () String)
(declare-fun proto () String)
(declare-fun hostportpath () String)
(declare-fun hostport () String)
(declare-fun pathquery () String)
(declare-fun host () String)
(declare-fun port () String)
(declare-fun path () String)
(declare-fun query () String)

; Split URL at "://"
(assert (= proto (str.split_at url "://" 0)))
(assert (= hostportpath (str.split_rest url "://" 1)))

; Protocol validation: protocol must be "http" or "https"
(assert (or (= proto "http") (= proto "https")))

; Host structure: hostportpath is split at first "/"
(assert (= hostport (str.split_at hostportpath "/" 0)))
(assert (= pathquery (str.split_rest hostportpath "/" 1)))

; Host: may include port, split at ":"
(assert (= host (str.split_at hostport ":" 0)))
(assert (= port (str.split_at hostport ":" 1)))

; Path and query: pathquery may contain "?"
(assert (= path (str.split_at pathquery "?" 0)))
(assert (= query (str.split_at pathquery "?" 1)))

; Path segments: ensure that the path has at least 2 segments (e.g., "/foo/bar")
(assert (>= (str.num_splits path "/") 3)) ; at least two slashes, so three segments

; ; Example: Satisfiable scenario
; ; Example URL: "https://example.com:8080/foo/bar?x=1&y=2"
(assert (= url "https://example.com:8080/foo/bar?x=1&y=2"))

; Relationship: The host must contain at least one dot
(assert (str.contains host "."))

; Relationship: Port must be "8080"
(assert (= port "8080"))

; Relationship: The first path segment after the initial "/" must be "foo"
(assert (= (str.split_at path "/" 1) "foo"))

; Path segment relationship: Second path segment after "/" must be "bar"
(assert (= (str.split_at path "/" 2) "bar"))

; Query split: The first query parameter must be "x=1"
(assert (= (str.split_at query "&" 0) "x=1"))

; --- Unsatisfiable scenario ---
; The protocol cannot be "ftp"
(assert (not (= proto "ftp")))

; The host cannot be "localhost"
(assert (not (= host "localhost")))

; The port cannot be "80" (conflicts with earlier constraint that port="8080")
(assert (not (= port "80")))

; Path must not start with "/admin" (conflicts if path="/admin/...")
(assert (not (str.prefixof "/admin" path)))

(check-sat)
(get-model)
