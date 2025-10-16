(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Generated for: Email validation scenario with alternate constraints and variables
Target: SMT solvers supporting extended string splits
|)
(set-info :category "industrial")
(set-info :status unknown)

; Declare the email variable
(declare-const e String)

; ; Constraint: The email must contain exactly one '@'
(assert (not (= (str.indexof e "@" 0) -1)))

; Split local and domain parts by '@'
(declare-const lp String)
(declare-const dp String)
(assert (= lp (str.split_at e "@" 0)))
(assert (= dp (str.split_at e "@" 1)))

; ; Constraint: Local-part must not start or end with '.'
(assert (not (= (str.at lp 0) ".")))
(assert (not (= (str.at lp (- (str.len lp) 1)) ".")))

; ; Constraint: Domain must have at least two segments separated by '.'
(assert (>= (str.num_splits dp ".") 2))

; ; Extract the first domain segment (subdomain) and the rest (main domain)
(declare-const subdomain String)
(declare-const main_domain String)
(assert (= subdomain (str.split_at dp "." 0)))
(assert (= main_domain (str.split_rest dp "." 1)))

; ; Constraint: Subdomain and main domain must be non-empty
(assert (> (str.len subdomain) 0))
(assert (> (str.len main_domain) 0))

; ; Constraint: Main domain must not start or end with a '.'
(assert (not (= (str.at main_domain 0) ".")))
(assert (not (= (str.at main_domain (- (str.len main_domain) 1)) ".")))

; ; Unsatisfiable constraint: local-part contains '@' (which should be impossible)
(assert (not (str.contains lp "@")))

; ; Satisfiable constraint: domain part does not contain spaces
(assert (not (str.contains dp " ")))

(check-sat)
(exit)
(get-model)
