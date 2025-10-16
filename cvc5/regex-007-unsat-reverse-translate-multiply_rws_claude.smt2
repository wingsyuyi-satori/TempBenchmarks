(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare string variables for configuration content
(declare-fun config_line1 () String)
(declare-fun config_line2 () String)
(declare-fun config_line3 () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)

; ; Declare variables for extracted components
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun section_name () String)

; Configuration line 1: database_host=localhost:3306
(assert (= config_line1 "database_host=localhost:3306"))

; Configuration line 2: timeout:30
(assert (= config_line2 "timeout:30"))

; Configuration line 3: debug_mode=true
(assert (= config_line3 "debug_mode=true"))

; INI file content with section
(assert (= ini_content "[database]\nhost=localhost\nport=3306\n[logging]\nlevel=debug\nfile=app.log"))

; Section header
(assert (= section_header "[database]"))

; ; Key validation: Extract keys from configuration lines
; For config_line1 with '=' delimiter
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))

; For config_line2 with ':' delimiter 
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))

; Key validation constraints
(assert (> (str.len key1) 0))
(assert (> (str.len key2) 0))
(assert (not (str.contains key1 " ")))
(assert (not (str.contains key2 " ")))

; ; Value extraction constraints
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; Ensure proper number of splits for key-value pairs
(assert (= (str.num_splits config_line1 "=") 2))
(assert (= (str.num_splits config_line2 ":") 2))

; ; Section handling: Extract section name from header
(assert (= section_name (str.split_at section_header "[" 1)))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Section validation
(assert (> (str.len section_name) 0))
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))

; INI file structure validation
; Should have multiple lines separated by newline
(assert (> (str.num_splits ini_content "\n") 1))

; Should contain section headers
(assert (str.contains ini_content "["))
(assert (str.contains ini_content "]"))

; Advanced constraints for multi-section INI processing
(declare-fun first_section () String)
(declare-fun second_section () String)
(declare-fun database_config () String)
(declare-fun logging_config () String)

; Split INI content by sections
(assert (= first_section (str.split_at ini_content "[" 1)))
(assert (= database_config (str.split_at first_section "]" 1)))
(assert (= logging_config (str.split_rest ini_content "[" 2)))

; Database section should contain host and port
(assert (str.contains database_config "host="))
(assert (str.contains database_config "port="))

; Logging section should contain level and file
(assert (str.contains logging_config "level="))
(assert (str.contains logging_config "file="))

; ; Key-value pair extraction from database section
(declare-fun db_host_line () String)
(declare-fun db_port_line () String)
(declare-fun db_host_key () String)
(declare-fun db_host_value () String)
(declare-fun db_port_key () String)
(declare-fun db_port_value () String)

; ; Extract individual configuration lines
(assert (= db_host_line (str.split_at database_config "\n" 1)))
(assert (= db_port_line (str.split_at database_config "\n" 2)))

; Parse host configuration
(assert (= db_host_key (str.split_at db_host_line "=" 0)))
(assert (= db_host_value (str.split_at db_host_line "=" 1)))

; Parse port configuration
(assert (= db_port_key (str.split_at db_port_line "=" 0)))
(assert (= db_port_value (str.split_at db_port_line "=" 1)))

; Validation constraints for database configuration
(assert (= db_host_key "host"))
(assert (= db_port_key "port"))
(assert (> (str.len db_host_value) 0))
(assert (> (str.len db_port_value) 0))

; ; Port value should be numeric (simplified check)
(assert (not (str.contains db_port_value "a")))
(assert (not (str.contains db_port_value "z")))

; ; Complex constraint: Ensure proper INI structure
; Each section should have at least one key-value pair
(declare-fun section_content () String)
(assert (= section_content (str.split_rest database_config "\n" 1)))
(assert (str.contains section_content "="))
(assert (> (str.num_splits section_content "=") 1))

; Error handling: Invalid configuration detection
(declare-fun invalid_config () String)
(assert (= invalid_config "invalid_key==double_equals"))

; This should fail validation due to double equals
(declare-fun invalid_splits () Int)
(assert (= invalid_splits (str.num_splits invalid_config "=")))
(assert (> invalid_splits 2))

; Constraint that makes this unsatisfiable for invalid configs
(declare-fun valid_key_from_invalid () String)
(assert (= valid_key_from_invalid (str.split_at invalid_config "=" 0)))
(assert (and (> (str.len valid_key_from_invalid) 0)
 (not (str.contains valid_key_from_invalid "="))))

; This creates a contradiction since the key from double equals will be valid
; but the original string has invalid format

(check-sat)
(exit)
(get-model)
