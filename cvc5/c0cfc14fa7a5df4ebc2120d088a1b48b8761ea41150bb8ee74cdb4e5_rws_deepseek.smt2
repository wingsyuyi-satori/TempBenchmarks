(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with alternative constraints
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
(assert (= (str.num_splits csv_comma ",") 4)) ; Exactly 4 fields
(assert (not (str.contains (str.split_at csv_comma "," 0) " "))) ; No spaces in first field
(assert (str.contains (str.split_at csv_comma "," 3) "@")) ; Last field must contain @

; Tab-delimited TSV constraints
(assert (= (str.num_splits csv_tab "\t") 3)) ; Exactly 3 fields
(assert (str.prefixof "ID:" (str.split_at csv_tab "\t" 0))) ; First field starts with ID:
(assert (= (str.len (str.split_at csv_tab "\t" 1)) 10)) ; Second field exactly 10 chars

; Pipe-delimited constraints
(assert (>= (str.num_splits csv_pipe "|") 2)) ; At least 2 fields
(assert (str.suffixof ".com" (str.split_at csv_pipe "|" 1))) ; Second field ends with .com

; Empty field handling
(declare-const csv_with_empty String)
(assert (= (str.num_splits csv_with_empty ";") 3)) ; 3 fields
(assert (= (str.len (str.split_at csv_with_empty ";" 1)) 0)) ; Middle field empty

; Field concatenation validation
(assert (=
 (str.++ 
 (str.split_at csv_comma "," 0)
 (str.split_at csv_comma "," 1)
)
 (str.split_at csv_pipe "|" 0)
))

(check-sat)
(exit)
(get-model)
