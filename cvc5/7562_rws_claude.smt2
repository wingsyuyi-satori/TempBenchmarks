(set-info :source |
; Log Analysis: Log entry parsing with timestamp and level extraction
 Generated for SMT solver constraint solving
|)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")
(set-info :status unknown)
(set-logic QF_SLIA)

; Declare string variables for log entries and components
(declare-fun log_entry () String)
(declare-fun timestamp_part () String)
(declare-fun log_level () String)
(declare-fun message_content () String)
(declare-fun date_component () String)
(declare-fun time_component () String)
(declare-fun level_bracket_content () String)

; Declare auxiliary variables for parsing
(declare-fun temp_after_date () String)
(declare-fun temp_after_time () String)
(declare-fun temp_after_level () String)

; Sample log entry format: "2024-01-15 14:30:25 [INFO] User authentication successful"
(assert (= log_entry "2024-01-15 14:30:25 [INFO] User authentication successful"))

; ; Extract date component (first part before space)
(assert (= date_component (str.split_at log_entry " " 0)))

; ; Extract time component (second part after first space)
(assert (= time_component (str.split_at log_entry " " 1)))

; ; Validate date format: YYYY-MM-DD
(assert (= (str.len date_component) 10))
(assert (= (str.split_at date_component "-" 0) "2024"))
(assert (= (str.split_at date_component "-" 1) "01"))
(assert (= (str.split_at date_component "-" 2) "15"))
(assert (= (str.num_splits date_component "-") 3))

; ; Validate time format: HH:MM:SS
(assert (= (str.len time_component) 8))
(assert (= (str.split_at time_component ":" 0) "14"))
(assert (= (str.split_at time_component ":" 1) "30"))
(assert (= (str.split_at time_component ":" 2) "25"))
(assert (= (str.num_splits time_component ":") 3))

; Combine timestamp parts
(assert (= timestamp_part (str.++ date_component " " time_component)))

; ; Extract log level (third part, should be in brackets)
(assert (= level_bracket_content (str.split_at log_entry " " 2)))

; ; Validate log level format: [LEVEL]
(assert (str.prefixof "[" level_bracket_content))
(assert (str.suffixof "]" level_bracket_content))
(assert (= (str.len level_bracket_content) 6))

; ; Extract actual level by removing brackets
(assert (= log_level (str.split_at level_bracket_content "]" 0)))
(assert (= log_level "[INFO"))

; ; Validate log level is one of standard levels
(assert (or (= log_level "[INFO")
 (= log_level "[WARN")
 (= log_level "[ERROR")
 (= log_level "[DEBUG")))

; ; Extract message content (everything after log level)
(assert (= message_content (str.split_rest log_entry " " 3)))
(assert (= message_content "User authentication successful"))

; Additional log entry for testing different scenarios
(declare-fun log_entry2 () String)
(declare-fun timestamp2 () String)
(declare-fun level2 () String)
(declare-fun message2 () String)

(assert (= log_entry2 "2024-01-15 09:15:42 [ERROR] Database connection failed"))

; Parse second log entry
(assert (= timestamp2 (str.++ (str.split_at log_entry2 " " 0) " " (str.split_at log_entry2 " " 1))))
(assert (= level2 (str.split_at log_entry2 " " 2)))
(assert (= message2 (str.split_rest log_entry2 " " 3)))

; ; Validate second entry timestamp format
(assert (= (str.num_splits (str.split_at log_entry2 " " 0) "-") 3))
(assert (= (str.num_splits (str.split_at log_entry2 " " 1) ":") 3))

; ; Validate second entry log level
(assert (str.prefixof "[" level2))
(assert (str.suffixof "]" level2))
(assert (= level2 "[ERROR]"))

; ; Complex constraint: Parse log with pipe delimiter for additional metadata
(declare-fun complex_log () String)
(declare-fun main_part () String)
(declare-fun metadata_part () String)

(assert (= complex_log "2024-01-15 16:45:30 [WARN] Memory usage high | thread:worker-1 | user:admin"))

; Split by pipe to separate main log from metadata
(assert (= main_part (str.split_at complex_log "|" 0)))
(assert (= metadata_part (str.split_rest complex_log "|" 1)))

; ; Validate main part follows standard format
(assert (= (str.num_splits main_part " ") 4))
(assert (str.contains main_part "[WARN]"))

; Parse metadata components
(assert (str.contains metadata_part "thread:"))
(assert (str.contains metadata_part "user:"))

; Constraint for malformed log detection
(declare-fun malformed_log () String)
(declare-fun is_valid_format () Bool)

(assert (= malformed_log "Invalid log without proper timestamp"))

; ; Check if log has minimum required components
(assert (= is_valid_format 
 (and (>= (str.num_splits malformed_log " ") 3)
 (str.contains malformed_log "[")
 (str.contains malformed_log "]"))))

; This should be false for malformed log
(assert (not is_valid_format))

; Timestamp range validation
(declare-fun hour_str () String)
(declare-fun minute_str () String)
(declare-fun is_valid_time () Bool)

(assert (= hour_str (str.split_at time_component ":" 0)))
(assert (= minute_str (str.split_at time_component ":" 1)))

; Logical constraints for time validation (simplified)
(assert (= is_valid_time 
 (and (>= (str.len hour_str) 1)
 (<= (str.len hour_str) 2)
 (>= (str.len minute_str) 1)
 (<= (str.len minute_str) 2))))

(assert is_valid_time)

; Multi-line log entry handling
(declare-fun multiline_log () String)
(declare-fun first_line () String)
(declare-fun continuation () String)

(assert (= multiline_log "2024-01-15 11:20:33 [DEBUG] Stack trace:"))
(assert (= first_line (str.split_at multiline_log ":" 0)))
(assert (= continuation (str.split_rest multiline_log ":" 1)))

; Ensure first line has proper log structure
(assert (str.contains first_line "[DEBUG]"))
(assert (= (str.num_splits first_line " ") 3))

(check-sat)
(get-model)
