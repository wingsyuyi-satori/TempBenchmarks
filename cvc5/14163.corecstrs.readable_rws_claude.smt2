(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Variable declarations for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun full_section () String)
(declare-fun config_block () String)
(declare-fun parsed_entry () String)
(declare-fun expected_key () String)
(declare-fun expected_value () String)
(declare-fun target_section () String)
(declare-fun empty_value_line () String)
(declare-fun invalid_line () String)
(declare-fun nested_section () String)

; Key-value pair parsing with equals delimiter
; Format: "database_host=localhost"
(assert (= config_line "database_host=localhost"))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= (str.num_splits config_line "=") 2))

; Key validation - ensure key contains only valid characters
(assert (str.prefixof "database" extracted_key))
(assert (> (str.len extracted_key) 0))
(assert (< (str.len extracted_key) 50))

; ; Value extraction validation
(assert (= extracted_value "localhost"))
(assert (not (str.contains extracted_value "=")))

; Alternative key-value parsing with colon delimiter
; Format: "port: 5432"
(assert (= key_value_pair "port: 5432"))
(assert (= (str.split_at key_value_pair ":" 0) "port"))
(assert (str.prefixof " " (str.split_at key_value_pair ":" 1)))

; Section header parsing
; Format: "[database]"
(assert (= section_header "[database]"))
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n[database]\nname=mydb\nuser=admin"))

; ; Extract first section using newline delimiter
(assert (= (str.split_at ini_content "\n" 0) "[server]"))
(assert (= (str.split_at ini_content "\n" 1) "host=example.com"))
(assert (= (str.split_at ini_content "\n" 2) "port=8080"))

; ; Validate section count
(assert (= (str.num_splits ini_content "\n") 6))

; ; Section handling - extract complete section block
(assert (= full_section (str.split_rest ini_content "\n" 3)))
(assert (str.contains full_section "[database]"))
(assert (str.contains full_section "name=mydb"))

; Complex configuration block parsing
(assert (= config_block "[settings]\ntimeout=30\ndebug=true\n[logging]\nlevel=info"))

; ; Validate settings section extraction
(assert (= (str.split_at config_block "\n" 0) "[settings]"))
(assert (= (str.split_at (str.split_at config_block "\n" 1) "=" 0) "timeout"))
(assert (= (str.split_at (str.split_at config_block "\n" 1) "=" 1) "30"))

; Key validation constraints
(assert (= expected_key "timeout"))
(assert (= (str.split_at (str.split_at config_block "\n" 1) "=" 0) expected_key))

; Value type validation for numeric values
(assert (= expected_value "30"))

; Boolean value validation
(assert (= (str.split_at (str.split_at config_block "\n" 2) "=" 1) "true"))
(assert (or 
 (= (str.split_at (str.split_at config_block "\n" 2) "=" 1) "true")
 (= (str.split_at (str.split_at config_block "\n" 2) "=" 1) "false")))

; Section boundary detection
(assert (= target_section "logging"))
(assert (str.contains config_block (str.++ "[" target_section "]")))

; ; Extract logging section content
(assert (= parsed_entry (str.split_at config_block "\n" 4)))
(assert (= (str.split_at parsed_entry "=" 0) "level"))
(assert (= (str.split_at parsed_entry "=" 1) "info"))

; ; Validate section structure integrity
(assert (> (str.num_splits config_block "[") 1))
(assert (= (str.num_splits config_block "[") (str.num_splits config_block "]")))

; Cross-section validation
(assert (not (str.contains (str.split_at config_block "\n" 1) "[")))
(assert (not (str.contains (str.split_at config_block "\n" 2) "[")))

; Key uniqueness within section validation
(assert (not (= (str.split_at (str.split_at config_block "\n" 1) "=" 0)
 (str.split_at (str.split_at config_block "\n" 2) "=" 0))))

; Empty value handling
(assert (= empty_value_line "empty_key="))
(assert (= (str.split_at empty_value_line "=" 0) "empty_key"))
(assert (= (str.split_at empty_value_line "=" 1) ""))
(assert (= (str.len (str.split_at empty_value_line "=" 1)) 0))

; Invalid configuration detection
(assert (= invalid_line "invalid_line_without_delimiter"))
(assert (= (str.num_splits invalid_line "=") 1))
(assert (= (str.num_splits invalid_line ":") 1))

; Nested section validation should fail
(assert (= nested_section "[outer[inner]]"))
(assert (> (str.num_splits nested_section "[") 2))

(check-sat)
(exit)
(get-model)
