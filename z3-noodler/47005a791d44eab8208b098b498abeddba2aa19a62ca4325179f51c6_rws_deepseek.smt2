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
(declare-const dash String)
(declare-const pipe String)
(declare-const lbracket String)
(declare-const rbracket String)

(assert (= space " "))
(assert (= colon ":"))
(assert (= dash "-"))
(assert (= pipe "|"))
(assert (= lbracket "["))
(assert (= rbracket "]"))

; Declare variables for log components
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const log_level String)
(declare-const message String)

; ; Example log format: [2023-01-15 14:30:45] INFO | System started successfully
(assert (str.contains log_entry lbracket))
(assert (str.contains log_entry rbracket))
(assert (str.contains log_entry pipe))

; ; Extract timestamp between brackets
(assert (= timestamp (str.split_at (str.substr log_entry 1 (- (str.len log_entry) 2)) rbracket 0)))

; ; Validate timestamp format (YYYY-MM-DD HH:MM:SS)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) dash))
(assert (= (str.at timestamp 7) dash))
(assert (= (str.at timestamp 10) space))
(assert (= (str.at timestamp 13) colon))
(assert (= (str.at timestamp 16) colon))

; ; Extract log level (between right bracket and pipe)
(assert (= log_level (str.split_at (str.split_rest log_entry rbracket 1) pipe 0)))
(assert (str.contains log_level space)) ; Log level is surrounded by spaces

; Trim spaces from log level
(assert (or 
 (= log_level " ERROR ")
 (= log_level " WARN ")
 (= log_level " INFO ")
 (= log_level " DEBUG ")
 (= log_level " TRACE ")
))

; ; Extract message (after pipe)
(assert (= message (str.split_rest log_entry pipe 1)))
(assert (>= (str.len message) 1)) ; Message cannot be empty

; Additional constraints for realistic scenarios
; Constraint 1: Timestamp must start with 20 (for 21st century logs)
(assert (= (str.substr timestamp 0 2) "20"))

; Constraint 2: Log level must be uppercase
(assert (str.contains " ERROR WARN INFO DEBUG TRACE " log_level))

; Constraint 3: Message cannot contain pipe character
(assert (not (str.contains message pipe)))

; Constraint 4: If log level is ERROR, message must contain "error" or "fail"
(assert (=> (= log_level " ERROR ") 
 (or 
 (str.contains message "error")
 (str.contains message "fail")
)
))

; Constraint 5: Timestamp minutes must be < 60
(assert (< (str.to_int (str.substr timestamp 14 2)) 60))

; Test case 1: Valid log entry
(assert (= log_entry "[2023-01-15 14:30:45] INFO | System started successfully"))
(check-sat)




(get-model)
