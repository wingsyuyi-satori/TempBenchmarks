(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated for CSV/TSV processing with alternative constraints
Focus: Field validation with multiple delimiters
|)

; Declare variables for different CSV formats
(declare-const csv_comma String)
(declare-const csv_tab String)
(declare-const csv_pipe String)

; Common constraints for all formats
(assert (>= (str.len csv_comma) 5))
(assert (>= (str.len csv_tab) 5))
(assert (>= (str.len csv_pipe) 5))

; Comma-delimited CSV constraints
(assert (= (str.num_splits csv_comma ",") 4)) ; Must have exactly 4 fields
(assert (not (str.contains (str.split_at csv_comma "," 0) " "))) ; No spaces in first field
(assert (str.contains (str.split_at csv_comma "," 3) "@")) ; Last field must contain @

; Tab-delimited TSV constraints
(assert (>= (str.num_splits csv_tab "\t") 3)) ; At least 3 fields
(assert (<= (str.len (str.split_at csv_tab "\t" 1)) 8)) ; Second field max length 8
(assert (str.prefixof "ID:" (str.split_at csv_tab "\t" 0))) ; First field starts with ID:

; Pipe-delimited constraints
(assert (= (str.num_splits csv_pipe "|") 5)) ; Exactly 5 fields
(assert (str.suffixof ";" (str.split_at csv_pipe "|" 4))) ; Last field ends with ;
(assert (= (str.len (str.split_at csv_pipe "|" 2)) 0)) ; Third field must be empty

; Additional constraints for escaped fields
(declare-const escaped_line String)
(assert (str.contains escaped_line "\""")) ; Must contain escaped quote
(assert (>= (str.num_splits escaped_line ",") 2))
(assert (str.contains (str.split_at escaped_line "," 1) "\""")) ; Second field has escaped quote

; Mixed delimiter validation
(declare-const mixed_line String)
(assert (or
 (str.contains mixed_line ",")
 (str.contains mixed_line "\t")
 (str.contains mixed_line "|")
))

(check-sat)
(exit)
(get-model)
