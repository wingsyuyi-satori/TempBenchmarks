
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declarations
(declare-const jwt String)
(declare-const api_key String)
(declare-const secret String)

; JWT constraints - must have exactly 3 parts separated by '.'
(assert (= (str.num_splits jwt ".") 3))

; ; Extract JWT segments
(define-const header String (str.split_at jwt "." 0))
(define-const payload String (str.split_at jwt "." 1))
(define-const signature String (str.split_at jwt "." 2))

; JWT segment length constraints
(assert (>= (str.len header) 10))
(assert (>= (str.len payload) 10))
(assert (>= (str.len signature) 10))

; API key constraints - must have exactly 4 parts separated by '-'
(assert (= (str.num_splits api_key "-") 4))

; ; Extract API key segments
(define-const api_part1 String (str.split_at api_key "-" 0))
(define-const api_part2 String (str.split_at api_key "-" 1))
(define-const api_part3 String (str.split_at api_key "-" 2))
(define-const api_part4 String (str.split_at api_key "-" 3))

; API key segment constraints
(assert (= (str.len api_part1) 8)) ; First part must be 8 chars
(assert (= (str.len api_part2) 4)) ; Second part must be 4 chars
(assert (= (str.len api_part3) 4)) ; Third part must be 4 chars
(assert (= (str.len api_part4) 12)) ; Fourth part must be 12 chars

; Combined constraints
(assert (distinct header api_part1)) ; JWT header and API first part must differ
(assert (not (str.contains jwt ":"))) ; JWT cannot contain colons
(assert (not (str.contains api_key "."))) ; API key cannot contain dots

; ; Signature verification (simplified example)
(define-const computed_sig String (str.++ header "." payload secret))
(assert (not (= signature computed_sig))) ; Makes problem unsat for correct sigs

(check-sat)
(get-model)
