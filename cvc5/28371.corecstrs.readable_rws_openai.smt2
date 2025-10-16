; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Focus on: timestamp format, log level validation, message extraction

(set-logic ALL)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-12 14:23:05] | INFO | System started successfully

; ; Split 1: Extract the part inside brackets (timestamp)
; First, split at ']' to separate '[timestamp' from the rest
(define-fun num_right_bracket_splits () Int (str.num_splits log_entry "]"))
(define-fun before_right_bracket () String (str.split_at log_entry "]" 0))
(define-fun after_right_bracket () String (str.split_rest log_entry "]" 1))

; before_right_bracket is '[2024-06-12 14:23:05'
; Remove the leading '[' by splitting at '['
(define-fun num_left_bracket_splits () Int (str.num_splits before_right_bracket "["))
(define-fun bracket_left () String (str.split_at before_right_bracket "[" 0))
(define-fun timestamp () String (str.split_rest before_right_bracket "[" 1))

; after_right_bracket should be ' | INFO | System started successfully'

; ; Split at '|' to extract log level and message
(define-fun num_pipe_splits () Int (str.num_splits after_right_bracket "|"))
(define-fun pipe_part_0 () String (str.split_at after_right_bracket "|" 0)) ; leading spaces
(define-fun pipe_part_1 () String (str.split_at after_right_bracket "|" 1)) ; log level (with possible spaces)
(define-fun pipe_part_2 () String (str.split_at after_right_bracket "|" 2)) ; message (with possible leading space)
(define-fun message () String (str.split_rest after_right_bracket "|" 2))

; Clean log level: Remove possible leading/trailing spaces
(define-fun log_level_trim_left () String (str.split_rest pipe_part_1 " " 0))
; We further trim right by splitting at ' ' and taking the first nonempty segment
; (For simplicity, assume log level has no spaces inside, e.g., 'INFO', 'ERROR', etc.)
(define-fun log_level () String (str.split_at log_level_trim_left " " 0))

;-------------------------------
; Constraints on timestamp format
;-------------------------------

; timestamp should be of the form 'YYYY-MM-DD HH:MM:SS'
; Let's enforce length and structure via splits

; Split timestamp at ' ' to get date and time parts
(define-fun num_space_in_timestamp () Int (str.num_splits timestamp " "))
(define-fun date_part () String (str.split_at timestamp " " 0))
(define-fun time_part () String (str.split_rest timestamp " " 1))

; Date format: 'YYYY-MM-DD'
; Split date_part at '-'
(define-fun num_dash_in_date () Int (str.num_splits date_part "-"))
(define-fun year_part () String (str.split_at date_part "-" 0))
(define-fun month_part () String (str.split_at date_part "-" 1))
(define-fun day_part () String (str.split_rest date_part "-" 2))

; Time format: 'HH:MM:SS'
(define-fun num_colon_in_time () Int (str.num_splits time_part ":"))
(define-fun hour_part () String (str.split_at time_part ":" 0))
(define-fun minute_part () String (str.split_at time_part ":" 1))
(define-fun second_part () String (str.split_rest time_part ":" 2))

;-------------------------------
; Log level validation
;-------------------------------
; Valid log levels: "INFO", "ERROR", "WARN", "DEBUG"

(define-fun is_valid_log_level () Bool
 (or
 (= log_level "INFO")
 (= log_level "ERROR")
 (= log_level "WARN")
 (= log_level "DEBUG")
)
)

;-------------------------------
; Satisfiable constraint scenario
;-------------------------------

; ; Example: A correct log entry
(assert (= log_entry "[2024-06-12 14:23:05] | INFO | System started successfully"))

; Enforce timestamp split structure: exactly 2 parts with ' ' in between
(assert (= num_space_in_timestamp 2))
; Date split: exactly 3 parts with '-'
(assert (= num_dash_in_date 3))
; Time split: exactly 3 parts with ':'
(assert (= num_colon_in_time 3))

; ; Enforce year, month, day numeric string lengths (simplified to length checking)
(assert (= (str.len year_part) 4))
(assert (= (str.len month_part) 2))
(assert (= (str.len day_part) 2))
(assert (= (str.len hour_part) 2))
(assert (= (str.len minute_part) 2))
(assert (= (str.len second_part) 2))

; Enforce log level validity
(assert is_valid_log_level)

;-------------------------------
; Unsatisfiable constraint scenario
;-------------------------------
; ; For demonstration, let's add an unsatisfiable constraint: require log_level to be both "INFO" and "ERROR"

(assert (not (= log_level "ERROR")))

;-------------------------------
; ; Message extraction properties
;-------------------------------
; The message should not be empty
(assert (> (str.len message) 0))

(check-sat)
(exit)
(get-model)
