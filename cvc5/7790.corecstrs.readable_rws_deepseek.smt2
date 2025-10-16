; Complete SMT-LIB2 file for configuration parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const eq_delim String) ; = for key-value pairs
(declare-const colon_delim String) ; : alternative delimiter
(declare-const nl_delim String) ; \n for line separation
(declare-const sec_open String) ; [ for section start
(declare-const sec_close String) ; ] for section end

(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= sec_open "["))
(assert (= sec_close "]"))

; Declare configuration variables
(declare-const config String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)
(declare-const section_header String)

; ; Example configuration with sections and key-value pairs
(assert (= config (str.++ 
 "[database]" nl_delim
 "host=localhost" nl_delim
 "port:3306" nl_delim
 "[logging]" nl_delim
 "level=debug" nl_delim
)))

; ; Extract first line (should be a section header)
(assert (= line1 (str.split_at config nl_delim 0)))
(assert (str.contains line1 sec_open))
(assert (str.contains line1 sec_close))

; ; Extract section name from header
(assert (= section_header 
 (str.split_at 
 (str.substr line1 1 (- (str.len line1) 2)) 
 " " 
 0
)
))
(assert (str.prefixof "data" section_header)) ; Section name starts with 'data'

; ; Extract second line (key-value pair with = delimiter)
(assert (= line2 (str.split_at config nl_delim 1)))
(assert (str.contains line2 eq_delim))
(assert (= (str.split_at line2 eq_delim 0) "host")) ; Key is 'host'
(assert (= (str.split_at line2 eq_delim 1) "localhost")) ; Value is 'localhost'

; ; Extract third line (key-value pair with : delimiter)
(assert (= line3 (str.split_at config nl_delim 2)))
(assert (str.contains line3 colon_delim))
(assert (= (str.split_at line3 colon_delim 0) "port")) ; Key is 'port'
(assert (= (str.split_at line3 colon_delim 1) "3306")) ; Value is '3306'

; ; Validate number of splits in a line
(assert (= (str.num_splits line2 eq_delim) 2)) ; Exactly one = delimiter
(assert (= (str.num_splits line3 colon_delim) 2)) ; Exactly one : delimiter

; Key validation constraints (no spaces, no delimiters in keys)
(assert (not (str.contains (str.split_at line2 eq_delim 0) " ")))
(assert (not (str.contains (str.split_at line2 eq_delim 0) eq_delim)))
(assert (not (str.contains (str.split_at line2 eq_delim 0) colon_delim)))

; Section validation constraints
(declare-const invalid_section String)
(assert (= invalid_section (str.++ sec_open "invalid section" sec_close)))
(assert (not (str.contains config invalid_section))) ; Config doesn't contain invalid section

; ; Unsatisfiable constraint: cannot have same key in same section
(declare-const dup_key String)
(assert (= dup_key (str.++ "host=127.0.0.1" nl_delim "host=localhost")))
(assert (not (str.contains config dup_key)))

; ; Extract remaining configuration after first section
(declare-const rest_config String)
(assert (= rest_config (str.split_rest config nl_delim 3)))
(assert (str.contains rest_config "[logging]")) ; Contains next section

(check-sat)
(get-model)
