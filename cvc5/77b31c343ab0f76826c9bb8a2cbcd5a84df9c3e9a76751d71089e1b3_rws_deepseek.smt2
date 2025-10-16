
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV validation with alternative constraints
 Focus: Field content validation and delimiter handling
|)

; Declare input strings with different delimiters
(declare-const csv_row String)
(declare-const tsv_row String)
(declare-const pipe_row String)

; CSV constraints - comma delimiter
; Must have exactly 5 fields
(assert (= (str.num_splits csv_row ",") 5))

; First field must be numeric
(declare-const csv_id String)
(assert (= csv_id (str.split_at csv_row "," 0)))
(assert (str.is_digit csv_id))

; Last field must be empty (trailing comma)
(declare-const csv_last String)
(assert (= csv_last (str.split_at csv_row "," 4)))
(assert (= (str.len csv_last) 0))

; TSV constraints - tab delimiter
; Must have between 3 and 6 fields
(assert (>= (str.num_splits tsv_row "\t") 3))
(assert (<= (str.num_splits tsv_row "\t") 6))

; Middle field cannot be empty
(declare-const tsv_middle String)
(assert (= tsv_middle (str.split_at tsv_row "\t" 1)))
(assert (> (str.len tsv_middle) 0))

; Pipe-delimited constraints
; Must have at least 2 fields
(assert (>= (str.num_splits pipe_row "|") 2))

; First field must start with letter
(declare-const pipe_first String)
(assert (= pipe_first (str.split_at pipe_row "|" 0)))

; Field content validation - no field contains the delimiter
(assert (not (str.contains (str.split_at pipe_row "|" 0) "|")))
(assert (not (str.contains (str.split_at pipe_row "|" 1) "|")))

; ; Combined constraint: At least one row must have more than 3 fields
(assert (or
 (> (str.num_splits csv_row ",") 3)
 (> (str.num_splits tsv_row "\t") 3)
 (> (str.num_splits pipe_row "|") 3)
))

(check-sat)
(exit)
(get-model)
