(set-info :status unknown)
(set-logic QF_SLIA)

; ; Log Analysis: Log entry parsing with timestamp and level extraction
; This SMT-LIB2 file models constraints for parsing log entries with various delimiters
; ; Focus areas: timestamp format, log level validation, message extraction

; Declare string variables for log entry components
(declare-fun log_entry () String)
(declare-fun timestamp_part () String)
(declare-fun log_level () String)
(declare-fun message_content () String)
(declare-fun date_component () String)
(declare-fun time_component () String)
(declare-fun hour_part () String)
(declare-fun minute_part () String)
(declare-fun second_part () String)

; Declare integer variables for split operations
(declare-fun num_space_splits () Int)
(declare-fun num_colon_splits () Int)
(declare-fun num_dash_splits () Int)
(declare-fun num_bracket_splits () Int)

; Sample log entry format: "2023-12-15 14:30:25 [INFO] | Database connection established"
(assert (= log_entry "2023-12-15 14:30:25 [INFO] | Database connection established"))

; ; Extract timestamp part (first two space-separated segments)
(assert (= timestamp_part (str.++ (str.split_at log_entry " " 0) " " (str.split_at log_entry " " 1))))

; ; Extract date component from timestamp
(assert (= date_component (str.split_at timestamp_part " " 0)))

; ; Extract time component from timestamp
(assert (= time_component (str.split_at timestamp_part " " 1)))

; ; Validate date format: YYYY-MM-DD (should have exactly 2 dashes)
(assert (= (str.num_splits date_component "-") 3))

; ; Validate time format: HH:MM:SS (should have exactly 2 colons)
(assert (= (str.num_splits time_component ":") 3))

; ; Extract hour, minute, second from time component
(assert (= hour_part (str.split_at time_component ":" 0)))
(assert (= minute_part (str.split_at time_component ":" 1)))
(assert (= second_part (str.split_at time_component ":" 2)))

; ; Validate hour format (should be 2 digits)
(assert (= (str.len hour_part) 2))

; ; Validate minute format (should be 2 digits)
(assert (= (str.len minute_part) 2))

; ; Validate second format (should be 2 digits)
(assert (= (str.len second_part) 2))

; ; Extract log level using bracket delimiters
(assert (= num_bracket_splits (str.num_splits log_entry "[")))
(assert (>= num_bracket_splits 2))

; Log level should be between brackets
(assert (= log_level (str.split_at (str.split_at log_entry "[" 1) "]" 0)))

; ; Validate log level is one of standard levels
(assert (or (= log_level "DEBUG")
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "FATAL")))

; ; Extract message content after pipe delimiter
(assert (= message_content (str.split_rest log_entry "|" 1)))

; Message should not be empty after trimming
(assert (> (str.len message_content) 1))

; Count space splits for overall structure validation
(assert (= num_space_splits (str.num_splits log_entry " ")))
(assert (>= num_space_splits 4))

; ; Additional constraint: timestamp should come before log level
(assert (str.prefixof timestamp_part log_entry))

; ; Constraint: log level section should contain brackets
(assert (str.contains log_entry "["))
(assert (str.contains log_entry "]"))

; ; Constraint: pipe delimiter should separate level from message
(assert (str.contains log_entry "|"))

; Test case 2: Different log format
(declare-fun log_entry2 () String)
(declare-fun level2 () String)
(declare-fun timestamp2 () String)

(assert (= log_entry2 "2023-11-20 09:15:42 [ERROR] | Failed to connect to database"))

; ; Extract components from second log entry
(assert (= timestamp2 (str.++ (str.split_at log_entry2 " " 0) " " (str.split_at log_entry2 " " 1))))
(assert (= level2 (str.split_at (str.split_at log_entry2 "[" 1) "]" 0)))

; ; Validate second entry follows same format
(assert (= (str.num_splits timestamp2 " ") 2))
(assert (= level2 "ERROR"))

; Test case 3: Edge case with multiple pipes
(declare-fun log_entry3 () String)
(declare-fun message3 () String)

(assert (= log_entry3 "2023-10-05 16:45:30 [WARN] | User | admin | performed unauthorized action"))

; ; Message extraction should handle multiple pipes correctly
(assert (= message3 (str.split_rest log_entry3 "|" 1)))
(assert (str.contains message3 "|"))

; ; Constraint: ensure proper parsing of complex messages
(assert (= (str.num_splits log_entry3 "|") 4))

; Test case 4: Malformed entry validation
(declare-fun bad_log () String)
(declare-fun bad_level () String)

(assert (= bad_log "2023-13-45 25:70:90 [INVALID] | Bad timestamp"))

; ; Extract components that should fail validation
(declare-fun bad_date () String)
(declare-fun bad_time () String)

(assert (= bad_date (str.split_at bad_log " " 0)))
(assert (= bad_time (str.split_at bad_log " " 1)))
(assert (= bad_level (str.split_at (str.split_at bad_log "[" 1) "]" 0)))

; This should make the constraints unsatisfiable due to invalid log level
(assert (or (= bad_level "DEBUG")
 (= bad_level "INFO")
 (= bad_level "WARN")
 (= bad_level "ERROR")
 (= bad_level "FATAL")))

; Additional structural constraints
(assert (= (str.num_splits bad_log " ") (str.num_splits log_entry " ")))

; Ensure consistent delimiter usage across all log entries
(declare-fun delimiter_consistency () Int)
(assert (= delimiter_consistency (+ (str.num_splits log_entry " ")
 (str.num_splits log_entry2 " ")
 (str.num_splits log_entry3 " "))))
(assert (>= delimiter_consistency 12))

(check-sat)
(exit)
(get-model)
