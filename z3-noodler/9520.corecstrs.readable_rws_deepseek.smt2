; ; SMT-LIB2 script for log analysis with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
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

; ; Example log format: [2023-01-15 14:30:45] INFO | System started
; Constraints for valid log parsing

; ; 1. Extract timestamp between brackets
(assert (= timestamp (str.split_at (str.split_at log_entry lbracket 1) rbracket 0)))

; ; 2. Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp dash 0) "2023")) ; Year
(assert (= (str.split_at (str.split_at timestamp dash 1) dash 0) "01")) ; Month
(assert (= (str.split_at (str.split_at timestamp dash 1) space 0) "01-15")) ; Day
(assert (= (str.split_at (str.split_at timestamp space 1) colon 0) "14")) ; Hour
(assert (= (str.split_at (str.split_at (str.split_at timestamp space 1) colon 1) colon 0) "30")) ; Minute
(assert (= (str.split_at (str.split_at timestamp space 1) colon 2) "45")) ; Second

; ; 3. Extract log level after timestamp (between ']' and '|')
(assert (= log_level (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))
(assert (= (str.substr log_level 0 1) space)) ; Space after ]
(assert (= (str.substr log_level (- (str.len log_level) 1) 1) space)) ; Space before |

; ; 4. Validate log level is one of INFO, WARN, ERROR, DEBUG
(assert (or (= (str.replace_all log_level space "") "INFO")
 (= (str.replace_all log_level space "") "WARN")
 (= (str.replace_all log_level space "") "ERROR")
 (= (str.replace_all log_level space "") "DEBUG")))

; ; 5. Extract message after pipe
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (>= (str.len message) 1)) ; Message must not be empty

; ; 6. Additional constraint: timestamp must come before log level
(assert (str.prefixof (str.++ lbracket timestamp rbracket) log_entry))

; ; 7. Additional constraint: log level must come before message
(assert (str.contains (str.split_rest log_entry rbracket 1) pipe))

; ; Satisfiable example
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))
(check-sat)



(get-model)
