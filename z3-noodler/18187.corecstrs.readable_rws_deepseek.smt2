; ; Complete SMT-LIB2 file for log analysis with timestamp and level extraction
; ; This example models parsing of log entries with format: [TIMESTAMP] LEVEL: MESSAGE
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const space String)
(assert (= space " "))

(declare-const colon String)
(assert (= colon ":"))

(declare-const dash String)
(assert (= dash "-"))

(declare-const pipe String)
(assert (= pipe "|"))

(declare-const open_bracket String)
(assert (= open_bracket "["))

(declare-const close_bracket String)
(assert (= close_bracket "]"))

; Declare variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log entry: "[2023-01-15 14:30:45] ERROR: Database connection failed"
(assert (= log_entry "[2023-01-15 14:30:45] ERROR: Database connection failed"))

; ; Extract timestamp (between brackets)
(assert (= timestamp (str.split_at (str.split_at log_entry open_bracket 1) close_bracket 0)))

; ; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
; Split date and time components
(declare-const date_part String)
(declare-const time_part String)
(assert (= date_part (str.split_at timestamp space 0)))
(assert (= time_part (str.split_at timestamp space 1)))

; ; Validate date format (YYYY-MM-DD)
(assert (= (str.split_at date_part dash 0) "2023")) ; year
(assert (= (str.split_at date_part dash 1) "01")) ; month
(assert (= (str.split_at date_part dash 2) "15")) ; day

; ; Validate time format (HH:MM:SS)
(assert (= (str.split_at time_part colon 0) "14")) ; hour
(assert (= (str.split_at time_part colon 1) "30")) ; minute
(assert (= (str.split_at time_part colon 2) "45")) ; second

; ; Extract log level (after closing bracket, before colon)
(declare-const level_part String)
(assert (= level_part (str.split_at (str.split_rest log_entry close_bracket 1) colon 0)))
(assert (= log_level (str.replace_all level_part space "")))

; ; Validate log level is one of standard values
(assert (or (= log_level "ERROR") 
 (= log_level "WARN") 
 (= log_level "INFO") 
 (= log_level "DEBUG")))

; ; Extract message (after level colon)
(assert (= message (str.split_rest (str.split_rest log_entry close_bracket 1) colon 1)))

; Additional constraints for unsatisfiable case
(declare-const invalid_log_entry String)
(assert (= invalid_log_entry "[2023-13-32 25:61:61] CRITICAL: Invalid timestamp"))
(assert (not (= (str.split_at (str.split_at invalid_log_entry open_bracket 1) close_bracket 0) "2023-13-32 25:61:61")))

; ; Check satisfiability of constraints
(check-sat)
(get-model)
