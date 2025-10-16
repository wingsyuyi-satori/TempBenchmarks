; ; SMT-LIB2 script for log analysis with timestamp and level extraction
(set-logic QF_SLIA)

; Declare string sort and operations
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.at (String Int) String)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.indexof (String String Int) Int)
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

; ; Example log format: [2023-01-15 14:30:45] INFO | main: Starting application
(declare-const log_entry String)

; Test cases - mix of valid and invalid logs
(assert (or
 (= log_entry "[2023-01-15 14:30:45] INFO | main: Starting application")
 (= log_entry "[2023-13-40 25:61:99] CRITICAL | error: Invalid timestamp")
 (= log_entry "2023-01-15 14:30:45 WARN network: Connection timeout")
 (= log_entry "[2023-01-15] DEBUG | auth: Login attempt")
))

; ; Extract timestamp portion (between brackets)
(declare-const timestamp String)
(assert (ite (and (str.contains log_entry lbracket) (str.contains log_entry rbracket))
 (= timestamp (str.split_at (str.substr log_entry 1 (- (str.len log_entry) 1)) rbracket 0))
 (= timestamp "")
))

; ; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(declare-const date_part String)
(declare-const time_part String)
(assert (ite (>= (str.len timestamp) 19)
 (and
 (= date_part (str.substr timestamp 0 10))
 (= time_part (str.substr timestamp 11 8))
 ; Date validation: YYYY-MM-DD
 (= (str.len date_part) 10)
 (= (str.at date_part 4) hyphen)
 (= (str.at date_part 7) hyphen)
 ; Time validation: HH:MM:SS
 (= (str.len time_part) 8)
 (= (str.at time_part 2) colon)
 (= (str.at time_part 5) colon)
)
 (and (= date_part "") (= time_part ""))
))

; ; Extract log level (INFO, WARN, etc.)
(declare-const log_level String)
(assert (ite (str.contains log_entry pipe)
 (and
 (= log_level (str.split_at (str.split_at log_entry pipe 0) rbracket 1))
 (= (str.len log_level) (str.indexof log_level space 0))
)
 (= log_level "")
))

; ; Validate log level is one of standard values
(assert (or
 (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")
 (= log_level "CRITICAL")
 (= log_level "")
))

; ; Extract message portion (after second pipe)
(declare-const message String)
(assert (ite (>= (str.num_splits log_entry pipe) 2)
 (= message (str.split_rest log_entry pipe 1))
 (= message "")
))

; Additional constraints for meaningful relationships
(assert (=> (not (= log_level "")) (not (= message ""))))
(assert (=> (not (= timestamp "")) (not (= log_level ""))))
(assert (=> (str.contains log_level "ERROR") (str.contains message "error")))

; Verification conditions
(assert (not (and
 (= timestamp "")
 (not (= log_level ""))
)))

(assert (not (and
 (str.contains log_level "CRITICAL")
 (not (str.contains message "fail"))
)))

(check-sat)
(get-model)
