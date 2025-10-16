; SMT-LIB2 file for log entry parsing using split constraints
; ; Scenario: Extract timestamp, log level, and message from typical log entries
; Delimiters used: space (' '), colon (':'), dash ('-'), pipe ('|'), left bracket ('['), right bracket (']')

(set-logic QF_SLIA)

; Declare the log entry string variable
(declare-fun log_entry () String)

; ; Declare variables for extracted components
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)

; ; Example log entry format:
; [2024-06-12 23:45:10] | INFO | System started successfully
; 0 1 2 3 4 5 6 7 8 9 ... (string indices)

; ; Step 1: Extract the timestamp between brackets
; Split at '[' and get segment 1: "2024-06-12 23:45:10] | INFO | System started successfully"
(assert (= (str.split_at log_entry "[" 1) (str.++ timestamp "] | INFO | System started successfully")))

; Split at ']' and get segment 0: "2024-06-12 23:45:10"
(assert (= (str.split_at (str.split_at log_entry "[" 1) "]" 0) timestamp))

; ; Step 2: Validate the timestamp format via splits
; Timestamp expected: "YYYY-MM-DD HH:MM:SS" (e.g., "2024-06-12 23:45:10")
; Split at ' ' (space)
(assert (> (str.num_splits timestamp " ") 1))
(assert (= (str.split_at timestamp " " 1) (str.++ (str.split_at (str.split_at timestamp " " 1) ":" 0) ":"
 (str.split_at (str.split_at timestamp " " 1) ":" 1) ":"
 (str.split_at (str.split_at timestamp " " 1) ":" 2))))

; ; Validate date part: "YYYY-MM-DD"
(assert (= (str.len (str.split_at timestamp " " 0)) 10))
; ; Validate that the date part contains two '-' splits
(assert (= (str.num_splits (str.split_at timestamp " " 0) "-") 3))

; ; Step 3: Extract log level
; After the ']' delimiter, first split at '|', get segment 1: " INFO | System started successfully"
(assert (= (str.split_at log_entry "]" 1) (str.++ " |" log_level " | System started successfully")))
; Now, split at '|' and get segment 1, then trim leading space

; ; Step 4: Validate log level (must be one of INFO, WARN, ERROR, DEBUG)
(assert (or (= log_level "INFO")
 (= log_level "WARN")
 (= log_level "ERROR")
 (= log_level "DEBUG")))

; ; Step 5: Extract message
; The message comes after the second '|'

; Practical relationship: The message must not be empty
(assert (> (str.len message) 0))

; ; Satisfiable Example Constraint: Provide a concrete instance
(assert (= log_entry "[2024-06-12 23:45:10] | INFO | System started successfully"))

; ; Unsatisfiable Example Constraint: Log level must be "TRACE", which is not allowed
(assert (not (= log_level "TRACE")))

(check-sat)
(get-model)
