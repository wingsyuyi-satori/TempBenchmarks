(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with strict validation
 Focus: Field content validation and delimiter handling
|)

; Declare input line and possible delimiters
(declare-const data_line String)
(declare-const delimiter String)

; Constrain delimiter to common CSV/TSV options
(assert (or (= delimiter ",") 
 (= delimiter "\t") 
 (= delimiter ";") 
 (= delimiter "|")))

; Require exactly 4 fields in the record
(assert (= (str.num_splits data_line delimiter) 4))

; ; Extract all fields with proper indexing
(declare-const id_field String)
(declare-const timestamp String)
(declare-const value String)
(declare-const status String)

(assert (= id_field (str.split_at data_line delimiter 0)))
(assert (= timestamp (str.split_at data_line delimiter 1)))
(assert (= value (str.split_at data_line delimiter 2)))
(assert (= status (str.split_at data_line delimiter 3)))

; Field validation constraints
; 1. ID must be alphanumeric and exactly 8 chars
(assert (= (str.len id_field) 8))
(assert (str.is_digit (str.at id_field 0))) ; First char must be digit

; 2. Timestamp must match YYYY-MM-DD pattern
(assert (= (str.len timestamp) 10))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))

; 3. Value must be numeric (integer or decimal)
(assert (or (str.is_digit value)
 (and (> (str.len value) 2)
 (= (str.at value (- (str.len value) 3)) ".")
 (str.is_digit (str.substr value 0 (- (str.len value) 3)))
 (str.is_digit (str.substr value (- (str.len value) 2) 2)))))

; 4. Status must be one of valid options
(assert (or (= status "ACTIVE")
 (= status "PENDING")
 (= status "FAILED")
 (= status "COMPLETE")))

; ; Additional constraint: No empty fields allowed
(assert (and (> (str.len id_field) 0)
 (> (str.len timestamp) 0)
 (> (str.len value) 0)
 (> (str.len status) 0)))

; Verify the last field doesn't contain the delimiter
(assert (not (str.contains status delimiter)))

(check-sat)
(get-model)
