(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated for CSV/TSV processing with different constraints
Focus: Field validation and delimiter handling
|)

; Declare variables for different CSV formats
(declare-const csv_comma String) ; CSV with comma delimiter
(declare-const csv_tab String) ; TSV with tab delimiter
(declare-const csv_pipe String) ; Pipe-delimited file

; Common constraints for all formats
(assert (>= (str.len csv_comma) 5))
(assert (>= (str.len csv_tab) 5))
(assert (>= (str.len csv_pipe) 5))

; Constraint 1: All formats must have exactly 4 fields
(assert (= (str.num_splits csv_comma ",") 4))
(assert (= (str.num_splits csv_tab "\t") 4))
(assert (= (str.num_splits csv_pipe "|") 4))

; ; Extract fields from comma-separated format
(declare-const c_field1 String)
(declare-const c_field2 String)
(assert (= c_field1 (str.split_at csv_comma "," 0)))
(assert (= c_field2 (str.split_at csv_comma "," 1)))

; Field constraints for comma format
(assert (not (= c_field1 ""))) ; First field cannot be empty
(assert (str.prefixof "ID" c_field1)) ; Must start with ID

; ; Extract fields from tab-separated format
(declare-const t_field3 String)
(declare-const t_field4 String)
(assert (= t_field3 (str.split_at csv_tab "\t" 2)))
(assert (= t_field4 (str.split_at csv_tab "\t" 3)))

; Field constraints for tab format
(assert (or (= t_field3 "ACTIVE") (= t_field3 "INACTIVE")))
(assert (str.is_digit t_field4)) ; Last field must be numeric

; ; Extract remaining fields from pipe format
(declare-const p_remaining String)
(assert (= p_remaining (str.split_rest csv_pipe "|" 2)))

; ; Constraint: Remaining pipe fields must contain at least one non-empty field
(assert (not (str.contains p_remaining "||"))) ; No empty consecutive fields

; ; Additional constraint: No field in any format contains the delimiter
(assert (not (str.contains c_field1 ",")))
(assert (not (str.contains t_field3 "\t")))
(assert (not (str.contains p_remaining "|")))

(check-sat)
(get-model)
