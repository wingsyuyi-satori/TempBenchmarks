(set-logic QF_SLIA)
(set-info :source |Configuration parsing with key-value pairs and INI sections|)
(set-info :category "industrial")

; Declare string variables for configuration content
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_content () String)
(declare-fun key_part () String)
(declare-fun value_part () String)
(declare-fun section_name () String)
(declare-fun full_key () String)

; Declare integer variables for split operations
(declare-const num_equals_splits Int)
(declare-const num_colon_splits Int)
(declare-const num_newline_splits Int)
(declare-const num_bracket_splits Int)
(declare-const line_count Int)

; Configuration line parsing constraints
; A valid key-value line should have exactly one equals sign
(assert (= config_line "database_host=localhost"))
(assert (= num_equals_splits (str.num_splits config_line "=")))
(assert (= num_equals_splits 2))

; ; Extract key and value parts from equals-delimited line
(assert (= key_part (str.split_at config_line "=" 0)))
(assert (= value_part (str.split_at config_line "=" 1)))

; Key validation constraints
; Keys should not be empty and should not contain whitespace
(assert (> (str.len key_part) 0))
(assert (not (str.contains key_part " ")))
(assert (not (str.contains key_part "\t")))

; ; Value extraction and validation
(assert (> (str.len value_part) 0))
(assert (not (= value_part "")))

; Alternative colon-based configuration format
(declare-fun colon_config () String)
(declare-fun colon_key () String)
(declare-fun colon_value () String)

(assert (= colon_config "port:8080"))
(assert (= num_colon_splits (str.num_splits colon_config ":")))
(assert (= num_colon_splits 2))
(assert (= colon_key (str.split_at colon_config ":" 0)))
(assert (= colon_value (str.split_at colon_config ":" 1)))

; INI file section handling
(assert (= ini_content "[database]\nhost=localhost\nport=5432\n[web]\nport=8080\ndebug=true"))

; Count sections by counting opening brackets
(declare-const section_count Int)
(assert (= section_count (str.num_splits ini_content "[")))
(assert (> section_count 1))

; ; Extract section name from bracket-delimited content
(declare-fun section_header () String)
(assert (= section_header "[database]"))
(assert (= (str.split_at section_header "[" 0) ""))
(assert (= section_name (str.split_at (str.split_at section_header "]" 0) "[" 1)))

; Multi-line content processing
(assert (= line_count (str.num_splits ini_content "\n")))
(assert (> line_count 3))

; ; Extract specific configuration lines
(declare-fun first_line () String)
(declare-fun second_line () String)
(declare-fun third_line () String)

(assert (= first_line (str.split_at ini_content "\n" 0)))
(assert (= second_line (str.split_at ini_content "\n" 1)))
(assert (= third_line (str.split_at ini_content "\n" 2)))

; ; Validate section header format
(assert (str.prefixof "[" first_line))
(assert (str.suffixof "]" first_line))

; ; Validate key-value lines within sections
(assert (str.contains second_line "="))
(assert (str.contains third_line "="))

; ; Extract keys and values from section lines
(declare-fun host_key () String)
(declare-fun host_value () String)
(declare-fun port_key () String)
(declare-fun port_value () String)

(assert (= host_key (str.split_at second_line "=" 0)))
(assert (= host_value (str.split_at second_line "=" 1)))
(assert (= port_key (str.split_at third_line "=" 0)))
(assert (= port_value (str.split_at third_line "=" 1)))

; Key uniqueness within section
(assert (not (= host_key port_key)))

; Complex section processing with nested structure
(declare-fun complex_ini () String)
(declare-const web_section_start Int)
(declare-fun remaining_content () String)

(assert (= complex_ini "[app]\nname=myapp\n[database]\nhost=db.example.com\nport=5432\n[web]\nport=8080"))

; Find web section position
(assert (= remaining_content (str.split_rest complex_ini "\n" 4)))
(assert (str.prefixof "[web]" remaining_content))

; ; Validate configuration completeness
(declare-const required_keys_found Bool)
(assert (= required_keys_found 
 (and (str.contains complex_ini "name=")
 (str.contains complex_ini "host=")
 (str.contains complex_ini "port="))))
(assert required_keys_found)

; Error case: malformed section header
(declare-fun malformed_section () String)
(declare-const bracket_balance Int)

(assert (= malformed_section "[incomplete"))
(assert (= bracket_balance (- (str.num_splits malformed_section "[") (str.num_splits malformed_section "]"))))
(assert (> bracket_balance 0))

; Configuration validation rules
(declare-const valid_config Bool)
(assert (= valid_config 
 (and (> (str.len key_part) 0)
 (> (str.len value_part) 0)
 (not (str.contains key_part "="))
 (not (str.contains key_part "\n")))))
(assert valid_config)

; Nested configuration structure
(declare-fun nested_key () String)
(declare-fun section_qualified_key () String)

(assert (= nested_key "database.host"))
(assert (= section_qualified_key (str.++ section_name "." host_key)))
(assert (str.contains nested_key "."))

; Value type validation for numeric ports
(declare-const port_is_numeric Bool)
(assert (= port_is_numeric (and (not (str.contains port_value "a"))
 (not (str.contains port_value "b"))
 (not (str.contains port_value "c")))))

; Configuration merging constraints
(declare-fun merged_config () String)
(declare-fun base_config () String)
(declare-fun override_config () String)

(assert (= base_config "timeout=30"))
(assert (= override_config "timeout=60"))
(assert (not (= (str.split_at base_config "=" 1) (str.split_at override_config "=" 1))))

(check-sat)
(exit)
(get-model)
