(set-logic QF_SLIA)
(set-info :source |Log Analysis: Log entry parsing with timestamp and level extraction|)
(set-info :category "industrial")

; Declare string variables for log entries and components
(declare-fun log_entry_1 () String)
(declare-fun log_entry_2 () String)
(declare-fun log_entry_3 () String)
(declare-fun log_entry_4 () String)

; ; Declare variables for extracted components
(declare-fun timestamp_1 () String)
(declare-fun timestamp_2 () String)
(declare-fun log_level_1 () String)
(declare-fun log_level_2 () String)
(declare-fun message_1 () String)
(declare-fun message_2 () String)

; Declare variables for intermediate parsing
(declare-fun date_part () String)
(declare-fun time_part () String)
(declare-fun level_section () String)
(declare-fun remaining_after_level () String)

; Define sample log entries with different formats
; Format: "2024-01-15 10:30:45 [INFO] | User login successful"
(assert (= log_entry_1 "2024-01-15 10:30:45 [INFO] | User login successful"))

; Format: "2024-01-15 14:22:33 [ERROR] | Database connection failed"
(assert (= log_entry_2 "2024-01-15 14:22:33 [ERROR] | Database connection failed"))

; Format: "2024-01-15 09:15:20 [WARN] | Memory usage high"
(assert (= log_entry_3 "2024-01-15 09:15:20 [WARN] | Memory usage high"))

; Invalid format for testing
(assert (= log_entry_4 "Invalid log format without proper structure"))

; ; Extract timestamp from log_entry_1 (first two space-separated parts)
(assert (= date_part (str.split_at log_entry_1 " " 0)))
(assert (= time_part (str.split_at log_entry_1 " " 1)))
(assert (= timestamp_1 (str.++ date_part " " time_part)))

; ; Extract timestamp from log_entry_2
(assert (= timestamp_2 (str.++ (str.split_at log_entry_2 " " 0) " " (str.split_at log_entry_2 " " 1))))

; ; Validate timestamp format for date part (YYYY-MM-DD)
(assert (= (str.len (str.split_at date_part "-" 0)) 4)) ; Year should be 4 digits
(assert (= (str.len (str.split_at date_part "-" 1)) 2)) ; Month should be 2 digits
(assert (= (str.len (str.split_at date_part "-" 2)) 2)) ; Day should be 2 digits
(assert (= (str.num_splits date_part "-") 3)) ; Should have exactly 3 parts

; ; Validate time format (HH:MM:SS)
(assert (= (str.len (str.split_at time_part ":" 0)) 2)) ; Hour should be 2 digits
(assert (= (str.len (str.split_at time_part ":" 1)) 2)) ; Minute should be 2 digits
(assert (= (str.len (str.split_at time_part ":" 2)) 2)) ; Second should be 2 digits
(assert (= (str.num_splits time_part ":") 3)) ; Should have exactly 3 parts

; ; Extract log level from log_entry_1 (between brackets)
(assert (= level_section (str.split_at log_entry_1 " " 2)))
(assert (= log_level_1 (str.split_at (str.split_at level_section "[" 1) "]" 0)))

; ; Extract log level from log_entry_2
(assert (= log_level_2 (str.split_at (str.split_at (str.split_at log_entry_2 " " 2) "[" 1) "]" 0)))

; ; Validate log levels are from accepted set
(assert (or (= log_level_1 "INFO")
 (= log_level_1 "ERROR")
 (= log_level_1 "WARN")
 (= log_level_1 "DEBUG")
 (= log_level_1 "TRACE")))

(assert (or (= log_level_2 "INFO")
 (= log_level_2 "ERROR")
 (= log_level_2 "WARN")
 (= log_level_2 "DEBUG")
 (= log_level_2 "TRACE")))

; ; Extract message part (after the pipe delimiter)
(assert (= message_1 (str.split_rest log_entry_1 "|" 1)))
(assert (= message_2 (str.split_rest log_entry_2 "|" 1)))

; Ensure messages are non-empty after trimming leading space
(assert (not (= (str.split_at message_1 " " 1) "")))
(assert (not (= (str.split_at message_2 " " 1) "")))

; ; Constraint: log_entry_1 should have INFO level
(assert (= log_level_1 "INFO"))

; ; Constraint: log_entry_2 should have ERROR level
(assert (= log_level_2 "ERROR"))

; ; Validate proper log structure - should have at least 4 space-separated parts
(assert (>= (str.num_splits log_entry_1 " ") 4))
(assert (>= (str.num_splits log_entry_2 " ") 4))

; Ensure brackets are properly formatted in level section
(assert (str.contains level_section "["))
(assert (str.contains level_section "]"))
(assert (= (str.num_splits level_section "[") 2))
(assert (= (str.num_splits level_section "]") 2))

; Test case for invalid log format - should fail validation
(assert (< (str.num_splits log_entry_4 " ") 4))

; ; Consistency check: extracted timestamp should match expected format
(assert (str.contains timestamp_1 "2024-01-15"))
(assert (str.contains timestamp_2 "2024-01-15"))

; Message content validation
(assert (str.contains message_1 "User"))
(assert (str.contains message_2 "Database"))

; Cross-validation: different log levels for different entries
(assert (not (= log_level_1 log_level_2)))

; Temporal ordering constraint (time_part comparison through string operations)
(assert (str.prefixof "10:" (str.split_at timestamp_1 " " 1)))
(assert (str.prefixof "14:" (str.split_at timestamp_2 " " 1)))

; Final validation: complete log entry reconstruction possibility
(declare-fun reconstructed_1 () String)
(assert (= reconstructed_1 (str.++ timestamp_1 " [" log_level_1 "] |" message_1)))
(assert (= reconstructed_1 log_entry_1))

(check-sat)
(exit)
(get-model)
