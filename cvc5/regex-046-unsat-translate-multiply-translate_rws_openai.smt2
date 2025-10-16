; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic ALL)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Example log entry structure:
; [2023-06-15 13:45:22] | INFO | System started successfully

; ; Step 1: Extract the timestamp (between '[' and ']')
(declare-fun left_bracket_idx () Int)
(declare-fun right_bracket_idx () Int)
; Find the position of '[' and ']'
(assert (= left_bracket_idx (str.indexof log_entry "[" 0)))
(assert (= right_bracket_idx (str.indexof log_entry "]" 0)))

; ; Extract the timestamp substring using split_at
; The substring between [ and ] is at index 1 after splitting at '[',
; and then index 0 after splitting at ']'
(declare-fun after_left_bracket () String)
(assert (= after_left_bracket (str.split_at log_entry "[" 1)))
(declare-fun timestamp () String)
(assert (= timestamp (str.split_at after_left_bracket "]" 0)))

; ; Step 2: Extract the log level (between '| ' and ' |')
; After the first '|' (which follows ']'), the log level is the next segment
; Split at '|' and trim spaces
(declare-fun after_first_pipe () String)
(assert (= after_first_pipe (str.split_at log_entry "|" 1)))
; after_first_pipe starts with " INFO ", so split at spaces
(declare-fun log_level_with_space () String)
(assert (= log_level_with_space (str.split_at after_first_pipe " " 1)))
; log_level is the first non-empty segment after splitting at spaces
(declare-fun log_level () String)
(assert (= log_level (str.split_at log_level_with_space " " 0)))

; ; Step 3: Extract the message (after the second '|')
; The message is after the second pipe character
(declare-fun message_with_space () String)
(assert (= message_with_space (str.split_at log_entry "|" 2)))
; Remove leading space
(declare-fun message () String)
(assert (= message (str.replace message_with_space " " "")))

; Timestamp format validation: "YYYY-MM-DD HH:MM:SS"
; Split timestamp at space to separate date and time
(declare-fun date_part () String)
(assert (= date_part (str.split_at timestamp " " 0)))
(declare-fun time_part () String)
(assert (= time_part (str.split_at timestamp " " 1)))

; Date part: split at '-'
(declare-fun year () String)
(assert (= year (str.split_at date_part "-" 0)))
(declare-fun month () String)
(assert (= month (str.split_at date_part "-" 1)))
(declare-fun day () String)
(assert (= day (str.split_at date_part "-" 2)))

; Time part: split at ':'
(declare-fun hour () String)
(assert (= hour (str.split_at time_part ":" 0)))
(declare-fun minute () String)
(assert (= minute (str.split_at time_part ":" 1)))
(declare-fun second () String)
(assert (= second (str.split_at time_part ":" 2)))

; Log level validation: should be one of INFO, WARN, ERROR, DEBUG
(define-fun valid_log_level () Bool
 (or (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG"))
)

; ; Message extraction: message should be non-empty
(assert (not (= message "")))

; ; Example Satisfiable Case
(assert (= log_entry "[2023-06-15 13:45:22] | INFO | System started successfully"))

; ; Check that extracted fields match expected values
(assert (= timestamp "2023-06-15 13:45:22"))
(assert (= log_level "INFO"))
(assert (= message "System started successfully"))
(assert valid_log_level)
; ; Check that year, month, day, hour, minute, second are all of correct length
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

(check-sat)








(get-model)
