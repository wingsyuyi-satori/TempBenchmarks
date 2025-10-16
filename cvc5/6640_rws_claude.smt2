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

; Configuration line parsing constraints
; Parse a key-value pair with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= (str.num_splits config_line "=") 2))

; Key validation - ensure key is non-empty and valid
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (str.prefixof "database" extracted_key))

; ; Value extraction validation
(assert (= extracted_value "localhost"))
(assert (> (str.len extracted_value) 0))

; INI file section handling
(assert (= section_header "[database]"))
(assert (= (str.split_at section_header "[" 1) "database]"))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))
(assert (= section_name "database"))

; Multi-line INI configuration
(assert (= full_config "[server]\nport=8080\nhost=0.0.0.0\n[database]\nurl=postgresql://localhost\nuser=admin"))

; ; Extract sections by splitting on newlines
(assert (= (str.num_splits full_config "\n") 6))
(assert (= (str.split_at full_config "\n" 0) "[server]"))
(assert (= (str.split_at full_config "\n" 1) "port=8080"))
(assert (= (str.split_at full_config "\n" 3) "[database]"))

; Colon delimiter parsing for alternative syntax
(declare-fun alt_config () String)
(declare-fun alt_key () String)
(declare-fun alt_value () String)

(assert (= alt_config "timeout: 30"))
(assert (= alt_key (str.split_at alt_config ":" 0)))
(assert (= alt_value (str.split_at alt_config ":" 1)))
(assert (= (str.num_splits alt_config ":") 2))

; ; Validate alternative format
(assert (= alt_key "timeout"))
(assert (str.prefixof " " alt_value))
(assert (= (str.replace alt_value " " "") "30"))

; Section boundary detection
(declare-fun section_content () String)
(assert (= section_content "port=8080\nhost=0.0.0.0\n[database]"))
(assert (= (str.split_at section_content "[" 0) "port=8080\nhost=0.0.0.0\n"))
(assert (str.contains (str.split_at section_content "[" 1) "database"))

; Complex configuration with nested sections
(declare-fun nested_config () String)
(declare-fun first_section () String)
(declare-fun second_section () String)

(assert (= nested_config "[web]\nport=80\n[web.ssl]\nenabled=true\ncert=/path/to/cert"))
(assert (> (str.num_splits nested_config "[") 2))

; ; Extract content between section markers
(assert (= first_section (str.split_at nested_config "[" 1)))
(assert (str.contains first_section "web]"))

; Key validation across multiple formats
(declare-fun mixed_format () String)
(assert (= mixed_format "debug=true\nlog_level: info\nmax_connections=100"))

; ; Validate that equals and colon delimited entries exist
(assert (str.contains mixed_format "="))
(assert (str.contains mixed_format ":"))
(assert (= (str.num_splits mixed_format "\n") 3))

; ; Extract and validate specific configuration values
(declare-fun debug_line () String)
(declare-fun log_line () String)
(declare-fun conn_line () String)

(assert (= debug_line (str.split_at mixed_format "\n" 0)))
(assert (= log_line (str.split_at mixed_format "\n" 1)))
(assert (= conn_line (str.split_at mixed_format "\n" 2)))

; ; Validate debug setting
(assert (= (str.split_at debug_line "=" 0) "debug"))
(assert (= (str.split_at debug_line "=" 1) "true"))

; ; Validate log level setting with colon
(assert (= (str.split_at log_line ":" 0) "log_level"))
(assert (str.contains (str.split_at log_line ":" 1) "info"))

; ; Validate connection setting
(assert (= (str.split_at conn_line "=" 0) "max_connections"))
(assert (= (str.split_at conn_line "=" 1) "100"))

; ; Section name extraction and validation
(declare-fun server_section () String)
(assert (= server_section "[server_config]"))
(assert (str.prefixof "[" server_section))
(assert (str.suffixof "]" server_section))

; ; Extract clean section name
(declare-fun clean_section_name () String)
(assert (= clean_section_name (str.split_at (str.split_at server_section "[" 1) "]" 0)))
(assert (= clean_section_name "server_config"))
(assert (not (str.contains clean_section_name "[")))
(assert (not (str.contains clean_section_name "]")))

; Configuration validation constraints
(assert (> (str.len clean_section_name) 0))
(assert (not (str.prefixof " " clean_section_name)))
(assert (not (str.suffixof " " clean_section_name)))

(check-sat)
(get-model)
