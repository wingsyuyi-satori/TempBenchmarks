; ; SMT-LIB2 file for Log Analysis: Parsing log entries for timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_SLIA)

; ; Declare the log entry variable (example: "[2024-06-21 15:23:10] INFO | User login successful")
(declare-fun log_entry () String)

; Declare variables for timestamp, log level, and message
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)

; ; Step 1: Extract the timestamp
; The timestamp is between '[' and ']'
; First, split at the first '[' (should be at index 0)
(define-fun idx_open_bracket () Int (str.indexof log_entry "[" 0))
(define-fun rest_after_open () String (str.split_rest log_entry "[" 1))

; Now, the timestamp is up to the first ']'
(define-fun idx_close_bracket () Int (str.indexof rest_after_open "]" 0))
(assert (= timestamp (str.substr rest_after_open 0 idx_close_bracket)))

; ; Step 2: Extract the log level
; The log level comes after "] " and before " |"
; First, get the part after the close bracket and space
(define-fun after_close_bracket () String (str.substr rest_after_open (+ idx_close_bracket 2) (- (str.len rest_after_open) (+ idx_close_bracket 2))))
; Now, split at " |" to separate log level and message
(define-fun idx_pipe () Int (str.indexof after_close_bracket "|" 0))

; ; Step 3: Extract the message
; The message is after the " |" delimiter
(define-fun message_start () Int (+ idx_pipe 2))
(assert (= message (str.substr after_close_bracket message_start (- (str.len after_close_bracket) message_start))))

; Constraint 1: Timestamp must be in format YYYY-MM-DD HH:MM:SS
; ; We'll check the number of splits when splitting by space and by ':', '-', etc.

; Split timestamp by space into two parts: date and time
(assert (= (str.num_splits timestamp " ") 2))
(define-fun timestamp_date () String (str.split_at timestamp " " 0))
(define-fun timestamp_time () String (str.split_at timestamp " " 1))

; Date must split into 3 parts by '-': YYYY, MM, DD
(assert (= (str.num_splits timestamp_date "-") 3))
(define-fun ts_year () String (str.split_at timestamp_date "-" 0))
(define-fun ts_month () String (str.split_at timestamp_date "-" 1))
(define-fun ts_day () String (str.split_at timestamp_date "-" 2))

; Time must split into 3 parts by ':': HH, MM, SS
(assert (= (str.num_splits timestamp_time ":") 3))
(define-fun ts_hour () String (str.split_at timestamp_time ":" 0))
(define-fun ts_minute () String (str.split_at timestamp_time ":" 1))
(define-fun ts_second () String (str.split_at timestamp_time ":" 2))

; Constraint 2: Log level must be one of "INFO", "WARN", "ERROR", "DEBUG"
(assert (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
))

; Constraint 3: Message must not be empty
(assert (not (= message "")))

; Satisfiable scenario: Provide a concrete log entry that matches all constraints
(assert (= log_entry "[2024-06-21 15:23:10] INFO | User login successful"))

; Unsatisfiable scenario: Add a constraint that contradicts the above, e.g., require log_level to be "ERROR" while log_entry is "INFO"
(assert (= log_level "ERROR"))

(check-sat)
(get-model)
