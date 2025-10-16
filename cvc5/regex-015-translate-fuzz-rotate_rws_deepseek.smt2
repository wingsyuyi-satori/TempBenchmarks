
; SMT-LIB2 script for configuration file parsing
; Focus on key-value pairs and INI section handling
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const equals_delim String)
(assert (= equals_delim "="))
(declare-const colon_delim String)
(assert (= colon_delim ":"))
(declare-const newline_delim String)
(assert (= newline_delim "\n"))
(declare-const open_bracket String)
(assert (= open_bracket "["))
(declare-const close_bracket String)
(assert (= close_bracket "]"))

; ; Example configuration content
(declare-const config_content String)
(assert (= config_content "[database]\nhost=localhost\nport:5432\n[logging]\nlevel=debug\nfile=/var/log/app.log"))

; ; Section extraction function
(define-fun get_section ((content String) (section_name String)) String
 (let ((section_header (str.++ open_bracket section_name close_bracket)))
 (ite (str.contains content section_header)
 (let ((after_header (str.split_rest content section_header 1)))
 (ite (str.contains after_header open_bracket)
 (str.split_at after_header open_bracket 0)
 after_header))
 "")))

; ; Key-value extraction functions
(define-fun get_value ((section String) (key String) (delim String)) String
 (let ((key_line (str.++ key delim)))
 (ite (str.contains section key_line)
 (let ((after_key (str.split_rest section key_line 1)))
 (str.split_at after_key newline_delim 0))
 "")))

; ; Validate database section exists
(declare-const db_section String)
(assert (= db_section (get_section config_content "database")))
(assert (not (= db_section "")))

; ; Extract and validate database host
(declare-const db_host String)
(assert (= db_host (get_value db_section "host" equals_delim)))
(assert (not (= db_host "")))
(assert (str.prefixof "localhost" db_host))

; ; Extract and validate database port
(declare-const db_port String)
(assert (= db_port (get_value db_section "port" colon_delim)))
(assert (not (= db_port "")))
(assert (str.is_digit db_port))

; ; Validate logging section exists
(declare-const log_section String)
(assert (= log_section (get_section config_content "logging")))
(assert (not (= log_section "")))

; ; Extract and validate logging level
(declare-const log_level String)
(assert (= log_level (get_value log_section "level" equals_delim)))
(assert (or (= log_level "debug") (= log_level "info") (= log_level "error")))

; ; Extract and validate log file path
(declare-const log_file String)
(assert (= log_file (get_value log_section "file" equals_delim)))
(assert (str.prefixof "/var/log/" log_file))

; Negative test case: Missing section should be empty
(declare-const missing_section String)
(assert (= missing_section (get_section config_content "security")))
(assert (= missing_section ""))

; ; Test invalid key extraction
(declare-const invalid_value String)
(assert (= invalid_value (get_value db_section "timeout" equals_delim)))
(assert (= invalid_value ""))

; ; Check for malformed section headers
(assert (not (str.contains config_content (str.++ open_bracket open_bracket))))
(assert (not (str.contains config_content (str.++ close_bracket close_bracket))))

(check-sat)
(get-model)
