
(set-logic QF_SLIA)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")

; Declare input CSV line with different delimiters
(declare-const csv_line1 String) ; Comma-separated
(declare-const csv_line2 String) ; Tab-separated
(declare-const csv_line3 String) ; Semicolon-separated

; Basic constraints on field counts
(assert (>= (str.num_splits csv_line1 ",") 3))
(assert (>= (str.num_splits csv_line2 "\t") 3))
(assert (= (str.num_splits csv_line3 ";") 4))

; ; Extract first field from each format
(declare-const id1 String)
(declare-const id2 String)
(declare-const id3 String)
(assert (= id1 (str.split_at csv_line1 "," 0)))
(assert (= id2 (str.split_at csv_line2 "\t" 0)))
(assert (= id3 (str.split_at csv_line3 ";" 0)))

; ID fields must match across formats
(assert (= id1 id2))
(assert (= id2 id3))

; ID field constraints (non-empty, no delimiters)
(assert (> (str.len id1) 0))
(assert (not (str.contains id1 ",")))
(assert (not (str.contains id1 "\t")))
(assert (not (str.contains id1 ";")))

; ; Extract and validate amount field (second position)
(declare-const amount1 String)
(declare-const amount2 String)
(assert (= amount1 (str.split_at csv_line1 "," 1)))
(assert (= amount2 (str.split_at csv_line2 "\t" 1)))

; ; Amount must be numeric (simple check)
(assert (str.is_digit amount1))
(assert (str.is_digit amount2))

; Handle empty fields (third position allowed to be empty)
(declare-const field3_1 String)
(declare-const field3_2 String)
(assert (= field3_1 (str.split_at csv_line1 "," 2)))
(assert (= field3_2 (str.split_at csv_line2 "\t" 2)))

; ; Extract remaining fields after position 2
(declare-const rest1 String)
(declare-const rest2 String)
(assert (= rest1 (str.split_rest csv_line1 "," 3)))
(assert (= rest2 (str.split_rest csv_line2 "\t" 3)))

; Special constraint for semicolon-delimited file
(assert (not (= (str.split_at csv_line3 ";" 3) "")))

(check-sat)
(get-model)
