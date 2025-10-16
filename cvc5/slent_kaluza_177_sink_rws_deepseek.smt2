; ; SMT-LIB2 script for log analysis with timestamp and level extraction
; Delimiters: space, colon, hyphen, pipe, square brackets
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string sort and variables
(declare-fun log_entry () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)

; ; Example log format: "[2023-01-15 14:30:45] INFO: System started | PID=1234"
; Define constants for delimiters
(define-const space String " ")
(define-const colon String ":")
(define-const hyphen String "-")
(define-const pipe String "|")
(define-const lbracket String "[")
(define-const rbracket String "]")

; ; Constraints for timestamp extraction and validation
(assert (= timestamp (str.split_at (str.split_at log_entry rbracket 0) lbracket 1)))
(assert (= (str.len timestamp) 19)) ; YYYY-MM-DD HH:MM:SS format
(assert (= (str.split_at timestamp space 0) (str.++ (str.split_at (str.split_at timestamp hyphen 0) space 0) hyphen 
 (str.split_at (str.split_at timestamp hyphen 1) space 0) hyphen 
 (str.split_at (str.split_at timestamp hyphen 2) space 0))))
(assert (= (str.split_at timestamp space 1) (str.++ (str.split_at (str.split_at timestamp colon 0) space 1) colon 
 (str.split_at (str.split_at timestamp colon 1) space 1) colon 
 (str.split_at (str.split_at timestamp colon 2) space 1))))

; Constraints for log level validation
(assert (or (= log_level "INFO") 
 (= log_level "WARN") 
 (= log_level "ERROR") 
 (= log_level "DEBUG")))
(assert (= log_level (str.split_at (str.split_at log_entry colon 1) space 0)))

; ; Message extraction constraints
(assert (str.contains log_entry pipe))
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (not (str.contains message lbracket)))
(assert (not (str.contains message rbracket)))

; Sample satisfiable log entry
(assert (= log_entry "[2023-01-15 14:30:45] INFO: System started | PID=1234"))

; Additional unsatisfiable constraint (for demonstration)
;(assert (str.contains message "CRITICAL")) ; Would make unsat since log_level can't be CRITICAL

(check-sat)
(exit)
(get-model)
