(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
 CSV/TSV processing with different delimiters and constraints
 Focus: Field validation and multi-delimiter support
|)

; Declare variables for different CSV formats
(declare-const csv_comma String) ; Standard CSV
(declare-const csv_tab String) ; TSV
(declare-const csv_pipe String) ; Pipe-delimited
(declare-const csv_semi String) ; Semicolon-delimited

; Common constraints for all formats
(assert (>= (str.len csv_comma) 5))
(assert (>= (str.len csv_tab) 5))
(assert (>= (str.len csv_pipe) 5))
(assert (>= (str.len csv_semi) 5))

; ; Field extraction functions
(define-fun get_first_field ((x String) (delim String)) String
 (str.split_at x delim 0))

(define-fun count_fields ((x String) (delim String)) Int
 (str.num_splits x delim))

; Specific format constraints

; 1. Comma-delimited CSV must have exactly 5 fields
(assert (= (count_fields csv_comma ",") 5))

; First field cannot be empty
(assert (> (str.len (get_first_field csv_comma ",")) 0))

; 2. Tab-delimited must have between 3-7 fields
(assert (>= (count_fields csv_tab "\t") 3))
(assert (<= (count_fields csv_tab "\t") 7))

; ; Last field must be numeric (simplified check)
(declare-const tsv_last_field String)
(assert (= tsv_last_field (str.split_at csv_tab "\t" (- (count_fields csv_tab "\t") 1))))
(assert (str.is_digit tsv_last_field))

; 3. Pipe-delimited validation
(assert (= (count_fields csv_pipe "|") 4))

; Second field must be "ACTIVE" or "INACTIVE"
(declare-const pipe_status String)
(assert (= pipe_status (str.split_at csv_pipe "|" 1)))
(assert (or (= pipe_status "ACTIVE") (= pipe_status "INACTIVE")))

; 4. Semicolon-delimited special case
; Must have exactly 3 fields where first and last are non-empty
(assert (= (count_fields csv_semi ";") 3))
(assert (> (str.len (get_first_field csv_semi ";")) 0))
(assert (> (str.len (str.split_at csv_semi ";" 2)) 0))

; ; Cross-format constraint: At least one format must have an empty middle field
(assert (or
 (= (str.len (str.split_at csv_comma "," 2)) 0)
 (= (str.len (str.split_at csv_tab "\t" 1)) 0)
 (= (str.len (str.split_at csv_pipe "|" 1)) 0)
 (= (str.len (str.split_at csv_semi ";" 1)) 0)
))

(check-sat)
(exit)
(get-model)
