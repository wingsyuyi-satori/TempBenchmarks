(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation with alternative constraints using SMT-LIB2
Target: String splitting and segment validation
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare variables for the email address and its components
(declare-const email_addr String)

; ; Constraint: There must be exactly one "@" in the email address
(assert (= (str.num_splits email_addr "@") 2))

; Split email_addr into user and domain segments
(declare-const user_part String)
(declare-const domain_part String)
(assert (= user_part (str.split_at email_addr "@" 0)))
(assert (= domain_part (str.split_at email_addr "@" 1)))

; ; Constraint: user_part must not start or end with "."
(assert (not (= (str.at user_part 0) ".")))
(assert (not (= (str.at user_part (- (str.len user_part) 1)) ".")))

; ; Constraint: user_part must not be empty
(assert (> (str.len user_part) 0))

; ; Constraint: domain_part must contain at least one "."
(assert (>= (str.num_splits domain_part ".") 2))

; Split domain_part into subdomain(s) and tld
(declare-const subdomain String)
(declare-const tld String)
(assert (= subdomain (str.split_at domain_part "." 0)))
(assert (= tld (str.split_at domain_part "." 1)))

; ; Constraint: subdomain and tld must be non-empty
(assert (> (str.len subdomain) 0))
(assert (> (str.len tld) 0))

; ; Constraint: tld must be at least 2 characters long (e.g., "com", "org")
(assert (>= (str.len tld) 2))

; ; Constraint: domain_part must not start or end with "."
(assert (not (= (str.at domain_part 0) ".")))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))

; ; Unsatisfiable constraint: user_part is "admin" and tld is "x" (conflicts with tld length)
(assert (or
 (not (= user_part "admin"))
 (not (= tld "x"))
))

(check-sat)
(get-model)
