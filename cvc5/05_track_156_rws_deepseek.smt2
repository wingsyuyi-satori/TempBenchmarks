; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
; Using standard string operations with fixed delimiters
(set-logic QF_SLIA)

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

; ; Example log format: "[2023-01-15 14:30:00] INFO | System started"
(assert (= log_entry "[2023-01-15 14:30:00] INFO | System started"))

; ; Extract timestamp between brackets
(assert (= timestamp (str.split_at (str.split_at log_entry lbracket 1) rbracket 0)))

; Verify timestamp format: YYYY-MM-DD HH:MM:SS
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp dash 0) "2023"))
(assert (= (str.split_at timestamp dash 1) "01"))
(assert (= (str.split_at timestamp dash 2) "15 14:30:00"))
(assert (= (str.split_at (str.split_at timestamp space 1) colon 0) "14"))
(assert (= (str.split_at (str.split_at timestamp space 1) colon 1) "30:00"))

; ; Extract log level after timestamp (between ] and |)
(assert (= log_level (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))
(assert (= (str.split_at log_level space 1) "INFO"))

; ; Validate log level is one of standard values
(assert (or (= log_level " INFO ")
 (= log_level " ERROR ")
 (= log_level " WARN ")
 (= log_level " DEBUG ")))

; ; Extract message after pipe
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (str.contains message "System started"))

; Additional constraints for unsatisfiable case
(declare-const bad_log_entry String)
(assert (= bad_log_entry "[2023-13-32 25:61:61] CRITICAL | Invalid timestamp"))

; This should make the problem unsatisfiable
(assert (= (str.split_at (str.split_at bad_log_entry dash 1) space 0) "13"))
(assert (= (str.split_at (str.split_at bad_log_entry colon 1) colon 0) "25"))

; ; Check satisfiability of both cases
(check-sat)
(get-model)
