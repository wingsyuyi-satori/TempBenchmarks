; SMT-LIB2 file for Configuration Parsing: Key-value and INI file processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare string variables for the configuration line and section header
(declare-fun cfg_line () String) ; Example: "user=admin"
(declare-fun section_hdr () String) ; Example: "[database]"

; Declare string variables for key and value
(declare-fun key () String)
(declare-fun value () String)

; Declare delimiter constants
(define-fun delim_eq () String "=")
(define-fun delim_colon () String ":")
(define-fun delim_nl () String "\n")
(define-fun delim_lb () String "[")
(define-fun delim_rb () String "]")

; ------------------------------------------
; ; Key-value pair extraction using '=' delimiter

; The key is the 0-th segment, value is the 1-st segment
(assert (= key (str.split_at cfg_line delim_eq 0)))
(assert (= value (str.split_at cfg_line delim_eq 1)))

; There should be exactly two segments when splitting on '='
(assert (= (str.num_splits cfg_line delim_eq) 2))

; Key validation: keys must not be empty and must not contain whitespace
(assert (not (= key "")))
(assert (not (str.contains key " ")))

; ; Value extraction: value must not be empty
(assert (not (= value "")))

; ------------------------------------------
; Section handling: section headers like "[database]"

; The section name is the 1-st segment when splitting header at '['
(declare-fun section_name () String)
(assert (= section_name (str.split_at section_hdr delim_lb 1)))

; The section name is before the closing ']'
(assert (= section_name (str.split_at section_name delim_rb 0)))

; Section header must start with '[' and end with ']'
(assert (str.prefixof "[" section_hdr))
(assert (str.suffixof "]" section_hdr))

; Section name must not be empty
(assert (not (= section_name "")))

; ------------------------------------------
; ; Satisfiable Example: "user=admin" in "[database]"

(assert (= cfg_line "user=admin"))
(assert (= section_hdr "[database]"))

; This should be SAT: key = "user", value = "admin", section_name = "database"

(check-sat)




(get-model)
