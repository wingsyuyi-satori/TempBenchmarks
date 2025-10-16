; ; SMT-LIB2 script for log analysis with timestamp and level extraction
; Complete standalone file for SMT solvers
(set-logic QF_SLIA) ; Quantifier-free strings

; Declare string constants for common delimiters
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
; Constraints for valid timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= timestamp (str.split_at (str.split_at log_entry rbracket 0) lbracket 1)))
(assert (= (str.len (str.split_at timestamp space 0)) 10)) ; Date part length
(assert (= (str.len (str.split_at timestamp space 1)) 8)) ; Time part length
(assert (= (str.split_at (str.split_at timestamp space 0) dash 0) "2023")) ; Sample year
(assert (= (str.split_at (str.split_at timestamp space 1) colon 0) "14")) ; Sample hour

; Log level validation (must be one of standard levels)
(declare-const level_part String)
(assert (= level_part (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))
(assert (= log_level (str.substr level_part 1 (- (str.len level_part) 2)))) ; Trim spaces
(assert (or (= log_level "DEBUG") 
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "FATAL")))

; ; Message extraction (everything after the pipe)
(assert (= message (str.split_rest (str.split_rest log_entry rbracket 1) pipe 1)))

; Additional constraints for realistic scenarios
; Constraint 1: Message cannot be empty for ERROR or FATAL levels
(assert (=> (or (= log_level "ERROR") (= log_level "FATAL"))
 (> (str.len message) 0)))

; Constraint 2: Timestamp must contain exactly 2 space separators
(assert (= (str.num_splits timestamp space) 2))

; Constraint 3: Time part must have exactly 2 colons
(declare-const time_part String)
(assert (= time_part (str.split_at timestamp space 1)))
(assert (= (str.num_splits time_part colon) 2))

; Both satisfiable and unsatisfiable cases
; Satisfiable case (uncomment to test)
;(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started"))

; Unsatisfiable case (uncomment to test)
;(assert (= log_entry "[2023-01-15 14:30:45] CUSTOM | ")) ; Invalid log level

(check-sat)
(exit)
(get-model)
