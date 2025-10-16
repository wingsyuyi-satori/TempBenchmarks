
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and functions
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Declare constants for common delimiters
(declare-const space String)
(declare-const colon String)
(declare-const hyphen String)
(declare-const pipe String)
(declare-const lbracket String)
(declare-const rbracket String)

(assert (= space " "))
(assert (= colon ":"))
(assert (= hyphen "-"))
(assert (= pipe "|"))
(assert (= lbracket "["))
(assert (= rbracket "]"))

; Declare variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: [2023-01-15 14:30:45] INFO | System started
; Constraints for valid log parsing

; ; 1. Extract timestamp between brackets
(assert (= timestamp (str.split_at (str.split_at log_entry lbracket 1) rbracket 0)))

; ; 2. Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.split_at timestamp hyphen 0) "2023")) ; Sample year
(assert (= (str.split_at (str.split_at timestamp space 1) colon 0) "14")) ; Sample hour
(assert (= (str.split_at (str.split_at timestamp space 1) colon 1) "30")) ; Sample minute
(assert (= (str.split_at (str.split_at timestamp space 1) colon 2) "45")) ; Sample second

; ; 3. Extract log level after first pipe
(assert (= log_level (str.split_at (str.split_at log_entry pipe 1) space 0)))

; ; 4. Validate log level is one of standard values
(assert (or (= log_level "INFO") 
 (= log_level "WARN") 
 (= log_level "ERROR") 
 (= log_level "DEBUG")))

; ; 5. Extract message as everything after log level
(assert (= message (str.split_rest (str.split_at log_entry pipe 1) space 1)))

; 6. Additional constraints for message content
(assert (>= (str.len message) 5)) ; Message must be at least 5 chars
(assert (not (str.contains message "password"))) ; Security constraint

; Sample log entry to satisfy constraints
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))

; Uncomment to make unsatisfiable
; (assert (= log_level "CRITICAL")) ; Not a valid log level

(check-sat)
(exit)
(get-model)
