; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare variables for a sample INI configuration line and section
(declare-fun cfg_line () String) ; e.g., "username=admin"
(declare-fun section_header () String) ; e.g., "[UserSettings]"

; Declare variables for split results
(declare-fun key () String)
(declare-fun val () String)
(declare-fun sec_bracketed () String)
(declare-fun sec_name () String)

; ; Key-value pair extraction: split at '=' delimiter
(assert (= key (str.split_at cfg_line "=" 0)))
(assert (= val (str.split_at cfg_line "=" 1)))

; Key validation: ensure key does not contain spaces or '=' or ':'
(assert (not (str.contains key " ")))
(assert (not (str.contains key "=")))
(assert (not (str.contains key ":")))

; ; Value extraction: allow ':' as alternate delimiter, e.g., "timeout:30"
; If '=' is not present, try ':'
(declare-fun alt_key () String)
(declare-fun alt_val () String)
(assert (= alt_key (str.split_at cfg_line ":" 0)))
(assert (= alt_val (str.split_at cfg_line ":" 1)))

; At least one delimiter must be present in the configuration line
(assert (or (> (str.num_splits cfg_line "=") 1)
 (> (str.num_splits cfg_line ":") 1)))

; ; Section handling: extract section name from header "[UserSettings]"
; sec_bracketed = section_header
; sec_name = the string between '[' and ']'

; Ensure section_header starts with '[' and ends with ']'
(assert (= (str.at section_header 0) "["))
(assert (= (str.at section_header (- (str.len section_header) 1)) "]"))

; Remove '[' by splitting at '[' and taking segment 1
(assert (= sec_bracketed (str.split_at section_header "[" 1)))
; Remove ']' by splitting at ']' and taking segment 0
(assert (= sec_name (str.split_at sec_bracketed "]" 0)))

; Section name must not be empty and must not contain '[' or ']'
(assert (> (str.len sec_name) 0))
(assert (not (str.contains sec_name "[")))
(assert (not (str.contains sec_name "]")))

; ; Satisfiable scenario: Provide a concrete example for all variables
(assert (= cfg_line "username=admin"))
(assert (= section_header "[UserSettings]"))

; Unsatisfiable scenario: Key contains invalid character (space)
(declare-fun bad_cfg_line () String)
(declare-fun bad_key () String)
(declare-fun bad_val () String)
(assert (= bad_cfg_line "user name=admin"))
(assert (= bad_key (str.split_at bad_cfg_line "=" 0)))
(assert (= bad_val (str.split_at bad_cfg_line "=" 1)))
; This assertion should make the instance UNSAT
(assert (str.contains bad_key " "))

; Another unsatisfiable scenario: Section name is empty
(declare-fun empty_section_header () String)
(declare-fun empty_sec_bracketed () String)
(declare-fun empty_sec_name () String)
(assert (= empty_section_header "[]"))
(assert (= empty_sec_bracketed (str.split_at empty_section_header "[" 1)))
(assert (= empty_sec_name (str.split_at empty_sec_bracketed "]" 0)))
(assert (= (str.len empty_sec_name) 0))

(check-sat)
(exit)
(get-model)
