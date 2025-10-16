; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters: ' ', ':', '-', '|', '[', ']'
; ; Focus: timestamp format, log level validation, message extraction

(set-logic ALL)

; Declare the log entry variable
(declare-fun log_entry () String)

; ; Example log entry structure (for reference):
; "[2024-06-03 13:45:12] INFO | User login succeeded"

; Declare delimiters as string constants
(define-fun delim_space () String " ")
(define-fun delim_colon () String ":")
(define-fun delim_dash () String "-")
(define-fun delim_pipe () String "|")
(define-fun delim_lbrack () String "[")
(define-fun delim_rbrack () String "]")

; ; Extract the timestamp (between '[' and ']')
; First, split by '[' to get the part after the first '['
(define-fun segment_after_lbrack () String (str.split_at log_entry delim_lbrack 1))

; The segment_after_lbrack should start with the timestamp
; The timestamp is up to the first ']'
(define-fun timestamp_and_rest () String (str.split_at segment_after_lbrack delim_rbrack 0))
(define-fun after_rbrack () String (str.split_at segment_after_lbrack delim_rbrack 1))

; The timestamp should be of the form: yyyy-mm-dd hh:mm:ss
; ; Extract yyyy, mm, dd, hh, mm, ss by splitting appropriately

; Split timestamp_and_rest by space to get date and time
(define-fun date_part () String (str.split_at timestamp_and_rest delim_space 0))
(define-fun time_part () String (str.split_at timestamp_and_rest delim_space 1))

; Split date_part by '-' to get yyyy, mm, dd
(define-fun year_part () String (str.split_at date_part delim_dash 0))
(define-fun month_part () String (str.split_at date_part delim_dash 1))
(define-fun day_part () String (str.split_at date_part delim_dash 2))

; Split time_part by ':' to get hh, mm, ss
(define-fun hour_part () String (str.split_at time_part delim_colon 0))
(define-fun minute_part () String (str.split_at time_part delim_colon 1))
(define-fun second_part () String (str.split_at time_part delim_colon 2))

; ; Extract the log level (after '] ')
; after_rbrack starts with space, then log level, then space, then '|'
; Remove leading space
(define-fun after_rbrack_trimmed () String
 (ite (str.prefixof delim_space after_rbrack)
 (str.substr after_rbrack 1 (- (str.len after_rbrack) 1))
 after_rbrack)
)

; Log level is before first space or '|'
(define-fun log_level () String (str.split_at after_rbrack_trimmed delim_space 0))

; ; Extract the message (after '| ')
; Find the segment after the first '|'
(define-fun after_pipe () String (str.split_at log_entry delim_pipe 1))
; Remove leading space
(define-fun message () String
 (ite (str.prefixof delim_space after_pipe)
 (str.substr after_pipe 1 (- (str.len after_pipe) 1))
 after_pipe)
)

; --- Constraints for satisfiable scenario ---

; Constraint 1: Timestamp format
(assert (= (str.len year_part) 4))
(assert (= (str.len month_part) 2))
(assert (= (str.len day_part) 2))
(assert (= (str.len hour_part) 2))
(assert (= (str.len minute_part) 2))
(assert (= (str.len second_part) 2))

; Constraint 2: Log level must be one of a set
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") (= log_level "DEBUG")))

; Constraint 3: Message must not be empty
(assert (> (str.len message) 0))

; ; Example concrete value makes constraints SAT
(assert (= log_entry "[2024-06-03 13:45:12] INFO | User login succeeded"))

(check-sat)







(exit)
(get-model)
