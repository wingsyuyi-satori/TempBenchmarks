; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; ; Focus: key validation, value extraction, section handling
; Delimiters used: '=', ':', '\n', '[', ']'
; Demonstrates use of split operations and realistic constraints

(set-logic QF_SLIA)

; Declare a string variable for a configuration line
(declare-fun conf_line () String)

; ; Example: conf_line = "username=admin"
; Key and value are separated by '='

; ; Extract the key (segment before '=')
(define-fun key_eq () String
 (str.split_at conf_line "=" 0))

; ; Extract the value (segment after '=')
(define-fun value_eq () String
 (str.split_at conf_line "=" 1))

; Number of segments after '=' split (should be 2 for simple key-value)
(define-fun num_kv_eq () Int
 (str.num_splits conf_line "="))

; Key validation: key must not contain spaces and not be empty
(assert (not (str.contains key_eq " ")))
(assert (not (= key_eq "")))

; ; Value extraction: value must not be empty
(assert (not (= value_eq "")))

; ; Satisfiable example: set conf_line to a valid key-value pair
(assert (= conf_line "username=admin"))

; ===============================
; Section: Section header parsing
; ; Example: section_line = "[Network]"
(declare-fun section_line () String)

; Number of segments after splitting by '[' (should be 2: "" and "Network]")
(define-fun num_section_bracket () Int
 (str.num_splits section_line "["))

; ; Extract section name with trailing ']'
(define-fun section_with_bracket () String
 (str.split_at section_line "[" 1))

; ; Extract actual section name (split by ']')
(define-fun section_name () String
 (str.split_at section_with_bracket "]" 0))

; section_name must not be empty
(assert (not (= section_name "")))

; ; Satisfiable example: section_line is "[Network]"
(assert (= section_line "[Network]"))

; ===============================
; Section: Key-value with colon as delimiter
(declare-fun conf_colon () String)

; ; Example: conf_colon = "path:/usr/bin"
(define-fun key_colon () String
 (str.split_at conf_colon ":" 0))
(define-fun value_colon () String
 (str.split_at conf_colon ":" 1))
(define-fun num_kv_colon () Int
 (str.num_splits conf_colon ":"))

; Key must not be empty or contain '[' or ']'
(assert (not (= key_colon "")))
(assert (not (str.contains key_colon "[")))
(assert (not (str.contains key_colon "]")))

; Value must not be empty
(assert (not (= value_colon "")))

; ; Satisfiable example: path:/usr/bin
(assert (= conf_colon "path:/usr/bin"))

; ===============================
; Section: Multi-line INI file parsing

(declare-fun ini_file () String)

; ; Example: ini_file = "[User]\nname=alice\nrole=admin"
; Split into lines
(define-fun ini_line0 () String (str.split_at ini_file "\n" 0))
(define-fun ini_line1 () String (str.split_at ini_file "\n" 1))
(define-fun ini_line2 () String (str.split_at ini_file "\n" 2))
(define-fun num_lines () Int (str.num_splits ini_file "\n"))

; Section: first line must be a section header
(assert (str.prefixof "[" ini_line0))
; Second line must be a key-value with '='
(assert (> (str.len (str.split_at ini_line1 "=" 1)) 0))
; Third line must be a key-value with '='
(assert (> (str.len (str.split_at ini_line2 "=" 1)) 0))
; Number of lines must be 3
(assert (= num_lines 3))

; ; Satisfiable example
(assert (= ini_file "[User]\nname=alice\nrole=admin"))

; ===============================
; Unsatisfiable constraints section

; ; Try to extract a section with an empty section name (should be unsat)
(declare-fun bad_section () String)
(assert (= bad_section "[]"))
(define-fun bad_section_with_bracket () String (str.split_at bad_section "[" 1))
(define-fun bad_section_name () String (str.split_at bad_section_with_bracket "]" 0))
(assert (= bad_section_name "")) ; section name cannot be empty

; ; Try to extract a key-value with no value (should be unsat)
(declare-fun bad_kv () String)
(assert (= bad_kv "port="))
(define-fun bad_key () String (str.split_at bad_kv "=" 0))
(define-fun bad_value () String (str.split_at bad_kv "=" 1))
(assert (not (= bad_value ""))) ; value cannot be empty

; ===============================
; Split_rest illustration: get the rest of the INI after first line

(define-fun ini_rest () String (str.split_rest ini_file "\n" 1))
; For our ini_file, ini_rest should be "name=alice\nrole=admin"
(assert (= ini_rest "name=alice\nrole=admin"))

(check-sat)
(exit)
(get-model)
