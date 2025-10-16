(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated for: CSV/TSV/PSV field splitting and validation
Focus: field count, tab/semicolon/pipe delimiters, empty fields, field value constraints, unsatisfiable combination
|)

; Declare an input line which could be TSV, semicolon, or pipe separated
(declare-const tsv_line String)
(declare-const psv_line String)
(declare-const scsv_line String)

; TSV: Ensure exactly 4 fields (so 3 delimiters)
(assert (= (str.num_splits tsv_line "\t") 4))

; Semicolon-separated: Ensure at least 2 fields
(assert (>= (str.num_splits scsv_line ";") 2))

; Pipe-separated: Ensure exactly 5 fields
(assert (= (str.num_splits psv_line "|") 5))

; ; Extract fields from TSV
(declare-const tsv_field0 String)
(declare-const tsv_field1 String)
(declare-const tsv_field2 String)
(declare-const tsv_field3 String)
(assert (= tsv_field0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_field1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_field2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_field3 (str.split_at tsv_line "\t" 3)))

; Ensure the second TSV field is empty (models empty field)
(assert (= tsv_field1 ""))

; Ensure the first field of the pipe-separated line is non-empty and contains no spaces
(declare-const psv_field0 String)
(assert (= psv_field0 (str.split_at psv_line "|" 0)))
(assert (> (str.len psv_field0) 0))
(assert (not (str.contains psv_field0 " ")))

; For semicolon-separated: the first two fields must not be equal (unsatisfiable if scsv_line == "A;A")
(declare-const scsv_f0 String)
(declare-const scsv_f1 String)
(assert (= scsv_f0 (str.split_at scsv_line ";" 0)))
(assert (= scsv_f1 (str.split_at scsv_line ";" 1)))
(assert (not (= scsv_f0 scsv_f1)))

; ; Unsatisfiable constraint: the third TSV field equals "foo", but all fields are empty
(assert (= tsv_field2 "foo"))
(assert (= tsv_field0 ""))
(assert (= tsv_field1 ""))
(assert (= tsv_field3 ""))

(check-sat)
(exit)
(get-model)
