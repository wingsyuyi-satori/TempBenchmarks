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
(declare-fun config_block () String)

; Constants for delimiters and validation
(declare-fun valid_key_chars () String)
(declare-fun invalid_chars () String)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.num_splits config_line "=") 2))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))

; Key validation - ensure key contains only valid characters
(assert (= extracted_key "database_host"))
(assert (str.contains valid_key_chars "abcdefghijklmnopqrstuvwxyz_"))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "=")))

; ; Value extraction validation
(assert (= extracted_value "localhost"))
(assert (> (str.len extracted_value) 0))

; Alternative configuration with colon delimiter
(declare-fun alt_config () String)
(declare-fun alt_key () String)
(declare-fun alt_value () String)
(assert (= alt_config "port: 5432"))
(assert (= (str.num_splits alt_config ":") 2))
(assert (= alt_key (str.split_at alt_config ":" 0)))
(assert (= alt_value (str.split_at alt_config ":" 1)))

; Trim whitespace from colon-separated value
(assert (= alt_key "port"))
(assert (str.prefixof " " alt_value))
(assert (= (str.substr alt_value 1 (- (str.len alt_value) 1)) "5432"))

; INI file section handling
(assert (= section_header "[database]"))
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))
(assert (= (str.num_splits section_header "[") 2))
(assert (= (str.num_splits section_header "]") 2))

; ; Extract section name from header
(declare-fun temp_split () String)
(assert (= temp_split (str.split_at section_header "[" 1)))
(assert (= section_name (str.split_at temp_split "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=80\n[database]\nhost=db.example.com\nport=5432"))

; Count total lines in INI file
(declare-fun line_count () Int)
(assert (= line_count (str.num_splits ini_content "\n")))
(assert (= line_count 6))

; ; Extract first line (server section)
(declare-fun first_line () String)
(assert (= first_line (str.split_at ini_content "\n" 0)))
(assert (= first_line "[server]"))

; ; Extract second line (server host config)
(declare-fun second_line () String)
(assert (= second_line (str.split_at ini_content "\n" 1)))
(assert (= second_line "host=example.com"))

; ; Validate second line is a key-value pair
(assert (str.contains second_line "="))
(assert (= (str.num_splits second_line "=") 2))

; ; Extract key and value from second line
(declare-fun server_key () String)
(declare-fun server_value () String)
(assert (= server_key (str.split_at second_line "=" 0)))
(assert (= server_value (str.split_at second_line "=" 1)))
(assert (= server_key "host"))
(assert (= server_value "example.com"))

; Process remaining content after first section
(declare-fun remaining_content () String)
(assert (= remaining_content (str.split_rest ini_content "\n" 1)))
(assert (str.contains remaining_content "[database]"))

; Section boundary detection
(declare-fun has_server_section () Bool)
(declare-fun has_database_section () Bool)
(assert (= has_server_section (str.contains ini_content "[server]")))
(assert (= has_database_section (str.contains ini_content "[database]")))
(assert has_server_section)
(assert has_database_section)

; Key validation rules
(declare-fun test_key () String)
(assert (= test_key "valid_key_123"))
(assert (not (str.contains test_key "=")))
(assert (not (str.contains test_key ":")))
(assert (not (str.contains test_key "[")))
(assert (not (str.contains test_key "]")))
(assert (not (str.contains test_key "\n")))

; Invalid key detection
(declare-fun invalid_key () String)
(assert (= invalid_key "invalid=key"))
(assert (str.contains invalid_key "="))

; Complex configuration block processing
(assert (= config_block "timeout=30\nretries=3\nssl_enabled=true"))
(declare-fun block_lines () Int)
(assert (= block_lines (str.num_splits config_block "\n")))
(assert (= block_lines 3))

; ; Extract each configuration line from block
(declare-fun timeout_line () String)
(declare-fun retries_line () String)
(declare-fun ssl_line () String)
(assert (= timeout_line (str.split_at config_block "\n" 0)))
(assert (= retries_line (str.split_at config_block "\n" 1)))
(assert (= ssl_line (str.split_at config_block "\n" 2)))

; ; Validate each line has exactly one equals sign
(assert (= (str.num_splits timeout_line "=") 2))
(assert (= (str.num_splits retries_line "=") 2))
(assert (= (str.num_splits ssl_line "=") 2))

; ; Extract values from configuration block
(declare-fun timeout_value () String)
(declare-fun retries_value () String)
(declare-fun ssl_value () String)
(assert (= timeout_value (str.split_at timeout_line "=" 1)))
(assert (= retries_value (str.split_at retries_line "=" 1)))
(assert (= ssl_value (str.split_at ssl_line "=" 1)))

; ; Validate extracted values
(assert (= timeout_value "30"))
(assert (= retries_value "3"))
(assert (= ssl_value "true"))

; Ensure values are non-empty
(assert (> (str.len timeout_value) 0))
(assert (> (str.len retries_value) 0))
(assert (> (str.len ssl_value) 0))

; Section nesting validation - sections cannot contain brackets
(declare-fun nested_section () String)
(assert (= nested_section "outer_section"))
(assert (not (str.contains nested_section "[")))
(assert (not (str.contains nested_section "]")))

(check-sat)
(exit)
(get-model)
