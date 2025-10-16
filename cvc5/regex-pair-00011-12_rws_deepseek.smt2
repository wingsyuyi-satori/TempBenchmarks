
; ; SMT-LIB2 script for log entry parsing with timestamp and level extraction
(set-logic QF_SLIA)
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

; Declare variables for log entry components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: [2023-01-15 14:30:45] INFO | System started
(assert (str.contains log_entry lbracket))
(assert (str.contains log_entry rbracket))
(assert (str.contains log_entry pipe))

; ; Extract timestamp (between brackets)
(assert (= timestamp (str.split_at log_entry lbracket 1)))
(assert (= timestamp (str.split_at timestamp rbracket 0)))

; ; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) dash))
(assert (= (str.at timestamp 7) dash))
(assert (= (str.at timestamp 10) space))
(assert (= (str.at timestamp 13) colon))
(assert (= (str.at timestamp 16) colon))

; ; Extract log level (between right bracket and pipe)
(assert (= log_level (str.split_rest log_entry rbracket 1)))
(assert (= log_level (str.split_at log_level pipe 0)))
(assert (= log_level (str.replace_all log_level space "")))

; ; Validate log level (must be one of standard levels)
(assert (or (= log_level "DEBUG")
 (= log_level "INFO")
 (= log_level "WARNING")
 (= log_level "ERROR")
 (= log_level "CRITICAL")))

; ; Extract message (after pipe)
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (str.contains message space)) ; Message must contain at least one word

; Additional constraints for realistic scenarios
; Constraint 1: If timestamp contains "2023", then log level must be INFO or higher
(assert (=> (str.contains timestamp "2023")
 (or (= log_level "INFO")
 (= log_level "WARNING")
 (= log_level "ERROR")
 (= log_level "CRITICAL"))))

; Constraint 2: ERROR messages must contain at least 3 words
(assert (=> (= log_level "ERROR")
 (>= (str.num_splits message space) 3)))

; Constraint 3: DEBUG messages cannot appear in timestamps after 18:00:00
(assert (=> (= log_level "DEBUG")
 (not (str.contains (str.split_at timestamp space 1) "18:"))))

; Test case 1: Valid log entry (satisfiable)
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))
(check-sat)




(exit)
(get-model)
