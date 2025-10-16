(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |Log Analysis: Log entry parsing with timestamp and level extraction|)
(set-info :category "industrial")
(set-info :status unknown)

; Variable declarations for log entry components
(declare-fun log_entry () String)
(declare-fun timestamp_part () String)
(declare-fun log_level () String)
(declare-fun message_content () String)
(declare-fun date_component () String)
(declare-fun time_component () String)
(declare-fun hour_part () String)
(declare-fun minute_part () String)
(declare-fun second_part () String)

; Log entry format: "2024-01-15 14:30:25 [INFO] | User login successful"
(assert (= log_entry "2024-01-15 14:30:25 [INFO] | User login successful"))

; ; Extract timestamp part (first segment before space)
(assert (= timestamp_part (str.split_at log_entry " " 0)))

; ; Extract time portion (second segment after space)
(assert (= time_component (str.split_at log_entry " " 1)))

; ; Extract log level with brackets (third segment after space)
(assert (= (str.split_at log_entry " " 2) (str.++ "[" log_level "]")))

; ; Extract message content after pipe delimiter
(assert (= message_content (str.split_at log_entry "| " 1)))

; Timestamp format validation: date should be in YYYY-MM-DD format
(assert (= (str.num_splits timestamp_part "-") 3))
(assert (= date_component timestamp_part))

; ; Extract date components using hyphen delimiter
(assert (= (str.len (str.split_at date_component "-" 0)) 4)) ; Year length
(assert (= (str.len (str.split_at date_component "-" 1)) 2)) ; Month length
(assert (= (str.len (str.split_at date_component "-" 2)) 2)) ; Day length

; Time format validation: should be in HH:MM:SS format
(assert (= (str.num_splits time_component ":") 3))
(assert (= hour_part (str.split_at time_component ":" 0)))
(assert (= minute_part (str.split_at time_component ":" 1)))
(assert (= second_part (str.split_at time_component ":" 2)))

; Time component length validation
(assert (= (str.len hour_part) 2))
(assert (= (str.len minute_part) 2))
(assert (= (str.len second_part) 2))

; Log level validation: must be one of the standard levels
(assert (or (= log_level "DEBUG")
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "FATAL")))

; ; Log level extraction from bracketed format
(assert (= (str.split_at (str.split_at log_entry "[" 1) "]" 0) log_level))

; ; Message extraction validation
(assert (str.prefixof "User" message_content))
(assert (> (str.len message_content) 5))

; Additional log entry parsing constraints
(declare-fun error_log () String)
(declare-fun error_level () String)
(declare-fun error_timestamp () String)
(declare-fun error_message () String)

; Error log format validation
(assert (= error_log "2024-01-15 09:45:12 [ERROR] | Database connection failed"))
(assert (= error_timestamp (str.split_at error_log " " 0)))
(assert (= (str.split_at error_log " " 1) "09:45:12"))

; ; Extract error level without brackets
(assert (= error_level (str.split_at (str.split_at error_log "[" 1) "]" 0)))
(assert (= error_level "ERROR"))

; ; Error message extraction after pipe
(assert (= error_message (str.split_at error_log "| " 1)))
(assert (str.contains error_message "Database"))

; Complex log parsing with multiple delimiters
(declare-fun complex_log () String)
(declare-fun app_name () String)
(declare-fun thread_id () String)

(assert (= complex_log "2024-01-15 16:22:33 [WARN] AppServer-Thread-5 | Cache miss for key user:12345"))

; ; Extract application thread information
(assert (= (str.num_splits complex_log " ") 5))
(assert (= thread_id (str.split_at complex_log " " 3)))
(assert (str.contains thread_id "Thread"))

; ; Validate thread ID format
(assert (= (str.num_splits thread_id "-") 3))
(assert (= app_name (str.split_at thread_id "-" 0)))
(assert (= app_name "AppServer"))

; Message parsing for cache operations
(declare-fun cache_message () String)
(declare-fun cache_key () String)

(assert (= cache_message (str.split_at complex_log "| " 1)))
(assert (str.contains cache_message "Cache miss"))
(assert (= cache_key (str.split_at cache_message ":" 1)))

; Multi-line log entry handling
(declare-fun multiline_log () String)
(declare-fun stack_trace () String)

(assert (= multiline_log "2024-01-15 11:15:00 [ERROR] | Exception occurred"))
(assert (= (str.num_splits multiline_log "|") 2))
(assert (= stack_trace (str.split_rest multiline_log "| " 1)))

; Log aggregation constraints
(declare-fun log_count () Int)
(declare-fun info_logs () String)
(declare-fun combined_logs () String)

; Count log entries by level
(assert (= combined_logs "INFO|WARN|ERROR|INFO|DEBUG"))
(assert (= log_count (str.num_splits combined_logs "|")))
(assert (= log_count 5))

; Filter INFO level logs
(assert (str.contains combined_logs "INFO"))
(assert (= (str.split_at combined_logs "|" 0) "INFO"))
(assert (= (str.split_at combined_logs "|" 3) "INFO"))

; Timestamp range validation
(declare-fun start_time () String)
(declare-fun end_time () String)
(declare-fun log_time_range () String)

(assert (= log_time_range "14:30:25-16:45:30"))
(assert (= start_time (str.split_at log_time_range "-" 0)))
(assert (= end_time (str.split_at log_time_range "-" 1)))

; Time comparison constraints
(assert (= (str.num_splits start_time ":") 3))
(assert (= (str.num_splits end_time ":") 3))

; ; Structured log field extraction
(declare-fun structured_log () String)
(declare-fun user_id () String)
(declare-fun action_type () String)

(assert (= structured_log "2024-01-15 13:20:15 [INFO] | user_id:12345 action:login status:success"))
(assert (= user_id (str.split_at (str.split_at structured_log "user_id:" 1) " " 0)))
(assert (= action_type (str.split_at (str.split_at structured_log "action:" 1) " " 0)))

; ; Validate extracted values
(assert (= user_id "12345"))
(assert (= action_type "login"))

(check-sat)
(get-model)
