; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_SLIA)

; ; Example log entry format:
; [2024-06-01 12:34:56] | INFO | Application started

; Declare the log entry variable
(declare-fun log_entry () String)

; ; Extract the timestamp part: between '[' and ']'
; ; Find the index of '[' and ']' and extract the substring between them
; ; Use split_at to extract segments between delimiters

; First split by ']' to get the first segment: "[2024-06-01 12:34:56"
(define-fun seg0 () String (str.split_at log_entry "]" 0))

; Then split seg0 by '[' to get the timestamp as the second segment (after the '[')
(define-fun timestamp () String (str.split_at seg0 "[" 1))

; Validation: timestamp format YYYY-MM-DD HH:MM:SS
; Split timestamp by ' ' to separate date and time
(define-fun date_part () String (str.split_at timestamp " " 0))
(define-fun time_part () String (str.split_at timestamp " " 1))

; Date part: should be in format YYYY-MM-DD
; Split by '-' to get [YYYY, MM, DD]
(define-fun year_part () String (str.split_at date_part "-" 0))
(define-fun month_part () String (str.split_at date_part "-" 1))
(define-fun day_part () String (str.split_at date_part "-" 2))

; Time part: should be in format HH:MM:SS
; Split by ':' to get [HH, MM, SS]
(define-fun hour_part () String (str.split_at time_part ":" 0))
(define-fun minute_part () String (str.split_at time_part ":" 1))
(define-fun second_part () String (str.split_at time_part ":" 2))

; ; Extract the log level: appears after '] | ' and before next ' | '
; First, split log_entry at '|', get the second segment (index 1), which should be ' INFO '
(define-fun log_level_raw () String (str.split_at log_entry "|" 1))

; Trim spaces: split by ' ' and get the first non-empty segment
(define-fun log_level () String (str.split_at log_level_raw " " 1))

; ; Extract the log message: split at '|' and get the segment at index 2, then trim leading space
(define-fun message_raw () String (str.split_at log_entry "|" 2))
(define-fun message () String (str.split_at message_raw " " 1))

; Constraint 1: timestamp is of length 19 ("YYYY-MM-DD HH:MM:SS")
(assert (= (str.len timestamp) 19))

; Constraint 2: year is 4 digits
(assert (= (str.len year_part) 4))

; Constraint 3: month is "06" (June)
(assert (= month_part "06"))

; Constraint 4: day is two digits (e.g., "01")
(assert (= (str.len day_part) 2))

; Constraint 5: log level must be one of "INFO", "WARN", "ERROR"
(assert (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
))

; Constraint 6: message is non-empty
(assert (> (str.len message) 0))

; Satisfiable instance: Provide a concrete log entry matching all constraints
(assert
 (= log_entry "[2024-06-01 12:34:56] | INFO | Application started")
)

(check-sat)



(get-model)
