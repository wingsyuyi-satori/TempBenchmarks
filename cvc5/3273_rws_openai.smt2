(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :category "industrial")
(set-info :status unknown)

; Declare a TSV (tab-separated) line
(declare-const tsv_line String)

; Require exactly 5 fields in the line
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract fields
(declare-const tsv_f0 String)
(declare-const tsv_f1 String)
(declare-const tsv_f2 String)
(declare-const tsv_f3 String)
(declare-const tsv_f4 String)
(assert (= tsv_f0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_f2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_f3 (str.split_at tsv_line "\t" 3)))
(assert (= tsv_f4 (str.split_at tsv_line "\t" 4)))

; Fields 2 and 3 must be empty (simulate empty cells)
(assert (= tsv_f1 ""))
(assert (= tsv_f2 ""))

; Last field must end with a semicolon (escape handling / trailing char)
(assert (str.suffixof ";" tsv_f4))

; None of the fields should contain the pipe delimiter
(assert (not (str.contains tsv_f0 "|")))
(assert (not (str.contains tsv_f1 "|")))
(assert (not (str.contains tsv_f2 "|")))
(assert (not (str.contains tsv_f3 "|")))
(assert (not (str.contains tsv_f4 "|")))

; Unsatisfiable: All fields together must be shorter than 3 (impossible with 5 fields)
(assert (< (+ (str.len tsv_f0) (str.len tsv_f1) (str.len tsv_f2) (str.len tsv_f3) (str.len tsv_f4)) 3))

(check-sat)
(get-model)
