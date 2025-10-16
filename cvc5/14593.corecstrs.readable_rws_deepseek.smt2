(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with different delimiters and constraints
 Focus: Field validation with multiple delimiters
|)

; Declare input strings with different delimiters
(declare-const csv_line String) ; Comma-separated
(declare-const tsv_line String) ; Tab-separated
(declare-const pipe_line String) ; Pipe-separated

; Common constraints for all formats
; Minimum 4 fields required
(assert (>= (str.num_splits csv_line ",") 4))
(assert (>= (str.num_splits tsv_line "\t") 4))
(assert (>= (str.num_splits pipe_line "|") 4))

; ; Extract first and last fields for CSV
(declare-const csv_first String)
(declare-const csv_last String)
(assert (= csv_first (str.split_at csv_line "," 0)))
(assert (= csv_last (str.split_at csv_line "," (- (str.num_splits csv_line ",") 1))))

; TSV specific constraints - no empty fields allowed
(assert (not (= (str.split_at tsv_line "\t" 1) "")))
(assert (not (= (str.split_at tsv_line "\t" 2) "")))

; Pipe-delimited specific: Field 3 must be numeric
(declare-const pipe_field3 String)
(assert (= pipe_field3 (str.split_at pipe_line "|" 2)))
(assert (str.is_digit pipe_field3))

; Empty field handling in CSV
; Either field1 or field2 can be empty, but not both
(declare-const csv_field1 String)
(declare-const csv_field2 String)
(assert (= csv_field1 (str.split_at csv_line "," 0)))
(assert (= csv_field2 (str.split_at csv_line "," 1)))
(assert (or (not (= csv_field1 "")) (not (= csv_field2 ""))))

; Field length constraints for TSV
(assert (<= (str.len (str.split_at tsv_line "\t" 0)) 50))
(assert (>= (str.len (str.split_at tsv_line "\t" 3)) 1))

; ; Check if remaining fields contain specific values
(declare-const csv_rest String)
(assert (= csv_rest (str.split_rest csv_line "," 2)))
(assert (str.contains csv_rest "active"))

(check-sat)
(get-model)
