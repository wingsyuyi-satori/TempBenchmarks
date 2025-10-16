(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :status unknown)

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun config_block () String)

; Configuration parsing constraints using split operations

; Key-value pair validation with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.num_splits config_line "=") 2))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= extracted_key "database_host"))
(assert (= extracted_value "localhost"))

; Alternative colon delimiter for key-value pairs
(declare-fun alt_config_line () String)
(declare-fun alt_key () String)
(declare-fun alt_value () String)
(assert (= alt_config_line "port:8080"))
(assert (= (str.num_splits alt_config_line ":") 2))
(assert (= alt_key (str.split_at alt_config_line ":" 0)))
(assert (= alt_value (str.split_at alt_config_line ":" 1)))
(assert (= alt_key "port"))
(assert (= alt_value "8080"))

; INI file section header parsing
(assert (= section_header "[database]"))
(assert (= (str.num_splits section_header "[") 2))
(assert (= (str.num_splits section_header "]") 2))
(declare-fun temp_section () String)
(assert (= temp_section (str.split_at section_header "[" 1)))
(assert (= section_name (str.split_at temp_section "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=80\n[database]\nname=mydb\nuser=admin"))
(assert (>= (str.num_splits ini_content "\n") 6))

; ; Extract first section content
(declare-fun first_section () String)
(declare-fun server_config () String)
(assert (= first_section (str.split_at ini_content "\n" 0)))
(assert (= first_section "[server]"))
(assert (= server_config (str.split_at ini_content "\n" 1)))
(assert (= server_config "host=example.com"))

; Key validation constraints
(declare-fun valid_key () String)
(declare-fun invalid_key () String)
(assert (= valid_key "valid_config_key"))
(assert (= invalid_key "123invalid"))
(assert (str.prefixof "valid" valid_key))
(assert (not (str.prefixof "123" valid_key)))

; ; Value extraction from complex configuration
(declare-fun complex_config () String)
(declare-fun db_section () String)
(declare-fun db_name_line () String)
(declare-fun db_name () String)
(assert (= complex_config "[database]\nname=production_db\nhost=db.example.com"))
(assert (= (str.num_splits complex_config "[") 2))
(assert (= db_section (str.split_rest complex_config "[" 1)))
(assert (str.contains db_section "name=production_db"))

; Section handling with multiple sections
(declare-fun multi_section_config () String)
(declare-fun section_count () Int)
(assert (= multi_section_config "[web]\nport=8080\n[api]\nversion=v2\n[cache]\nttl=3600"))
(assert (= section_count (- (str.num_splits multi_section_config "[") 1)))
(assert (= section_count 3))

; Configuration validation constraints
(declare-fun config_entry () String)
(declare-fun entry_key () String)
(declare-fun entry_value () String)
(assert (= config_entry "timeout=30"))
(assert (= entry_key (str.split_at config_entry "=" 0)))
(assert (= entry_value (str.split_at config_entry "=" 1)))
(assert (not (= entry_key "")))
(assert (not (= entry_value "")))
(assert (= entry_key "timeout"))
(assert (= entry_value "30"))

; Error case: malformed configuration
(declare-fun malformed_config () String)
(assert (= malformed_config "invalid_entry_no_delimiter"))
(assert (= (str.num_splits malformed_config "=") 1))
(assert (= (str.num_splits malformed_config ":") 1))

; Section bracket matching validation
(declare-fun bracket_test () String)
(declare-fun open_brackets () Int)
(declare-fun close_brackets () Int)
(assert (= bracket_test "[section1][section2]"))
(assert (= open_brackets (- (str.num_splits bracket_test "[") 1)))
(assert (= close_brackets (- (str.num_splits bracket_test "]") 1)))
(assert (= open_brackets close_brackets))
(assert (= open_brackets 2))

; ; Key extraction from section content
(declare-fun section_content () String)
(declare-fun first_key_line () String)
(declare-fun second_key_line () String)
(declare-fun first_key () String)
(declare-fun second_key () String)
(assert (= section_content "username=admin\npassword=secret\ntimeout=60"))
(assert (= first_key_line (str.split_at section_content "\n" 0)))
(assert (= second_key_line (str.split_at section_content "\n" 1)))
(assert (= first_key (str.split_at first_key_line "=" 0)))
(assert (= second_key (str.split_at second_key_line "=" 0)))
(assert (= first_key "username"))
(assert (= second_key "password"))

; Configuration block processing
(assert (= config_block "[settings]\ndebug=true\nlog_level=info\n[features]\napi_enabled=false"))
(declare-fun settings_section () String)
(declare-fun features_section () String)
(assert (str.contains config_block "[settings]"))
(assert (str.contains config_block "[features]"))

; Ensure proper section separation
(declare-fun section_parts () Int)
(assert (= section_parts (- (str.num_splits config_block "[") 1)))
(assert (>= section_parts 2))

(check-sat)
(exit)
(get-model)
