(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
SMT-LIB2 file for Email Validation using split operations
Delimiters: '@', '.'
Different constraints and variable choices
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare the email variable
(declare-const candidate_email String)

; The email must have exactly one '@' symbol
(assert (not (= (str.indexof candidate_email "@" 0) -1)))

; The '@' cannot be the first or last character
(assert (> (str.indexof candidate_email "@" 0) 0))
(assert (< (str.indexof candidate_email "@" 0) (- (str.len candidate_email) 1)))

; Split into user and domain parts
(declare-const user String)
(declare-const domain String)
(assert (= user (str.split_at candidate_email "@" 0)))
(assert (= domain (str.split_at candidate_email "@" 1)))

; User part must not contain '.'
(assert (= (str.indexof user "." 0) -1))

; Domain part must have exactly one dot
(assert (= (str.num_splits domain ".") 2))

; ; Extract subdomain and suffix from domain
(declare-const subdomain String)
(declare-const suffix String)
(assert (= subdomain (str.split_at domain "." 0)))
(assert (= suffix (str.split_at domain "." 1)))

; Subdomain and suffix must be non-empty
(assert (> (str.len subdomain) 0))
(assert (> (str.len suffix) 1))

; The suffix must not contain '.'
(assert (= (str.indexof suffix "." 0) -1))

; ; Unsatisfiable constraint: user part is empty AND subdomain is empty
(assert (not (and (= user "") (= subdomain ""))))

(check-sat)
(get-model)
