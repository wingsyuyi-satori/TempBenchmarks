(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare a TSV (tab-separated) line variable
(declare-const tsv_line String)

; Ensure exactly 5 fields by counting splits with tab delimiter
(assert (= (str.num_splits tsv_line "\t") 5))

; ; Extract fields
(declare-const tsv_field0 String)
(declare-const tsv_field1 String)
(declare-const tsv_field2 String)
(declare-const tsv_field3 String)
(declare-const tsv_field4 String)

(assert (= tsv_field0 (str.split_at tsv_line "\t" 0)))
(assert (= tsv_field1 (str.split_at tsv_line "\t" 1)))
(assert (= tsv_field2 (str.split_at tsv_line "\t" 2)))
(assert (= tsv_field3 (str.split_at tsv_line "\t" 3)))
(assert (= tsv_field4 (str.split_at tsv_line "\t" 4)))

; At least one field must be empty (simulate missing value)
(assert (or
 (= tsv_field0 "")
 (= tsv_field1 "")
 (= tsv_field2 "")
 (= tsv_field3 "")
 (= tsv_field4 "")
))

; No field contains the delimiter (tab)
(assert (not (str.contains tsv_field0 "\t")))
(assert (not (str.contains tsv_field1 "\t")))
(assert (not (str.contains tsv_field2 "\t")))
(assert (not (str.contains tsv_field3 "\t")))
(assert (not (str.contains tsv_field4 "\t")))

; Third field (tsv_field2) must start and end with a double quote to simulate escaped value
(assert (str.prefixof """" tsv_field2))
(assert (str.suffixof """" tsv_field2))

; Rest of the line after third field should be exactly the concatenation of tsv_field3, tab, and tsv_field4
(declare-const rest_after_2 String)
(assert (= rest_after_2 (str.split_rest tsv_line "\t" 3)))
(assert (= rest_after_2 (str.++ tsv_field3 "\t" tsv_field4)))

; ; Unsatisfiable constraint: field 1 and field 2 are both empty (not allowed)
(assert (not (and (= tsv_field1 "") (= tsv_field2 ""))))

(check-sat)
(exit)
(get-model)
