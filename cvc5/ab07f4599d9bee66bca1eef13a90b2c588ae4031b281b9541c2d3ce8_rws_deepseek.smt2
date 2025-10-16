(set-info :smt-lib-version 2.6) 
(set-logic QF_SLIA) 
(set-info :source | 
CSV/TSV processing with strict validation 
Focus: Field count, empty fields, and delimiter handling 
|) 

; Declare variables 
(declare-const data_row String) 
(declare-const delimiter String) 

; Restrict to common CSV/TSV delimiters 
(assert (or (= delimiter ",") 
 (= delimiter "\t") 
 (= delimiter ";") 
 (= delimiter "|"))) 

; Ensure row is non-empty 
(assert (> (str.len data_row) 0)) 

; Field count validation (5-8 fields expected) 
(declare-const num_fields Int) 
(assert (= num_fields (str.num_splits data_row delimiter))) 
(assert (and (>= num_fields 5) (<= num_fields 8))) 

; ; Extract specific fields with constraints
(declare-const id_field String) 
(declare-const date_field String) 
(declare-const amount_field String) 

(assert (= id_field (str.split_at data_row delimiter 0))) 
(assert (= date_field (str.split_at data_row delimiter 1))) 
(assert (= amount_field (str.split_at data_row delimiter 2))) 

; ID must be non-empty and alphanumeric 
(assert (> (str.len id_field) 0)) 
(assert (str.is_digit id_field)) ; Simplified for example 

; Date field format: YYYY-MM-DD 
(assert (= (str.len date_field) 10)) 
(assert (= (str.at date_field 4) "-")) 
(assert (= (str.at date_field 7) "-")) 

; Amount must be numeric (allow empty) 
(assert (or (= (str.len amount_field) 0) 
 (str.is_digit amount_field))) 

; Last field must not be empty 
(declare-const last_field String) 
(assert (= last_field (str.split_at data_row delimiter (- num_fields 1)))) 
(assert (> (str.len last_field) 0)) 

; ; Check for proper escaping (no unescaped delimiters in fields)
(assert (not (str.contains id_field delimiter))) 
(assert (not (str.contains date_field delimiter))) 

(check-sat) 
(exit)
(get-model)
