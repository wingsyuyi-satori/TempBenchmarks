; SMT-LIB2 file for configuration parsing: key-value pairs and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic QF_SLIA)

; Declare string variables representing parts of a config file
(declare-fun config_line1 () String) ; e.g., "username=admin"
(declare-fun config_line2 () String) ; e.g., "timeout:30"
(declare-fun config_section () String) ; e.g., "[database]"

; Key and value variables
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)

; Section name variable
(declare-fun section_name () String)

; Key validation: key should not be empty and should not contain '=' or ':'
(assert (not (= key1 "")))
(assert (not (str.contains key1 "=")))
(assert (not (str.contains key1 ":")))

(assert (not (= key2 "")))
(assert (not (str.contains key2 "=")))
(assert (not (str.contains key2 ":")))

; ; Value extraction from "key=value" line
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))

; ; Value extraction from "key:value" line
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))

; Section handling: section line format is [section_name]
; The line starts with '[' and ends with ']'
(assert (= "[" (str.at config_section 0))) ; first char is '['
(assert (= "]" (str.at config_section (- (str.len config_section) 1)))) ; last char is ']'

; ; Extract section name: split by '[' and ']', get the part in between
; First, split at '[': index 1 is "section_name]"
(assert (= section_name
 (str.split_at (str.split_at config_section "[" 1) "]" 0)
))

; Section name must not be empty
(assert (not (= section_name "")))

; ; Satisfiable constraints: Example of a valid configuration
(assert (= config_line1 "username=admin"))
(assert (= config_line2 "timeout:30"))
(assert (= config_section "[database]"))

; ; Unsatisfiable constraint: key1 should not be "username", but config_line1 is "username=admin"
(assert (not (= key1 "username")))

; ; Another unsatisfiable constraint: section_name cannot be "database", but config_section is "[database]"
(assert (not (= section_name "database")))

; Demonstrate use of str.split_rest and str.num_splits for completeness

; config_line2: "timeout:30"
; str.num_splits should be 2 (timeout and 30)
(assert (= (str.num_splits config_line2 ":") 2))

; str.split_rest: from index 1, should be ":30"
(assert (= (str.split_rest config_line2 ":" 1) ":30"))

(check-sat)
(get-model)
