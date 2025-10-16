; ; SMT-LIB2 file for Log Analysis: Log entry parsing with timestamp and level extraction
; Split operations: str.split_at, str.num_splits, str.split_rest
; Delimiters: " ", ":", "-", "|", "[", "]"
; ; Focus: timestamp format, log level validation, message extraction

(set-logic ALL)
(set-option :produce-models true)

; Declare the log entry string variable
(declare-fun log_entry () String)

; ; Example log entry format:
; [2024-06-25 14:23:59] | INFO | System started successfully

; ; First, extract the timestamp inside square brackets

; Find the segment after splitting at '[' (should be at index 1)
(define-fun ts_with_endbracket () String
 (str.split_at log_entry "[" 1)
)

; ; Extract the timestamp and the rest: "[2024-06-25 14:23:59] | INFO | System started successfully"
; Now, split at ']' to isolate the timestamp (should be at index 0)
(define-fun timestamp () String
 (str.split_at ts_with_endbracket "]" 0)
)

; ; Validate timestamp format: "YYYY-MM-DD HH:MM:SS"
; Split timestamp at ' ' (space)
(define-fun date_part () String
 (str.split_at timestamp " " 0)
)
(define-fun time_part () String
 (str.split_at timestamp " " 1)
)

; Further split date_part at '-'
(define-fun year () String
 (str.split_at date_part "-" 0)
)
(define-fun month () String
 (str.split_at date_part "-" 1)
)
(define-fun day () String
 (str.split_at date_part "-" 2)
)

; Further split time_part at ':'
(define-fun hour () String
 (str.split_at time_part ":" 0)
)
(define-fun minute () String
 (str.split_at time_part ":" 1)
)
(define-fun second () String
 (str.split_at time_part ":" 2)
)

; ; Now, extract the log level
; After the closing ']', the next part should be " | LEVEL | ..."
; Split at '|' delimiter
(define-fun after_bracket () String
 (str.split_rest log_entry "]" 1)
)

; after_bracket should begin with " | LEVEL | ..."
; Split at '|' to get the log level, which is at index 1 (since index 0 is " ")
(define-fun log_level_padded () String
 (str.split_at after_bracket "|" 1)
)

; Remove leading and trailing spaces from log_level_padded if any
; For simplicity, assume a single leading space: use str.substr
(define-fun log_level () String
 (str.substr log_level_padded 1 (- (str.len log_level_padded) 2))
)

; ; Message extraction: it's after the second '|'
(define-fun message_with_pipe () String
 (str.split_rest after_bracket "|" 2)
)

; Remove leading space from message_with_pipe
(define-fun message () String
 (str.substr message_with_pipe 1 (- (str.len message_with_pipe) 1))
)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Satisfiable constraints (realistic log entry)
(assert (= log_entry "[2024-06-25 14:23:59] | INFO | System started successfully"))

; Timestamp format constraints
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level validation: must be one of INFO, WARN, ERROR, DEBUG
(assert (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
))

; Message must not be empty
(assert (> (str.len message) 0))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; ; Unsatisfiable constraint: log level cannot be "TRACE"
(assert (not (= log_level "TRACE")))

; ; Additional unsatisfiable constraint: hour must be "99" (which is invalid for time)
(assert (= hour "99"))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(check-sat)
(get-model)
