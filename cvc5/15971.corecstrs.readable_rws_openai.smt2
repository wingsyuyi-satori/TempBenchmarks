(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)

; Email validation scenario with alternative constraints

; Declare the email string
(declare-const email_addr String)

; Assert that the email contains exactly one "@" symbol
(assert (= (str.num_splits email_addr "@") 2))

; Split into user and domain
(declare-const user String)
(declare-const domain String)
(assert (= user (str.split_at email_addr "@" 0)))
(assert (= domain (str.split_at email_addr "@" 1)))

; User part must start and end with a non-delimiter character (no leading/trailing ".")
(assert (not (= (str.at user 0) ".")))
(assert (not (= (str.at user (- (str.len user) 1)) ".")))

; User part must be at least 2 characters long
(assert (>= (str.len user) 2))

; Domain must contain a dot (i.e., at least two segments when split by ".")
(assert (>= (str.num_splits domain ".") 2))

; ; Extract the first domain label and the rest
(declare-const domain_label String)
(declare-const domain_rest String)
(assert (= domain_label (str.split_at domain "." 0)))
(assert (= domain_rest (str.split_rest domain "." 1)))

; Domain label must not be empty
(assert (> (str.len domain_label) 0))

; TLD (the last segment after ".") must be at least 2 characters and all lowercase
(declare-const tld String)
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))

; ; Unsatisfiable constraint: force the entire email to contain a space
(assert (str.contains email_addr " "))

(check-sat)
(get-model)
