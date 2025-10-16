(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare string variables for configuration parsing
(declare-fun config_line1 () String)
(declare-fun config_line2 () String)
(declare-fun ini_section () String)
(declare-fun ini_content () String)
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun section_name () String)
(declare-fun section_content () String)
(declare-fun full_config () String)

; ; Configuration line examples
(assert (= config_line1 "database_host=localhost"))
(assert (= config_line2 "port:8080"))

; ; INI file section example
(assert (= ini_section "[database]"))
(assert (= ini_content "[database]\nhost=localhost\nport=3306\n[server]\nport=8080\ndebug:true"))

; ; Key-value pair extraction using equals delimiter
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))

; ; Key-value pair extraction using colon delimiter
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))

; Key validation constraints
(assert (> (str.len key1) 0))
(assert (> (str.len key2) 0))
(assert (not (str.contains key1 " ")))
(assert (not (str.contains key2 " ")))

; ; Value extraction validation
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; ; Section name extraction from INI section header
(assert (= section_name (str.split_at ini_section "]" 0)))
(assert (= section_name (str.split_at section_name "[" 1)))

; ; Section handling - extract content between sections
(assert (= full_config ini_content))
(assert (>= (str.num_splits full_config "\n") 5))

; ; Validate section structure
(assert (str.prefixof "[" ini_section))
(assert (str.suffixof "]" ini_section))
(assert (= (str.len section_name) 8))

; Configuration parsing constraints
(assert (or (str.contains config_line1 "=") (str.contains config_line1 ":")))
(assert (or (str.contains config_line2 "=") (str.contains config_line2 ":")))

; Split count validation for proper key-value pairs
(assert (= (str.num_splits config_line1 "=") 2))
(assert (= (str.num_splits config_line2 ":") 2))

; Multi-line configuration processing
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun line3 () String)

(assert (= line1 (str.split_at ini_content "\n" 1)))
(assert (= line2 (str.split_at ini_content "\n" 2)))
(assert (= line3 (str.split_at ini_content "\n" 3)))

; ; Validate each configuration line has proper format
(assert (or (str.contains line1 "=") (str.contains line1 ":")))
(assert (or (str.contains line2 "=") (str.contains line2 ":")))

; Section boundary detection
(declare-fun section_start () String)
(declare-fun section_end () String)

(assert (= section_start (str.split_at ini_content "\n" 0)))
(assert (= section_end (str.split_at ini_content "\n" 4)))

(assert (str.prefixof "[" section_start))
(assert (str.prefixof "[" section_end))

; Key validation rules
(assert (not (str.prefixof "=" key1)))
(assert (not (str.suffixof "=" key1)))
(assert (not (str.prefixof ":" key2)))
(assert (not (str.suffixof ":" key2)))

; ; Value extraction from different delimiter types
(declare-fun config_mixed () String)
(declare-fun mixed_key () String)
(declare-fun mixed_value () String)

(assert (= config_mixed "timeout=30"))
(assert (= mixed_key (str.split_at config_mixed "=" 0)))
(assert (= mixed_value (str.split_at config_mixed "=" 1)))

; Ensure proper parsing of numeric values
(assert (= mixed_value "30"))
(assert (= (str.len mixed_value) 2))

; ; Section content extraction
(declare-fun remaining_content () String)
(assert (= remaining_content (str.split_rest ini_content "\n" 1)))

; Complex INI structure validation
(declare-fun header_count () Int)
(assert (= header_count (str.num_splits ini_content "[")))
(assert (>= header_count 2))

; ; Validate section names are non-empty
(declare-fun section1_name () String)
(declare-fun section2_name () String)

(assert (= section1_name "database"))
(assert (= section2_name "server"))
(assert (> (str.len section1_name) 0))
(assert (> (str.len section2_name) 0))

; ; Configuration consistency checks
(assert (not (= key1 key2)))
(assert (str.contains full_config key1))
(assert (str.contains full_config value2))

; Final validation constraints
(assert (= (str.split_at "key=value" "=" 0) "key"))
(assert (= (str.split_at "key=value" "=" 1) "value"))

(check-sat)
(get-model)
