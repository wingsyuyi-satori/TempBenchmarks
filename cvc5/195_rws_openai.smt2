; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: ' ', ':', '-', '|', '[', ']'
; ; Constraints focus on: timestamp format, log level validation, message extraction

(set-logic ALL)
(set-option :produce-models true)

; Declare the log entry string
(declare-fun log_entry () String)

; ; Example: "2024-06-22 15:47:03 | [INFO] Application started"

; ; Split log_entry at first space to extract date and the rest
(define-fun date_part () String (str.split_at log_entry " " 0))
(define-fun after_date () String (str.split_rest log_entry " " 1))

; ; Split after_date at first space to extract time and the rest
(define-fun time_part () String (str.split_at after_date " " 0))
(define-fun after_time () String (str.split_rest after_date " " 1))

; ; Split after_time at first '|' to extract separator and the rest (skip leading space)
(define-fun after_time_trimmed () String
 (ite (str.prefixof " " after_time)
 (str.substr after_time 1 (- (str.len after_time) 1))
 after_time))
(define-fun separator () String (str.split_at after_time_trimmed "|" 0))
(define-fun after_separator () String (str.split_rest after_time_trimmed "|" 1))

; ; Split after_separator at first '[' to extract (should be empty) and the rest
(define-fun after_lbrack () String (str.split_rest after_separator "[" 1))

; The log level is between '[' and ']'
(define-fun log_level_with_rbrack () String (str.split_at after_lbrack "]" 0))
(define-fun after_rbrack () String (str.split_rest after_lbrack "]" 1))

; Trim leading space from after_rbrack if present
(define-fun after_rbrack_trimmed () String
 (ite (str.prefixof " " after_rbrack)
 (str.substr after_rbrack 1 (- (str.len after_rbrack) 1))
 after_rbrack))

; Message is the rest of the string after log level
(define-fun log_message () String after_rbrack_trimmed)

; Constraint 1: Timestamp format must be 'YYYY-MM-DD HH:MM:SS'
; ; We'll check that date_part has 2 '-' and time_part has 2 ':'
(define-fun num_dash_in_date () Int (str.num_splits date_part "-"))
(define-fun num_colon_in_time () Int (str.num_splits time_part ":"))

; Constraint 2: Log level is one of ["INFO", "WARN", "ERROR", "DEBUG"]
; log_level_with_rbrack should be exactly one of those

; Constraint 3: Message is non-empty
(assert (> (str.len log_message) 0))

; Satisfiable constraints for a well-formed log entry
(assert (= num_dash_in_date 3)) ; 2 dashes means 3 segments
(assert (= num_colon_in_time 3)) ; 2 colons means 3 segments
(assert (or
 (= log_level_with_rbrack "INFO")
 (= log_level_with_rbrack "WARN")
 (= log_level_with_rbrack "ERROR")
 (= log_level_with_rbrack "DEBUG")
))

; ; Example: enforce a concrete message for demonstration
(assert (= log_message "Application started"))

; ; Provide an example log entry that satisfies all constraints
(assert (= log_entry "2024-06-22 15:47:03 | [INFO] Application started"))

; ; Now, unsatisfiable constraint: log level is not valid
(declare-fun log_entry_badlevel () String)

; Re-parse variables for the bad log entry
(define-fun bad_date_part () String (str.split_at log_entry_badlevel " " 0))
(define-fun bad_after_date () String (str.split_rest log_entry_badlevel " " 1))
(define-fun bad_time_part () String (str.split_at bad_after_date " " 0))
(define-fun bad_after_time () String (str.split_rest bad_after_date " " 1))
(define-fun bad_after_time_trimmed () String
 (ite (str.prefixof " " bad_after_time)
 (str.substr bad_after_time 1 (- (str.len bad_after_time) 1))
 bad_after_time))
(define-fun bad_separator () String (str.split_at bad_after_time_trimmed "|" 0))
(define-fun bad_after_separator () String (str.split_rest bad_after_time_trimmed "|" 1))
(define-fun bad_after_lbrack () String (str.split_rest bad_after_separator "[" 1))
(define-fun bad_log_level_with_rbrack () String (str.split_at bad_after_lbrack "]" 0))
(define-fun bad_after_rbrack () String (str.split_rest bad_after_lbrack "]" 1))
(define-fun bad_after_rbrack_trimmed () String
 (ite (str.prefixof " " bad_after_rbrack)
 (str.substr bad_after_rbrack 1 (- (str.len bad_after_rbrack) 1))
 bad_after_rbrack))
(define-fun bad_log_message () String bad_after_rbrack_trimmed)
(define-fun bad_num_dash_in_date () Int (str.num_splits bad_date_part "-"))
(define-fun bad_num_colon_in_time () Int (str.num_splits bad_time_part ":"))

; All constraints as before, but require log level is NOT one of the allowed
(assert (= bad_num_dash_in_date 3))
(assert (= bad_num_colon_in_time 3))
(assert (not (or
 (= bad_log_level_with_rbrack "INFO")
 (= bad_log_level_with_rbrack "WARN")
 (= bad_log_level_with_rbrack "ERROR")
 (= bad_log_level_with_rbrack "DEBUG")
)))
; Provide a concrete log entry with invalid log level
(assert (= log_entry_badlevel "2024-06-22 15:47:03 | [TRACE] Something happened"))

; ; Satisfiable check for good log entry
(check-sat)


(exit)
(get-model)
