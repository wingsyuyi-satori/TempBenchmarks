(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with field validation
 Focus: Field count consistency across different delimiters
|)

; Declare input strings with different delimiters
(declare-const csv_row String) ; Comma-separated
(declare-const tsv_row String) ; Tab-separated
(declare-const pipe_row String) ; Pipe-separated

; Common constraints for all formats
(assert (>= (str.len csv_row) 5))
(assert (>= (str.len tsv_row) 5))
(assert (>= (str.len pipe_row) 5))

; Field count must match across all formats (3 fields)
(assert (= (str.num_splits csv_row ",") 3))
(assert (= (str.num_splits tsv_row "\t") 3))
(assert (= (str.split_at pipe_row "|" 2) (str.split_at csv_row "," 2)))

; ; Extract fields from CSV
(declare-const csv_field1 String)
(declare-const csv_field2 String)
(declare-const csv_field3 String)
(assert (= csv_field1 (str.split_at csv_row "," 0)))
(assert (= csv_field2 (str.split_at csv_row "," 1)))
(assert (= csv_field3 (str.split_at csv_row "," 2)))

; Field validation rules
; First field cannot be empty
(assert (not (= csv_field1 "")))
; Second field must be numeric
(assert (str.is_digit csv_field2))
; Third field cannot contain delimiters
(assert (not (str.contains csv_field3 ",")))
(assert (not (str.contains csv_field3 "\t")))
(assert (not (str.contains csv_field3 "|")))

; Empty field test case (middle field can be empty)
(assert (or (= csv_field2 "") (>= (str.len csv_field2) 1)))

; TSV specific constraints
(declare-const tsv_last_field String)
(assert (= tsv_last_field (str.split_at tsv_row "\t" 2)))
(assert (<= (str.len tsv_last_field) 20))

; Pipe-delimited constraints
(assert (str.prefixof "ID" (str.split_at pipe_row "|" 0)))

; Escape handling: if field contains quote, it must be properly escaped
(assert (=> (str.contains csv_field1 "") 
 (str.prefixof "" csv_field1)))

(check-sat)
(get-model)
