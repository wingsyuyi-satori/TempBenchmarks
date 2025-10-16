(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated for: CSV/TSV processing with alternative constraints
Focus: Field validation with multiple delimiters
|)

; Declare variables for input lines with different delimiters
(declare-const csv_line String)
(declare-const tsv_line String)
(declare-const pipe_line String)

; Common constraints for all formats
(assert (>= (str.len csv_line) 5))
(assert (>= (str.len tsv_line) 5))
(assert (>= (str.len pipe_line) 5))

; CSV-specific constraints (comma delimiter)
(assert (>= (str.num_splits csv_line ",") 4)) ; Must have at least 4 fields
(assert (not (str.contains (str.split_at csv_line "," 0) ","))) ; No nested commas
(assert (or 
 (= (str.len (str.split_at csv_line "," 1)) 0) ; Allow empty second field
 (>= (str.len (str.split_at csv_line "," 1)) 2)
))

; TSV-specific constraints (tab delimiter)
(assert (= (str.num_splits tsv_line "\t") 3)) ; Exactly 3 fields
(assert (str.prefixof "ID" (str.split_at tsv_line "\t" 0))) ; First field starts with ID
(assert (not (str.contains (str.split_at tsv_line "\t" 2) "\t"))) ; No tabs in last field

; Pipe-delimited constraints
(assert (<= (str.num_splits pipe_line "|") 5)) ; At most 5 fields
(assert (str.contains pipe_line "||")) ; Must contain empty field
(assert (= (str.len (str.split_at pipe_line "|" 2)) 10)) ; Third field exactly 10 chars

; Cross-format validation
(declare-const first_csv_field String)
(declare-const first_tsv_field String)
(assert (= first_csv_field (str.split_at csv_line "," 0)))
(assert (= first_tsv_field (str.split_at tsv_line "\t" 0)))
(assert (not (= first_csv_field first_tsv_field))) ; IDs must differ

; Field content constraints
(assert (str.is_digit (str.at (str.split_at pipe_line "|" 1) 0))) ; Second field starts with digit
(assert (str.suffixof "_OK" (str.split_at tsv_line "\t" 2))) ; Last field ends with _OK

(check-sat)
(exit)
(get-model)
