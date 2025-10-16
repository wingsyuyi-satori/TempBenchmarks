(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Variable declarations for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_line () String)
(declare-fun key_part () String)
(declare-fun value_part () String)
(declare-fun section_name () String)
(declare-fun multi_line_config () String)
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun line3 () String)
(declare-fun key1 () String)
(declare-fun key2 () String)
(declare-fun key3 () String)
(declare-fun val1 () String)
(declare-fun val2 () String)
(declare-fun val3 () String)
(declare-fun colon_config () String)
(declare-fun colon_key () String)
(declare-fun colon_value () String)
(declare-fun full_ini_section () String)
(declare-fun server_header () String)
(declare-fun client_header () String)
(declare-fun server_host_line () String)
(declare-fun server_port_line () String)
(declare-fun client_retries_line () String)
(declare-fun server_host_key () String)
(declare-fun server_host_val () String)
(declare-fun server_port_key () String)
(declare-fun server_port_val () String)
(declare-fun malformed_line () String)

; Basic key-value pair parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.num_splits config_line "=") 2))
(assert (= key_part (str.split_at config_line "=" 0)))
(assert (= value_part (str.split_at config_line "=" 1)))

; Key validation constraints
(assert (> (str.len key_part) 0))
(assert (not (str.contains key_part " ")))
(assert (str.prefixof "database" key_part))
(assert (= key_part "database_host"))

; ; Value extraction validation
(assert (= value_part "localhost"))

; INI file section handling with brackets
(assert (= section_line "[database]"))
(assert (= (str.num_splits section_line "[") 2))
(assert (= (str.num_splits section_line "]") 2))

; ; Extract section name between brackets
(assert (= section_name (str.split_at (str.split_at section_line "[" 1) "]" 0)))
(assert (= section_name "database"))

; Multi-line configuration processing
(assert (= multi_line_config "host=localhost\nport=5432\nuser=admin"))
(assert (= (str.num_splits multi_line_config "\n") 3))

; ; Extract individual configuration lines
(assert (= line1 (str.split_at multi_line_config "\n" 0)))
(assert (= line2 (str.split_at multi_line_config "\n" 1)))
(assert (= line3 (str.split_at multi_line_config "\n" 2)))

; ; Validate each line has proper key-value structure
(assert (= (str.num_splits line1 "=") 2))
(assert (= (str.num_splits line2 "=") 2))
(assert (= (str.num_splits line3 "=") 2))

; ; Extract keys and values from each line
(assert (= key1 (str.split_at line1 "=" 0)))
(assert (= val1 (str.split_at line1 "=" 1)))
(assert (= key2 (str.split_at line2 "=" 0)))
(assert (= val2 (str.split_at line2 "=" 1)))
(assert (= key3 (str.split_at line3 "=" 0)))
(assert (= val3 (str.split_at line3 "=" 1)))

; ; Key validation for all extracted keys
(assert (> (str.len key1) 0))
(assert (> (str.len key2) 0))
(assert (> (str.len key3) 0))
(assert (= key1 "host"))
(assert (= key2 "port"))
(assert (= key3 "user"))

; Value validation
(assert (= val1 "localhost"))
(assert (= val2 "5432"))
(assert (= val3 "admin"))

; Alternative delimiter handling with colon
(assert (= colon_config "timeout:30"))
(assert (= (str.num_splits colon_config ":") 2))
(assert (= colon_key (str.split_at colon_config ":" 0)))
(assert (= colon_value (str.split_at colon_config ":" 1)))
(assert (= colon_key "timeout"))
(assert (= colon_value "30"))

; Complex INI section with multiple key-value pairs
(assert (= full_ini_section "[server]\nhost=example.com\nport=8080\n[client]\nretries=3"))
(assert (= (str.num_splits full_ini_section "\n") 5))

; ; Extract section headers
(assert (= server_header (str.split_at full_ini_section "\n" 0)))
(assert (= client_header (str.split_at full_ini_section "\n" 3)))

; ; Validate section header format
(assert (str.prefixof "[" server_header))
(assert (str.suffixof "]" server_header))
(assert (str.prefixof "[" client_header))
(assert (str.suffixof "]" client_header))

; ; Extract configuration lines from sections
(assert (= server_host_line (str.split_at full_ini_section "\n" 1)))
(assert (= server_port_line (str.split_at full_ini_section "\n" 2)))
(assert (= client_retries_line (str.split_at full_ini_section "\n" 4)))

; Parse server section key-value pairs
(assert (= server_host_key (str.split_at server_host_line "=" 0)))
(assert (= server_host_val (str.split_at server_host_line "=" 1)))
(assert (= server_port_key (str.split_at server_port_line "=" 0)))
(assert (= server_port_val (str.split_at server_port_line "=" 1)))

; ; Validate extracted server configuration
(assert (= server_host_key "host"))
(assert (= server_host_val "example.com"))
(assert (= server_port_key "port"))
(assert (= server_port_val "8080"))

; Malformed configuration detection
(assert (= malformed_line "invalid_config_no_delimiter"))
(assert (= (str.num_splits malformed_line "=") 1))
(assert (= (str.num_splits malformed_line ":") 1))

; Use str.split_rest to get remaining configuration after first key-value pair
(assert (= (str.split_rest multi_line_config "\n" 1) "port=5432\nuser=admin"))

; ; Validate that section names don't contain invalid characters
(assert (not (str.contains section_name "=")))
(assert (not (str.contains section_name ":")))
(assert (not (str.contains section_name "\n")))

; Ensure keys don't start with brackets
(assert (not (str.prefixof "[" key1)))
(assert (not (str.prefixof "[" key2)))
(assert (not (str.prefixof "[" key3)))

(check-sat)
(exit)
(get-model)
