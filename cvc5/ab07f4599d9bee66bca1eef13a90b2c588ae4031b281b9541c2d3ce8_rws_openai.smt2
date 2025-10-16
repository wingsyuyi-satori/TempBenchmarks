; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare string variables representing lines and sections in the INI file
(declare-fun line1 () String) ; Example: "username=admin"
(declare-fun line2 () String) ; Example: "password:secret"
(declare-fun section1 () String) ; Example: "[database]\nhost=localhost\nport=3306"

; ; Declare string variables for keys and values extraction
(declare-fun key1 () String)
(declare-fun val1 () String)
(declare-fun key2 () String)
(declare-fun val2 () String)

; ; Declare string variable for section name extraction
(declare-fun section_name () String)

; ; Key-value pair extraction for line1 using '=' as delimiter
(assert (= key1 (str.split_at line1 "=" 0)))
(assert (= val1 (str.split_at line1 "=" 1)))
(assert (= 2 (str.num_splits line1 "="))) ; Should split into key and value

; Key validation: key must not be empty and must not contain whitespace
(assert (not (= key1 "")))
(assert (= (str.indexof key1 " " 0) -1))

; ; Value extraction: value must not be empty
(assert (not (= val1 "")))

; ; Key-value pair extraction for line2 using ':' as delimiter
(assert (= key2 (str.split_at line2 ":" 0)))
(assert (= val2 (str.split_at line2 ":" 1)))
(assert (= 2 (str.num_splits line2 ":"))) ; Should split into key and value

; Key validation: key must not be empty and must be alphanumeric
; ; For demonstration, check that key2 does not contain '[' or ']' or '=' or ':' or '\n'
(assert (= (str.indexof key2 "[" 0) -1))
(assert (= (str.indexof key2 "]" 0) -1))
(assert (= (str.indexof key2 "=" 0) -1))
(assert (= (str.indexof key2 ":" 0) -1))
(assert (= (str.indexof key2 "\n" 0) -1))

; ; Value extraction: value must not be empty
(assert (not (= val2 "")))

; ; Section handling: extract section name from section1
; Assume section1 is of the form "[section]\nkey=val\n..."
; The section name appears between '[' and ']'
(assert (= "[" (str.at section1 0)))
(assert (= section_name (str.split_at (str.split_at section1 "]" 0) "[" 1)))
; Above: split at ']' to get "[section", then split at '[' to get "section"

; Key validation: section_name should not be empty and should not contain spaces
(assert (not (= section_name "")))
(assert (= (str.indexof section_name " " 0) -1))

; ; Value extraction: extract the first key and value within the section
; The part after the first newline contains the first key-value line
(declare-fun section_kv_line () String)
(assert (= section_kv_line (str.split_at section1 "\n" 1)))
; Now split section_kv_line at '='
(declare-fun section_kv_key () String)
(declare-fun section_kv_val () String)
(assert (= section_kv_key (str.split_at section_kv_line "=" 0)))
(assert (= section_kv_val (str.split_at section_kv_line "=" 1)))
(assert (not (= section_kv_key "")))
(assert (not (= section_kv_val "")))

; ; Satisfiable scenario: provide concrete example values
(assert (= line1 "username=admin"))
(assert (= line2 "password:secret"))
(assert (= section1 "[database]\nhost=localhost\nport=3306"))

; ; Check if the constraints are satisfiable (should be SAT)
(check-sat)



(get-model)
