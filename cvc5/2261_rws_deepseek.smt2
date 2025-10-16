
(set-logic QF_SLIA)
(set-info :smt-lib-version 2.6)
(set-info :category "industrial")

; Declare input CSV line
(declare-const csv_line String)

; Declare field variables
(declare-const header String)
(declare-const first_name String)
(declare-const last_name String)
(declare-const email String)
(declare-const remaining_fields String)

; Basic CSV constraints using comma delimiter
(assert (>= (str.num_splits csv_line ",") 4)) ; At least 4 fields

; Split into fields
(assert (= header (str.split_at csv_line "," 0)))
(assert (= first_name (str.split_at csv_line "," 1)))
(assert (= last_name (str.split_at csv_line "," 2)))
(assert (= email (str.split_at csv_line "," 3)))
(assert (= remaining_fields (str.split_rest csv_line "," 4)))

; Field validation
(assert (str.contains header "ID")) ; Header must contain ID
(assert (> (str.len first_name) 0)) ; First name not empty
(assert (> (str.len last_name) 0)) ; Last name not empty
(assert (str.contains email "@")) ; Email must contain @

; No empty fields in first 4 positions
(assert (not (= first_name "")))
(assert (not (= last_name "")))
(assert (not (= email "")))

; Alternative pipe-delimited version
(declare-const pipe_line String)
(assert (= (str.num_splits pipe_line "|") 3))
(assert (> (str.len (str.split_at pipe_line "|" 0)) 0))
(assert (> (str.len (str.split_at pipe_line "|" 1)) 0))

(check-sat)
(get-model)
