; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; ; Split operations: key validation, value extraction, section handling
; Delimiters used: '=', ':', '\n', '[', ']'

(set-logic ALL)

; ; Declare variables representing configuration file content and extracted parts
(declare-fun config_line () String)
(declare-fun section_header () String)
(declare-fun key () String)
(declare-fun value () String)
(declare-fun section_name () String)

; ; Example config_line: "username=admin"
; ; Example section_header: "[database]"

; ; Key-Value Pair Extraction using '=' delimiter
(assert
 (= key (str.split_at config_line "=" 0))
)
(assert
 (= value (str.split_at config_line "=" 1))
)

; Key validation: key should not be empty and should not contain whitespace or '='
(assert (not (= key "")))
(assert (= (str.indexof key " " 0) -1))
(assert (= (str.indexof key "=" 0) -1))

; Value validation: value should not be empty
(assert (not (= value "")))

; ; Section Header Extraction: e.g., "[database]" -> section_name = "database"
(assert
 (= section_name
 (str.split_at (str.split_rest section_header "[" 1) "]" 0)
)
)

; Section handling: section_header must start with '[' and end with ']'
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))

; ; Unsatisfiable constraint: section_name cannot be empty AND contain only digits (contradiction)
(assert (or
 (not (= section_name "")) ; section_name is not empty
 (not (forall ((i Int))
 (=> (and (>= i 0) (< i (str.len section_name)))
 (let ((c (str.at section_name i)))
 (and (>= (str.to_code c) 48) (<= (str.to_code c) 57)) ; is digit
)
)
))
))

; ; Satisfiable example: config_line is "user:admin", key is "user", value is "admin"
(assert (= config_line "user:admin"))
(assert (= section_header "[main]"))

; ; Choose ':' as delimiter for key-value in this example
(assert
 (= key (str.split_at config_line ":" 0))
)
(assert
 (= value (str.split_at config_line ":" 1))
)

; The number of splits for config_line with ':' should be 2
(assert (= (str.num_splits config_line ":") 2))

; Section_name should be "main" according to section_header
(assert (= section_name "main"))

; Satisfiable: key is not "password"
(assert (not (= key "password")))

(check-sat)
(get-model)
