
(set-logic QF_SLIA) ; Set the string theory
(set-option :produce-models true) ; Enable model generation

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

; ; Example log format: [2023-01-15 14:30:45] INFO | System started successfully

; ; Constraints for timestamp extraction
(assert (= timestamp (str.split_at (str.split_at log_entry rbracket 0) lbracket 1)))
(assert (str.contains timestamp dash)) ; Must contain date separators
(assert (str.contains timestamp colon)) ; Must contain time separators
(assert (str.contains timestamp space)) ; Must contain space between date and time

; Constraints for log level validation
(assert (= log_level (str.split_at (str.split_at log_entry pipe 0) space 2)))
(assert (or (= log_level "INFO") 
 (= log_level "WARN") 
 (= log_level "ERROR") 
 (= log_level "DEBUG")))

; ; Constraints for message extraction
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (>= (str.len message) 1)) ; Message cannot be empty

; Additional constraints for well-formed log entries
(assert (str.prefixof lbracket log_entry)) ; Must start with [
(assert (str.contains log_entry rbracket)) ; Must contain ]
(assert (str.contains log_entry pipe)) ; Must contain |

; Test case 1: Valid log entry
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))
(check-sat)





(get-model)
