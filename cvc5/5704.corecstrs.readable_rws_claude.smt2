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

; Constants for delimiters
(declare-fun equals_delim () String)
(declare-fun colon_delim () String)
(declare-fun newline_delim () String)
(declare-fun left_bracket () String)
(declare-fun right_bracket () String)

; Set delimiter values
(assert (= equals_delim "="))
(assert (= colon_delim ":"))
(assert (= newline_delim "\n"))
(assert (= left_bracket "["))
(assert (= right_bracket "]"))

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= extracted_key (str.split_at config_line equals_delim 0)))
(assert (= extracted_value (str.split_at config_line equals_delim 1)))

; Key validation - keys should not be empty and contain valid characters
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "\t")))

; ; Value extraction validation
(assert (> (str.len extracted_value) 0))
(assert (= (str.num_splits config_line equals_delim) 2))

; Alternative configuration with colon delimiter
(assert (= key_value_pair "port: 5432"))
(assert (= (str.split_at key_value_pair colon_delim 0) "port"))
(assert (= (str.split_at key_value_pair colon_delim 1) " 5432"))

; Section header processing
(assert (= section_header "[database]"))
(assert (= (str.num_splits section_header left_bracket) 2))
(assert (= (str.split_at section_header left_bracket 1) "database]"))
(assert (= section_name (str.split_at (str.split_at section_header left_bracket 1) right_bracket 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n[database]\nhost=db.example.com\nport=5432"))

; ; Extract first section
(assert (= (str.num_splits ini_content newline_delim) 6))
(assert (= (str.split_at ini_content newline_delim 0) "[server]"))
(assert (= (str.split_at ini_content newline_delim 1) "host=example.com"))
(assert (= (str.split_at ini_content newline_delim 2) "port=8080"))

; ; Validate server section configuration
(assert (str.prefixof "[server]" (str.split_at ini_content newline_delim 0)))
(assert (str.contains (str.split_at ini_content newline_delim 1) equals_delim))
(assert (str.contains (str.split_at ini_content newline_delim 2) equals_delim))

; ; Extract database section
(assert (= (str.split_at ini_content newline_delim 3) "[database]"))
(assert (= (str.split_at ini_content newline_delim 4) "host=db.example.com"))
(assert (= (str.split_at ini_content newline_delim 5) "port=5432"))

; ; Validate database section
(assert (str.prefixof "[database]" (str.split_at ini_content newline_delim 3)))

; Key-value pair validation in database section
(assert (= (str.split_at (str.split_at ini_content newline_delim 4) equals_delim 0) "host"))
(assert (= (str.split_at (str.split_at ini_content newline_delim 4) equals_delim 1) "db.example.com"))
(assert (= (str.split_at (str.split_at ini_content newline_delim 5) equals_delim 0) "port"))
(assert (= (str.split_at (str.split_at ini_content newline_delim 5) equals_delim 1) "5432"))

; Full configuration reconstruction
(assert (= full_config (str.++ 
 (str.split_at ini_content newline_delim 0) newline_delim
 (str.split_at ini_content newline_delim 1) newline_delim
 (str.split_at ini_content newline_delim 2) newline_delim
 (str.split_at ini_content newline_delim 3) newline_delim
 (str.split_at ini_content newline_delim 4) newline_delim
 (str.split_at ini_content newline_delim 5))))

; Section handling with split_rest for remaining content
(assert (= (str.split_rest ini_content newline_delim 3) "[database]\nhost=db.example.com\nport=5432"))

; Invalid configuration constraints - should make problem unsatisfiable
(declare-fun invalid_config () String)
(assert (= invalid_config "invalid_key_without_delimiter"))
(assert (= (str.num_splits invalid_config equals_delim) 2))

; Key validation constraints
(assert (not (= extracted_key "")))
(assert (not (str.prefixof "=" extracted_key)))
(assert (not (str.suffixof "=" extracted_key)))

; Section name validation
(assert (not (= section_name "")))
(assert (not (str.contains section_name left_bracket)))
(assert (not (str.contains section_name right_bracket)))

; Value processing constraints
(assert (not (str.prefixof equals_delim extracted_value)))
(assert (not (str.prefixof colon_delim extracted_value)))

(check-sat)
(exit)
(get-model)
