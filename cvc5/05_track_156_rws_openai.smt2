(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Declare a line in TSV format (tab-separated)
(declare-const tsv_line String)

; Require that the TSV line contains exactly 4 fields (3 delimiters)
(assert (= (str.num_splits tsv_line "\t") 4))

; ; Extract all fields
(declare-const tsv_f0 String)
(declare-const tsv_f1 String)
(declare-const tsv_f2 String)
(declare-const tsv_f3 String)
(assert (= tsv_f0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_f2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_f3 (str.split_at tsv_line "\t" 3)))

; Second field (tsv_f1) must be empty (to test empty fields)
(assert (= tsv_f1 ""))

; Third field (tsv_f2) must not contain the tab character (no embedded delimiters)
(assert (not (str.contains tsv_f2 "\t")))

; Fourth field (tsv_f3) may be quoted, and if so, must start and end with a double quote
; We express: if the field starts with a quote, it ends with a quote and is at least length 2
(assert (=> 
 (= (str.at tsv_f3 0) """")
 (and 
 (= (str.at tsv_f3 (- (str.len tsv_f3) 1)) """")
 (>= (str.len tsv_f3) 2)
)
))

; ; Delimiter variation: check that a semicolon-separated line has at least one empty field
(declare-const scsv_line String)
(assert (>= (str.num_splits scsv_line ";") 2))
(declare-const scsv_f0 String)
(declare-const scsv_f1 String)
(assert (= scsv_f0 (str.split_at scsv_line ";" 0)))
(assert (= scsv_f1 (str.split_at scsv_line ";" 1)))
(assert (or (= scsv_f0 "") (= scsv_f1 "")))

; ; Unsatisfiable constraint: require that a pipe-separated line has exactly 1 field, but also that the first field contains the delimiter '|'
(declare-const pipe_line String)
(assert (= (str.num_splits pipe_line "|") 1))
(declare-const pipe_f0 String)
(assert (= pipe_f0 (str.split_at pipe_line "|" 0)))
(assert (str.contains pipe_f0 "|"))

(check-sat)
(exit)
(get-model)
