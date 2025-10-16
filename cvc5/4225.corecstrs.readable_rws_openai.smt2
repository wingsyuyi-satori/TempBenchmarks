(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)


; Declare a TSV line (tab-separated values)
(declare-const tsv_line String)

; Ensure the TSV line has exactly 4 fields (3 delimiters)
(assert (= (str.num_splits tsv_line "\t") 4))

; Declare the fields explicitly
(declare-const tsv_f0 String)
(declare-const tsv_f1 String)
(declare-const tsv_f2 String)
(declare-const tsv_f3 String)

(assert (= tsv_f0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_f1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_f2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_f3 (str.split_at tsv_line "\t" 3)))

; ; Unsatisfiable constraint: No empty fields allowed
(assert (> (str.len tsv_f0) 0))
(assert (> (str.len tsv_f1) 0))
(assert (> (str.len tsv_f2) 0))
(assert (> (str.len tsv_f3) 0))

; Escape handling: fields must not contain a literal tab (should be split)
(assert (not (str.contains tsv_f0 "\t")))
(assert (not (str.contains tsv_f1 "\t")))
(assert (not (str.contains tsv_f2 "\t")))
(assert (not (str.contains tsv_f3 "\t")))

; ; Satisfiable constraint: At least one field contains a semicolon (for embedded data)
(assert (or (str.contains tsv_f0 ";")
 (str.contains tsv_f1 ";")
 (str.contains tsv_f2 ";")
 (str.contains tsv_f3 ";")))

; Reconstruct remainder of the line after field 2, with delimiters preserved
(declare-const tsv_rest String)
(assert (= tsv_rest (str.split_rest tsv_line "\t" 2)))

; The remainder must start with the delimiter (since split_rest includes delimiter before k-th field if k > 0)
(assert (str.prefixof "\t" tsv_rest))

(check-sat)
(get-model)
