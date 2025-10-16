(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with alternative constraints
 Focus: Field validation with multiple delimiters
|)

; Declare input line and possible delimiters
(declare-const data_line String)
(declare-const delim String)
(assert (or (= delim ",") (= delim "\t") (= delim ";") (= delim "|")))

; Require exactly 4 fields for valid records
(assert (= (str.num_splits data_line delim) 4))

; ; Extract all fields with proper indexing
(declare-const f0 String) ; Record type
(declare-const f1 String) ; Timestamp
(declare-const f2 String) ; Value
(declare-const f3 String) ; Status
(assert (= f0 (str.split_at data_line delim 0)))
(assert (= f1 (str.split_at data_line delim 1)))
(assert (= f2 (str.split_at data_line delim 2)))
(assert (= f3 (str.split_at data_line delim 3)))

; Field-specific constraints
; Record type must be one of ["A","B","C"]
(assert (or (= f0 "A") (= f0 "B") (= f0 "C")))

; Timestamp must be exactly 19 chars (ISO format)
(assert (= (str.len f1) 19))

; Value must be numeric (all digits or with single decimal point)
(assert (str.is_digit (str.replace f2 "." "")))

; Status must be empty or one character
(assert (<= (str.len f3) 1))

; ; Additional constraint: If status is empty, value must be zero
(assert (=> (= (str.len f3) 0) (= f2 "0")))

; Verify no empty fields except potentially status
(assert (> (str.len f0) 0))
(assert (> (str.len f1) 0))
(assert (> (str.len f2) 0))

; ; Check for proper escaping (no delimiter in fields)
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

(check-sat)
(get-model)
