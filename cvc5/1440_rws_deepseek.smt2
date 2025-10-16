
(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
CSV validation with multiple delimiters and field constraints
|)

; Declare variables
(declare-const data_row String)
(declare-const delimiter String)

; Possible delimiters: comma, tab, semicolon, pipe
(assert (or (= delimiter ",") 
 (= delimiter "\t") 
 (= delimiter ";") 
 (= delimiter "|")))

; ; Constraint: row must contain exactly 5 fields
(assert (= (str.num_splits data_row delimiter) 5))

; ; Extract all fields
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(assert (= field0 (str.split_at data_row delimiter 0)))
(assert (= field1 (str.split_at data_row delimiter 1)))
(assert (= field2 (str.split_at data_row delimiter 2)))
(assert (= field3 (str.split_at data_row delimiter 3)))
(assert (= field4 (str.split_at data_row delimiter 4)))

; Field constraints:
; Field0 must be numeric (digits only)
(assert (str.is_digit field0))

; Field1 cannot be empty
(assert (> (str.len field1) 0))

; Field2 must be either "active" or "inactive"
(assert (or (= field2 "active") (= field2 "inactive")))

; Field3 must contain exactly one '@' (email validation)
(assert (= (str.len (str.replace_all field3 "@" "")) 
 (- (str.len field3) 1)))

; Field4 must be empty or "NA"
(assert (or (= field4 "") (= field4 "NA")))

; ; Additional constraint: no field can contain the delimiter
(assert (not (str.contains field0 delimiter)))
(assert (not (str.contains field1 delimiter)))
(assert (not (str.contains field2 delimiter)))
(assert (not (str.contains field3 delimiter)))
(assert (not (str.contains field4 delimiter)))

(check-sat)
(get-model)
