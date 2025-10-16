
(set-logic QF_SLIA) ; String theory with quantifier-free constraints
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const space String)
(assert (= space " "))
(declare-const colon String)
(assert (= colon ":"))
(declare-const dash String)
(assert (= dash "-"))
(declare-const pipe String)
(assert (= pipe "|"))
(declare-const lbracket String)
(assert (= lbracket "["))
(declare-const rbracket String)
(assert (= rbracket "]"))

; Declare variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: [2023-01-15 14:30:45] INFO | System started
; Constraints for timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (>= (str.len log_entry) 20)) ; Minimum length for timestamp

; ; Extract timestamp between brackets
(assert (= timestamp (str.split_at (str.split_at log_entry lbracket 1) rbracket 0)))

; Verify timestamp components
(assert (= (str.split_at timestamp dash 0) "2023")) ; Year
(assert (= (str.split_at timestamp dash 1) "01")) ; Month
(assert (= (str.split_at (str.split_at timestamp dash 2) space 0) "15")) ; Day
(assert (= (str.split_at (str.split_at timestamp space 1) colon 0) "14")) ; Hour
(assert (= (str.split_at (str.split_at timestamp space 1) colon 1) "30")) ; Minute
(assert (= (str.split_at (str.split_at timestamp space 1) colon 2) "45")) ; Second

; ; Extract log level (must be one of standard levels)
(assert (or
 (= log_level "TRACE")
 (= log_level "DEBUG")
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "FATAL")
))

; Verify log level appears after timestamp and before message
(assert (= log_level (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))

; Message must be non-empty and appear after log level
(assert (> (str.len message) 0))
(assert (= message (str.split_rest (str.split_rest log_entry pipe 1) space 1)))

; Additional constraints for realistic log entries
(assert (str.contains log_entry lbracket))
(assert (str.contains log_entry rbracket))
(assert (str.contains log_entry pipe))
(assert (str.contains log_entry colon))

; Test case 1: Valid log entry
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))
(assert (= log_level "INFO"))
(assert (= message "System started successfully"))
(check-sat)




(exit)
(get-model)
