(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun full_config () String)

; Configuration line processing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.split_at config_line "=" 0) "database_host"))
(assert (= (str.split_at config_line "=" 1) "localhost"))
(assert (= (str.num_splits config_line "=") 2))

; Key validation constraints - keys must be non-empty and alphanumeric-like
(assert (> (str.len (str.split_at config_line "=" 0)) 0))
(assert (not (= (str.split_at config_line "=" 0) "")))

; Alternative colon delimiter for key-value pairs
(declare-fun alt_config () String)
(assert (= alt_config "port:8080"))
(assert (= (str.split_at alt_config ":" 0) "port"))
(assert (= (str.split_at alt_config ":" 1) "8080"))

; ; Value extraction from configuration
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= extracted_value "localhost"))

; INI file section handling with square brackets
(assert (= section_header "[database]"))
(assert (= (str.split_at section_header "[" 1) "database]"))
(assert (= (str.split_at (str.split_at section_header "[" 1) "]" 0) "database"))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=443\n[database]\nname=mydb"))

; ; Extract first section from multi-line content
(assert (= (str.split_at ini_content "\n" 0) "[server]"))
(assert (= (str.split_at ini_content "\n" 1) "host=example.com"))
(assert (= (str.split_at ini_content "\n" 2) "port=443"))

; ; Validate section structure
(assert (str.prefixof "[" (str.split_at ini_content "\n" 0)))
(assert (str.suffixof "]" (str.split_at ini_content "\n" 0)))

; ; Key-value pair extraction from INI lines
(declare-fun host_line () String)
(assert (= host_line (str.split_at ini_content "\n" 1)))
(assert (= (str.split_at host_line "=" 0) "host"))
(assert (= (str.split_at host_line "=" 1) "example.com"))

; Port configuration validation
(declare-fun port_line () String)
(assert (= port_line (str.split_at ini_content "\n" 2)))
(assert (= (str.split_at port_line "=" 0) "port"))
(assert (= (str.split_at port_line "=" 1) "443"))

; Section boundary detection
(assert (= (str.num_splits ini_content "\n") 5))
(assert (= (str.split_at ini_content "\n" 3) "[database]"))
(assert (= (str.split_at ini_content "\n" 4) "name=mydb"))

; Complex configuration with nested structure
(declare-fun complex_config () String)
(assert (= complex_config "[app]\nname=MyApp\nversion=1.0\n[logging]\nlevel=INFO"))

; ; Extract application section
(assert (= (str.split_at complex_config "\n" 0) "[app]"))
(assert (= (str.split_at (str.split_at complex_config "\n" 0) "[" 1) "app]"))

; ; Validate configuration format constraints
(declare-fun malformed_line () String)
(assert (= malformed_line "invalid_config_no_delimiter"))
(assert (= (str.num_splits malformed_line "=") 1))
(assert (= (str.split_at malformed_line "=" 0) "invalid_config_no_delimiter"))

; ; Section name extraction helper
(declare-fun extract_section_name (String) String)
(assert (forall ((s String)) 
 (=> (and (str.prefixof "[" s) (str.suffixof "]" s))
 (= (extract_section_name s) 
 (str.split_at (str.split_at s "[" 1) "]" 0)))))

; Key validation - must not contain special characters
(declare-fun valid_key () String)
(assert (= valid_key "database_connection_timeout"))
(assert (not (str.contains valid_key "=")))
(assert (not (str.contains valid_key ":")))
(assert (not (str.contains valid_key "[")))
(assert (not (str.contains valid_key "]")))

; ; Value extraction with whitespace handling
(declare-fun config_with_spaces () String)
(assert (= config_with_spaces "timeout = 30"))
(assert (= (str.num_splits config_with_spaces "=") 2))

; Rest of configuration after first section
(declare-fun remaining_config () String)
(assert (= remaining_config (str.split_rest ini_content "\n" 3)))
(assert (str.prefixof "[database]" remaining_config))

; Multiple delimiter validation
(declare-fun multi_delim_line () String)
(assert (= multi_delim_line "key=value:extra"))
(assert (= (str.num_splits multi_delim_line "=") 2))
(assert (= (str.num_splits (str.split_at multi_delim_line "=" 1) ":") 2))

; Configuration integrity constraints
(assert (> (str.len extracted_key) 0))
(assert (> (str.len extracted_value) 0))
(assert (> (str.len section_name) 0))

; Ensure proper section formatting
(assert (and (str.prefixof "[" section_header) 
 (str.suffixof "]" section_header)))

(check-sat)
(exit)
(get-model)
