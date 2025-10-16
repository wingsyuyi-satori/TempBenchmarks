; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic QF_SLIA)

; Declare string variables representing lines and sections in the config
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun section_header () String)
(declare-fun section_content () String)
(declare-fun key () String)
(declare-fun value () String)

; ; Example: line1 is a standard key-value pair using '='
(assert (= line1 "username=admin"))

; ; Example: line2 uses ':' as delimiter
(assert (= line2 "port:8080"))

; ; Example: section_header denotes a section '[database]'
(assert (= section_header "[database]"))

; ; Example: section_content with two key-value pairs separated by '\n'
(assert (= section_content "host=localhost\nport:5432"))

; ----------------------------------------------------------------------
; ; Key validation: Extract key from line1 and ensure it matches "username"
; ----------------------------------------------------------------------
; Split line1 at '=' delimiter, get the 0th segment as key, 1st as value
(assert (= key (str.split_at line1 "=" 0)))
(assert (= value (str.split_at line1 "=" 1)))

; Key validation: The key must be "username"
(assert (= key "username"))

; ; Value extraction: value must be "admin"
(assert (= value "admin"))

; ----------------------------------------------------------------------
; ; Key validation: Extract key from line2 using ':' delimiter
; ----------------------------------------------------------------------
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (= key2 (str.split_at line2 ":" 0)))
(assert (= value2 (str.split_at line2 ":" 1)))

; Key2 must be "port" and value2 must be "8080"
(assert (= key2 "port"))
(assert (= value2 "8080"))

; ----------------------------------------------------------------------
; ; Section handling: extract section name from section_header
; ----------------------------------------------------------------------
; section_header is of the form "[database]"
(declare-fun section_left () String)
(declare-fun section_name () String)
(declare-fun section_right () String)

; Split at '[': the first segment is empty, second is 'database]'
(assert (= section_left (str.split_at section_header "[" 0)))
(assert (= section_right (str.split_at section_header "[" 1)))

; Now split section_right at ']': first segment is 'database', second is empty
(assert (= section_name (str.split_at section_right "]" 0)))

; Section name must be "database"
(assert (= section_name "database"))

; ; Unsatisfiable constraint: section_name cannot be "user"
(assert (not (= section_name "user")))

; ----------------------------------------------------------------------
; ; Section content handling: extracting the second key-value pair
; section_content: "host=localhost\nport:5432"
; ----------------------------------------------------------------------

; Number of splits with '\n' should be 2 (host=localhost, port:5432)
(assert (= (str.num_splits section_content "\n") 2))

; ; Extract first and second lines
(declare-fun sec_line1 () String)
(declare-fun sec_line2 () String)
(assert (= sec_line1 (str.split_at section_content "\n" 0)))
(assert (= sec_line2 (str.split_at section_content "\n" 1)))

; ; Extract key and value from sec_line2 (using ':' delimiter)
(declare-fun sec2_key () String)
(declare-fun sec2_value () String)
(assert (= sec2_key (str.split_at sec_line2 ":" 0)))
(assert (= sec2_value (str.split_at sec_line2 ":" 1)))

; sec2_key must be "port", sec2_value must be "5432"
(assert (= sec2_key "port"))
(assert (= sec2_value "5432"))

; ; Unsatisfiable constraint: sec2_key can't be "host"
(assert (not (= sec2_key "host")))

; ; Satisfiable constraint: sec_line1's value is "localhost"
(declare-fun sec1_key () String)
(declare-fun sec1_value () String)
(assert (= sec1_key (str.split_at sec_line1 "=" 0)))
(assert (= sec1_value (str.split_at sec_line1 "=" 1)))
(assert (= sec1_key "host"))
(assert (= sec1_value "localhost"))

; ----------------------------------------------------------------------
; Demonstrate str.split_rest: get everything from the second key-value onward
; Should return "port:5432" when starting from index 1
(declare-fun rest_after_first () String)
(assert (= rest_after_first (str.split_rest section_content "\n" 1)))
(assert (= rest_after_first "port:5432"))

; Unsatisfiable: rest_after_first is not "host=localhost"
(assert (not (= rest_after_first "host=localhost")))

; ----------------------------------------------------------------------
; Contradiction: try to assert the first key in section_content is "port"
(assert (not (= sec1_key "port"))) ; Satisfiable (since it is "host")
(assert (= sec1_key "host")) ; Satisfiable

; But now also assert sec1_key is "port" (unsatisfiable)
(assert (not (= sec1_key "port")))
(assert (not (= sec2_key "host")))

; ----------------------------------------------------------------------
; ; Check satisfiability
(check-sat)
(get-model)
