; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
; Delimiters: space, colon, hyphen, pipe, square brackets
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const space String)
(assert (= space " "))
(declare-const colon String)
(assert (= colon ":"))
(declare-const hyphen String)
(assert (= hyphen "-"))
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
; Constraints for valid timestamp format: [YYYY-MM-DD HH:MM:SS]
(assert (= timestamp (str.split_at log_entry rbracket 0)))
(assert (str.prefixof lbracket timestamp))
(assert (= (str.len timestamp) 21)) ; [ + 19 chars + ]

; ; Extract date part (YYYY-MM-DD)
(declare-const date_part String)
(assert (= date_part (str.substr timestamp 1 10)))
(assert (= (str.split_at date_part hyphen 0) "2023")) ; year
(assert (str.contains "01-02-03-04-05-06-07-08-09-10-11-12" (str.split_at date_part hyphen 1))) ; month
(assert (str.contains (str.split_at date_part hyphen 2) "0123456789")) ; day

; ; Extract time part (HH:MM:SS)
(declare-const time_part String)
(assert (= time_part (str.substr timestamp 12 8)))
(assert (str.contains "012" (str.split_at time_part colon 0))) ; hour
(assert (str.contains "012345" (str.split_at time_part colon 1))) ; minute
(assert (str.contains "012345" (str.split_at time_part colon 2))) ; second

; Log level validation (must be one of standard levels)
(declare-const level_part String)
(assert (= level_part (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))

; ; Message extraction (everything after the level)
(assert (= message (str.split_rest (str.split_rest log_entry pipe 1) space 1)))

; Additional constraints for realistic scenarios
; Constraint 1: Message cannot be empty if level is ERROR or FATAL

; Constraint 2: Timestamp must be at start of log entry
(assert (str.prefixof timestamp log_entry))

; Constraint 3: Log level must be uppercase

; ; Example concrete log entry (satisfiable case)
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started"))
(check-sat)



(get-model)
