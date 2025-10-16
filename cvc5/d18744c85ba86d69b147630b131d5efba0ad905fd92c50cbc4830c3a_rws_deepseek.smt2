
(set-logic QF_SLIA) ; String theory

; Declarations for string operations
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Variables for log parsing
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; ; Example log format: [2023-12-25 08:30:45] INFO | System started successfully
; Constraints for parsing the log entry

; ; 1. Timestamp extraction and validation
(assert (= timestamp (str.split_at (str.split_at log_entry "[" 1) "]" 0)))
(assert (= year (str.split_at timestamp "-" 0)))
(assert (= month (str.split_at (str.split_at timestamp "-" 1) "-" 0)))
(assert (= day (str.split_at (str.split_at timestamp "-" 1) " " 1)))
(assert (= hour (str.split_at (str.split_at (str.split_at timestamp " " 1) ":" 0) ":" 0)))
(assert (= minute (str.split_at (str.split_at (str.split_at timestamp " " 1) ":" 1) ":" 0)))
(assert (= second (str.split_at (str.split_at (str.split_at timestamp " " 1) ":" 2) " " 0)))

; Year must be 4 digits
(assert (= (str.len year) 4))
; Month must be between 01 and 12
(assert (or (= month "01") (= month "02") (= month "03") (= month "04") 
 (= month "05") (= month "06") (= month "07") (= month "08")
 (= month "09") (= month "10") (= month "11") (= month "12")))
; Day must be between 01 and 31
(assert (str.prefixof "0" day)) ; Ensure 2-digit format
(assert (str.< "00" day))
(assert (str.< day "32"))

; 2. Log level validation
(assert (= log_level (str.split_at (str.split_at log_entry "|" 0) " " 2)))
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "ERROR") 
 (= log_level "DEBUG") (= log_level "TRACE")))

; ; 3. Message extraction
(assert (= message (str.split_rest log_entry "|" 1)))

; Additional constraints
; The log entry must contain all required components
(assert (>= (str.num_splits log_entry "[") 1))
(assert (>= (str.num_splits log_entry "]") 1))
(assert (>= (str.num_splits log_entry "|") 1))

; ; Example concrete log entry (for testing)
(assert (= log_entry "[2023-12-25 08:30:45] INFO | System started successfully"))

; ; Check for consistency
(check-sat)
(exit)
(get-model)
