(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)

; Basic key-value pair parsing with equals delimiter
(assert (= key_value_pair "database_host=localhost"))
(assert (= extracted_key (str.split_at key_value_pair "=" 0)))
(assert (= extracted_value (str.split_at key_value_pair "=" 1)))
(assert (= (str.num_splits key_value_pair "=") 2))

; Key validation - ensure key is non-empty
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))

; Alternative colon delimiter for key-value pairs
(declare-fun alt_config_line () String)
(declare-fun alt_key () String)
(declare-fun alt_value () String)
(assert (= alt_config_line "port:8080"))
(assert (= alt_key (str.split_at alt_config_line ":" 0)))
(assert (= alt_value (str.split_at alt_config_line ":" 1)))
(assert (= (str.num_splits alt_config_line ":") 2))

; Section header parsing with square brackets
(assert (= section_header "[database]"))
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))
(assert (> (str.len section_name) 0))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=localhost\nport=8080\n[database]\nname=mydb"))

; ; Extract sections by splitting on newlines
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun line3 () String)
(declare-fun line4 () String)
(declare-fun line5 () String)

(assert (= line1 (str.split_at ini_content "\n" 0)))
(assert (= line2 (str.split_at ini_content "\n" 1)))
(assert (= line3 (str.split_at ini_content "\n" 2)))
(assert (= line4 (str.split_at ini_content "\n" 3)))
(assert (= line5 (str.split_at ini_content "\n" 4)))

; ; Validate section headers
(assert (str.prefixof "[" line1))
(assert (str.suffixof "]" line1))
(assert (str.prefixof "[" line4))
(assert (str.suffixof "]" line4))

; ; Extract section names
(declare-fun server_section () String)
(declare-fun db_section () String)
(assert (= server_section (str.split_at (str.split_at line1 "[" 1) "]" 0)))
(assert (= db_section (str.split_at (str.split_at line4 "[" 1) "]" 0)))

; ; Validate key-value pairs in server section
(declare-fun server_host_key () String)
(declare-fun server_host_value () String)
(declare-fun server_port_key () String)
(declare-fun server_port_value () String)

(assert (= server_host_key (str.split_at line2 "=" 0)))
(assert (= server_host_value (str.split_at line2 "=" 1)))
(assert (= server_port_key (str.split_at line3 "=" 0)))
(assert (= server_port_value (str.split_at line3 "=" 1)))

; Key validation for server section
(assert (= server_host_key "host"))
(assert (= server_port_key "port"))
(assert (> (str.len server_host_value) 0))
(assert (> (str.len server_port_value) 0))

; ; Validate key-value pairs in database section
(declare-fun db_name_key () String)
(declare-fun db_name_value () String)

(assert (= db_name_key (str.split_at line5 "=" 0)))
(assert (= db_name_value (str.split_at line5 "=" 1)))

; Key validation for database section
(assert (= db_name_key "name"))
(assert (> (str.len db_name_value) 0))

; ; Value extraction with whitespace handling
(declare-fun config_with_spaces () String)
(declare-fun trimmed_key () String)
(declare-fun trimmed_value () String)
(assert (= config_with_spaces "timeout = 30"))
(assert (= trimmed_key (str.split_at config_with_spaces "=" 0)))
(assert (= trimmed_value (str.split_at config_with_spaces "=" 1)))

; Ensure proper trimming would be needed
(assert (str.contains trimmed_key " "))
(assert (str.contains trimmed_value " "))

; Invalid configuration detection
(declare-fun invalid_config () String)
(declare-fun invalid_parts () Int)
(assert (= invalid_config "malformed_line_without_delimiter"))
(assert (= invalid_parts (str.num_splits invalid_config "=")))
(assert (= invalid_parts 1))

; Multiple equals signs handling
(declare-fun multi_equals () String)
(declare-fun equals_count () Int)
(assert (= multi_equals "url=http://example.com:8080/path=value"))
(assert (= equals_count (str.num_splits multi_equals "=")))
(assert (> equals_count 2))

; ; Extract first key and remaining value with equals
(declare-fun url_key () String)
(declare-fun url_value_with_equals () String)
(assert (= url_key (str.split_at multi_equals "=" 0)))
(assert (= url_value_with_equals (str.split_rest multi_equals "=" 1)))
(assert (str.contains url_value_with_equals "="))

; Section boundary validation
(declare-fun section_boundary () String)
(declare-fun bracket_open_count () Int)
(declare-fun bracket_close_count () Int)
(assert (= section_boundary "[app][config][test]"))
(assert (= bracket_open_count (str.num_splits section_boundary "[")))
(assert (= bracket_close_count (str.num_splits section_boundary "]")))
(assert (= bracket_open_count bracket_close_count))

; Complex nested section handling
(declare-fun nested_config () String)
(declare-fun first_section () String)
(declare-fun remaining_sections () String)
(assert (= nested_config "[web]\nport=80\n[db]\nhost=local"))
(assert (= first_section (str.split_at nested_config "\n[" 0)))
(assert (= remaining_sections (str.split_rest nested_config "\n[" 1)))
(assert (str.contains first_section "[web]"))
(assert (str.contains remaining_sections "db]"))

(check-sat)
(get-model)
