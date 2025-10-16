; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Delimiters used: space (), colon (:), dash (-), pipe (|), left bracket ([), right bracket (])
; ; Focus: timestamp format, log level validation, message extraction

(set-logic QF_SLIA)

; Declare the log entry variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-18 14:23:55] | INFO | User logged in
; The fields are:
; - timestamp: [2024-06-18 14:23:55]
; - log level: INFO
; - message: User logged in

; Declare delimiters as string constants
(define-fun delim_space () String " ")
(define-fun delim_colon () String ":")
(define-fun delim_dash () String "-")
(define-fun delim_pipe () String "|")
(define-fun delim_lbracket () String "[")
(define-fun delim_rbracket () String "]")

; ; Extract the timestamp segment (assume it is the first part, between '[' and ']')
; Step 1: Split at '[' delimiter, get segment 1 (index 1): "2024-06-18 14:23:55] | INFO | User logged in"
(define-fun after_lbracket () String (str.split_at log_entry delim_lbracket 1))

; Step 2: Split at ']' delimiter, get segment 0: "2024-06-18 14:23:55"
(define-fun timestamp () String (str.split_at after_lbracket delim_rbracket 0))

; ; Extract the rest after the closing ']' (should start with " | INFO | User logged in")
(define-fun after_rbracket () String (str.split_at after_lbracket delim_rbracket 1))

; Step 3: Split at '|' delimiter to access log level and message
; Segment 0: before first '|', typically a space
; Segment 1: log level (with possible leading/trailing spaces)
; Segment 2: message (possibly with leading space)
(define-fun num_pipe_splits () Int (str.num_splits after_rbracket delim_pipe))

; Get the log level (should be in segment 1)
(define-fun log_level_raw () String (str.split_at after_rbracket delim_pipe 1))

; Remove leading/trailing spaces from log_level_raw
; ; For simplicity, enforce that log_level_raw = " INFO " as in the example
; For more complex trimming, more constraints would be needed

; Get the message (segment 2, possibly with leading space)
(define-fun message_raw () String (str.split_at after_rbracket delim_pipe 2))

; -------------------------
; Satisfiable constraints
; -------------------------

; ; Example of a valid log entry:
; "[2024-06-18 14:23:55] | INFO | User logged in"
(assert (= log_entry "[2024-06-18 14:23:55] | INFO | User logged in"))

; 1. Timestamp format: should have length 19 (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))

; 2. Timestamp should have dashes at correct positions (year-month-day)
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))

; 3. Timestamp should have space between date and time
(assert (= (str.at timestamp 10) " "))

; 4. Timestamp should have colons in time part
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; 5. Log level validation: log_level_raw should be " INFO "
(assert (= log_level_raw " INFO "))

; ; 6. Message extraction: message_raw should be " User logged in"
(assert (= message_raw " User logged in"))

; 7. There should be 3 segments after splitting after_rbracket by '|'
(assert (= num_pipe_splits 3))

; -------------------------
; Unsatisfiable constraints
; -------------------------

; ; Example: log level cannot be "ERROR" in this entry
(assert (not (= log_level_raw " ERROR ")))

; ; Example: timestamp must not have length 10 (which would be too short)
(assert (not (= (str.len timestamp) 10)))

(check-sat)
(exit)
(get-model)
