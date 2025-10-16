; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_SLIA)

; Declare the log entry variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-08 13:45:12] | INFO | User login successful

; ; Split 1: extract timestamp part between '[' and ']'
; First, get the part before first ']' (should be '[2024-06-08 13:45:12')
(define-fun ts_with_bracket () String (str.split_at log_entry "]" 0))

; Remove leading '[' to get the pure timestamp string
(define-fun ts () String (str.split_at ts_with_bracket "[" 1))

; ; Extract the part after the first '] | '
(define-fun after_bracket () String (str.split_rest log_entry "]" 1))
; after_bracket starts with ' | INFO | User login successful'

; Remove leading ' | ' to get 'INFO | User login successful'
(define-fun after_pipe1 () String (str.split_rest after_bracket "|" 1))
; after_pipe1 starts with ' INFO | User login successful'

; Remove leading space to get 'INFO | User login successful'
(define-fun after_space1 () String (str.split_at after_pipe1 " " 1))

; ; Extract log level (INFO, WARN, ERROR, etc.)
(define-fun log_level () String (str.split_at after_space1 "|" 0))
; log_level should be 'INFO'

; ; Extract message: all after the second '|'
(define-fun message () String (str.split_rest after_space1 "|" 1))
; message starts with ' User login successful'

; Remove leading space from message
(define-fun message_clean () String (str.split_at message " " 1))

; Timestamp validation: should have exactly one space between date and time
(assert (= (str.at ts 10) " "))

; ; Timestamp format: YYYY-MM-DD HH:MM:SS (no regex, but check delimiters)
; ; Check for '-' at positions 4 and 7, ':' at positions 13 and 16
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))

; ; Satisfiable constraint: log_level is one of "INFO", "WARN", "ERROR"
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR")))

; ; Unsatisfiable constraint: message_clean does not contain the word "login"
(assert (not (str.contains message_clean "login")))

; ; Example log entry for which the above would be unsatisfiable if uncommented
; (assert (= log_entry "[2024-06-08 13:45:12] | INFO | User login successful"))

(check-sat)
(get-model)
