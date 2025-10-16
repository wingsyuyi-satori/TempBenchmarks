; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL_SUPPORTED)

; Declare string variables
(declare-fun config_line () String) ; A single line from a config file
(declare-fun section_header () String) ; A line representing a section header
(declare-fun key () String) ; The extracted key
(declare-fun value () String) ; The extracted value
(declare-fun section_name () String) ; The name of the section
(declare-fun rest_after_key () String) ; The rest of the line after the key delimiter
(declare-fun rest_after_section () String) ; The rest of the header after '['

; ; Example: config_line = "username=admin"
; section_header = "[UserSettings]"

; Key-value splitting using '=' delimiter
(assert (= key (str.split_at config_line "=" 0)))
(assert (= rest_after_key (str.split_rest config_line "=" 1)))
; If the line contains more than one '=', value is everything after the first '='
(assert (= value (str.split_at rest_after_key "\n" 0)))

; Key validation: Key must not be empty and must not contain '=' or ':'
(assert (not (= key "")))
(assert (= (str.indexof key "=" 0) -1))
(assert (= (str.indexof key ":" 0) -1))

; ; Value extraction: Value must not contain line breaks
(assert (= (str.indexof value "\n" 0) -1))

; Section header parsing: section_header = "[SectionName]"
; ; Check that the section_header starts with '[' and ends with ']'
(assert (= (str.at section_header 0) "["))
(assert (= (str.at section_header (- (str.len section_header) 1)) "]"))

; ; Extract section name from section_header by splitting at '[' and ']'
(assert (= rest_after_section (str.split_rest section_header "[" 1)))
(assert (= section_name (str.split_at rest_after_section "]" 0)))

; Section name validation: Must not be empty, must not contain '[' or ']', and must not contain '='
(assert (not (= section_name "")))
(assert (= (str.indexof section_name "[" 0) -1))
(assert (= (str.indexof section_name "]" 0) -1))
(assert (= (str.indexof section_name "=" 0) -1))

; ; Satisfiable scenario: Provide concrete examples that satisfy all constraints
 (assert (= config_line "username=admin"))
 (assert (= section_header "[UserSettings]"))
 (check-sat)



(exit)
(get-model)
