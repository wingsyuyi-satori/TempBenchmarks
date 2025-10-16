; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)
(set-option :produce-models true)

; Declare string variables representing a line and a section in an INI file
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun sectionHeader () String)

; ; Example: line1 = "user=admin"
; line2 = "password:1234"
; sectionHeader = "[database]"

; Key validation: Ensure that before '=' or ':' is a non-empty key (no whitespace)
(define-fun key1 () String (str.split_at line1 "=" 0))
(define-fun value1 () String (str.split_at line1 "=" 1))
(define-fun key2 () String (str.split_at line2 ":" 0))
(define-fun value2 () String (str.split_at line2 ":" 1))

(assert (> (str.len key1) 0))
(assert (not (str.contains key1 " ")))
(assert (> (str.len key2) 0))
(assert (not (str.contains key2 " ")))

; ; Value extraction: Values must not be empty
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; ; Section handling: Validate INI section header format [section]
; 1. sectionHeader starts with '[' and ends with ']'
(assert (= (str.at sectionHeader 0) "["))
(assert (= (str.at sectionHeader (- (str.len sectionHeader) 1)) "]"))

; ; 2. Extract section name between brackets using split operations
; - First split at "[" (should yield "" and rest)
; - Then split rest at "]" (should yield section name and "")
(define-fun afterOpenBracket () String (str.split_at sectionHeader "[" 1))
(define-fun sectionName () String (str.split_at afterOpenBracket "]" 0))
(define-fun afterCloseBracket () String (str.split_at afterOpenBracket "]" 1))

(assert (> (str.len sectionName) 0))
(assert (= afterCloseBracket ""))

; Relationship: Key-value pairs must not use the section header as a key
(assert (not (= key1 sectionName)))
(assert (not (= key2 sectionName)))

; ; Satisfiable scenario: Provide concrete examples for model finding
(assert (= line1 "user=admin"))
(assert (= line2 "password:1234"))
(assert (= sectionHeader "[database]"))

; Unsatisfiable scenario: Try to force a contradiction
; Forbid value1 from being "admin" (which it actually is above)
(assert (not (= value1 "admin")))

(check-sat)
(get-model)
