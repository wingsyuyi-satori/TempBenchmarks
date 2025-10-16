; SMT-LIB2 file for Configuration Parsing (Key-value pairs and INI file processing)
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus areas: key validation, value extraction, section handling

(set-logic ALL)
(set-option :produce-models true)

; Declare string variables representing a line in an INI file and a section header
(declare-fun ini_line () String)
(declare-fun section_header () String)

; ; Example: ini_line = "username=admin"
; ; Example: section_header = "[database]"

; KEY-VALUE PAIR PARSING
; ; Split by '=', extract key and value

(declare-fun key_eq () String)
(declare-fun value_eq () String)
(declare-fun num_eq () Int)

(assert (= num_eq (str.num_splits ini_line "=")))
(assert (= key_eq (str.split_at ini_line "=" 0)))
(assert (= value_eq (str.split_at ini_line "=" 1)))

; Also handle alternative separator ':'
(declare-fun key_colon () String)
(declare-fun value_colon () String)
(declare-fun num_colon () Int)

(assert (= num_colon (str.num_splits ini_line ":")))
(assert (= key_colon (str.split_at ini_line ":" 0)))
(assert (= value_colon (str.split_at ini_line ":" 1)))

; KEY VALIDATION
; Keys must not contain spaces or delimiters '=', ':', '[', ']'
; This is a practical constraint in configuration files

(assert (not (str.contains key_eq " ")))
(assert (not (str.contains key_eq "=")))
(assert (not (str.contains key_eq ":")))
(assert (not (str.contains key_eq "[")))
(assert (not (str.contains key_eq "]")))

; ; VALUE EXTRACTION
; Values may contain spaces and are whatever follows the delimiter

; SECTION HANDLING
; Section headers are enclosed in '[' and ']'
; ; Example: section_header = "[network]"

(declare-fun section_left () String)
(declare-fun section_name () String)
(declare-fun section_right () String)
(declare-fun section_num_left () Int)
(declare-fun section_num_right () Int)

; Split section_header at '['
(assert (= section_num_left (str.num_splits section_header "[")))
(assert (= section_left (str.split_at section_header "[" 0)))
(assert (= section_right (str.split_rest section_header "[" 1)))

; Now split the remainder at ']'
(assert (= section_num_right (str.num_splits section_right "]")))
(assert (= section_name (str.split_at section_right "]" 0)))

; Section header must start with '[' and end with ']'
(assert (= (str.at section_header 0) "["))
(assert (= (str.at section_header (- (str.len section_header) 1)) "]"))

; Section name must not be empty and must not contain '[' or ']'
(assert (> (str.len section_name) 0))
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))

; ; REALISTIC EXAMPLES

; ; Satisfiable example: ini_line = "username=admin", section_header = "[users]"
(assert (= ini_line "username=admin"))
(assert (= section_header "[users]"))

; ; Check key and value extraction
(assert (= key_eq "username"))
(assert (= value_eq "admin"))
(assert (= section_name "users"))

; ; UNSATISFIABLE EXAMPLE

; The key cannot contain a bracket, so this should be unsat
(declare-fun bad_ini_line () String)
(declare-fun bad_key_eq () String)
(assert (= bad_ini_line "us[er=admin"))
(assert (= bad_key_eq (str.split_at bad_ini_line "=" 0)))
; This should be impossible due to earlier key validation
(assert (str.contains bad_key_eq "["))

(check-sat)
(exit)
(get-model)
