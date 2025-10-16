; SMT-LIB2 script for configuration parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const eq-delim String) ; '=' for key-value pairs
(declare-const colon-delim String) ; ':' alternative delimiter
(declare-const nl-delim String) ; '\n' for line separation
(declare-const sect-open String) ; '[' for section opening
(declare-const sect-close String) ; ']' for section closing

(assert (= eq-delim "="))
(assert (= colon-delim ":"))
(assert (= nl-delim "\n"))
(assert (= sect-open "["))
(assert (= sect-close "]"))

; Declare variables for configuration parsing
(declare-const config-str String) ; The complete configuration string
(declare-const line1 String) ; First line of configuration
(declare-const line2 String) ; Second line of configuration
(declare-const section-header String) ; Section header
(declare-const key1 String) ; First key
(declare-const value1 String) ; First value
(declare-const key2 String) ; Second key
(declare-const value2 String) ; Second value

; Constraints for basic key-value parsing
(assert (= line1 (str.split_at config-str nl-delim 0)))
(assert (= line2 (str.split_at config-str nl-delim 1)))

; Key1 must be alphanumeric and not empty
(assert (= key1 (str.split_at line1 eq-delim 0)))
(assert (>= (str.len key1) 1))
(assert (str.is_digit (str.at key1 0))) ; First character must be digit (example constraint)

; Value1 must exist and be non-empty
(assert (= value1 (str.split_at line1 eq-delim 1)))
(assert (>= (str.len value1) 1))

; Alternative parsing with colon delimiter
(assert (or 
 (= key2 (str.split_at line2 eq-delim 0))
 (= key2 (str.split_at line2 colon-delim 0))
))

; ; Value extraction must be consistent with delimiter choice
(assert (or
 (and 
 (str.contains line2 eq-delim)
 (= value2 (str.split_at line2 eq-delim 1))
)
 (and
 (str.contains line2 colon-delim)
 (= value2 (str.split_at line2 colon-delim 1))
)
))

; Section handling constraints
(assert (str.prefixof sect-open (str.split_at config-str nl-delim 2)))
(assert (= section-header 
 (str.substr (str.split_at config-str nl-delim 2) 
 (str.len sect-open) 
 (- (str.len (str.split_at config-str nl-delim 2)) (str.len sect-open) 1))
))
(assert (str.suffixof sect-close (str.split_at config-str nl-delim 2)))

; Section content validation
(assert (>= (str.len section-header) 3)) ; Minimum section header length
(assert (not (str.contains section-header " "))) ; No spaces allowed in section names

; Configuration must have at least 3 lines (section header + 2 key-value pairs)
(assert (>= (str.num_splits config-str nl-delim) 3))

; Key-value pairs must appear after section header
(assert (not (str.prefixof sect-open line1)))
(assert (not (str.prefixof sect-open line2)))

; ; Unsatisfiable constraint example (comment out for satisfiable version)
;(assert (str.contains key1 " ")) ; Keys cannot contain spaces (conflicts with earlier digit constraint)

(check-sat)
(exit)
(get-model)
