(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare a TSV (tab-separated) line variable
(declare-const tsv_line String)

; ; Constraint: The TSV line must have exactly 5 fields
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract all 5 fields
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

; ; Constraint: No field should be just the delimiter (i.e., a single tab)
(assert (distinct tsv_f0 "\t"))
(assert (distinct tsv_f1 "\t"))
(assert (distinct tsv_f2 "\t"))
(assert (distinct tsv_f3 "\t"))
(assert (distinct tsv_f4 "\t"))

; ; Constraint: At least one field (the third) must be empty (testing empty field handling)
(assert (= tsv_f2 ""))

; ; Constraint: The last field contains at least one pipe '|'
(assert (str.contains tsv_f4 "|"))

; ; Constraint: The first field must not contain any semicolons ';' (escape/quote handling)
(assert (not (str.contains tsv_f0 ";")))

; ; Unsatisfiable constraint: the last field is both empty and contains a delimiter
(assert (not (= tsv_f4 "")))

; For demonstration, make the fourth field equal to the concatenation of the first and second fields separated by a semicolon
(assert (= tsv_f3 (str.++ tsv_f0 ";" tsv_f1)))

(check-sat)
(exit)
(get-model)
