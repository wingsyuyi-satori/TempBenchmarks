; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: " ", ":", "-", "|", "[", "]"
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_SLIA)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Extract the bracketed timestamp: text between '[' and ']'
; First, split at "[" to get after-bracket
(declare-fun after_open_bracket () String)
(assert (= after_open_bracket (str.split_at log_entry "[" 1)))

; The timestamp is then up to the first "]"
(declare-fun timestamp () String)
(assert (= timestamp (str.split_at after_open_bracket "]" 0)))

; The part after the closing timestamp bracket
(declare-fun after_timestamp_bracket () String)
(assert (= after_timestamp_bracket (str.split_at after_open_bracket "]" 1)))

; After the timestamp, split by "|" to get log level and message
; after_timestamp_bracket is expected to begin with " | LEVEL | message"

; Get the number of splits by "|" (should be at least 3 if the format is correct)
(declare-fun num_pipes () Int)
(assert (= num_pipes (str.num_splits after_timestamp_bracket "|")))

; The log level is the first segment after the first "|"
(declare-fun level_segment () String)
(assert (= level_segment (str.split_at after_timestamp_bracket "|" 1)))

; Remove leading/trailing spaces from log level segment
(declare-fun log_level () String)

; The message is the segment after the second "|"
(declare-fun message_segment () String)
(assert (= message_segment (str.split_at after_timestamp_bracket "|" 2)))

; Remove leading/trailing spaces from message segment
(declare-fun message () String)

; Split the timestamp into date and time at the first space
(declare-fun date_part () String)
(declare-fun time_part () String)
(assert (= date_part (str.split_at timestamp " " 0)))
(assert (= time_part (str.split_at timestamp " " 1)))

; Split the date_part at "-" to get year, month, day
(declare-fun year () String)
(declare-fun month () String)
(declare-fun day () String)
(assert (= year (str.split_at date_part "-" 0)))
(assert (= month (str.split_at date_part "-" 1)))
(assert (= day (str.split_at date_part "-" 2)))

; Split the time_part at ":" to get hour, minute, second
(declare-fun hour () String)
(declare-fun minute () String)
(declare-fun second () String)
(assert (= hour (str.split_at time_part ":" 0)))
(assert (= minute (str.split_at time_part ":" 1)))
(assert (= second (str.split_at time_part ":" 2)))

; Timestamp format constraints: components must have correct lengths
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level must be one of the allowed levels
(assert (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
))

; Message must not be empty
(assert (> (str.len message) 0))

; ; Satisfiable example: valid log entry
(assert (= log_entry "[2024-06-13 14:23:55] | INFO | Application started successfully"))

; ; Unsatisfiable example: uncomment below to make log level invalid
; (assert (= log_entry "[2024-06-13 14:23:55] | FATAL | Application crashed"))

(check-sat)
(get-model)
