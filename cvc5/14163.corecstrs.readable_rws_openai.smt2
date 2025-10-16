(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation using string split reasoning.
Delimiters: '@' and '.'
; Scenario: Different constraints and variable names from previous example.
|)
(set-info :license "https://creativecommons.org/licenses/by/4.0/")
(set-info :category "industrial")
(set-info :status unknown)

; Declare the input email string
(declare-const input_email String)

; There must be exactly one "@" in the email
(assert (not (= (str.indexof input_email "@" 0) -1)))
(assert (= (str.num_splits input_email "@") 2))

; Split input_email into user and host sections
(declare-const user_section String)
(declare-const host_section String)
(assert (= user_section (str.split_at input_email "@" 0)))
(assert (= host_section (str.split_at input_email "@" 1)))

; User section must not be empty and must not start or end with '.'
(assert (> (str.len user_section) 0))
(assert (not (= (str.at user_section 0) ".")))
(assert (not (= (str.at user_section (- (str.len user_section) 1)) ".")))

; Host section (the domain) must contain at least one dot
(assert (>= (str.num_splits host_section ".") 2))

; Domain must not start or end with a dot
(assert (not (= (str.at host_section 0) ".")))
(assert (not (= (str.at host_section (- (str.len host_section) 1)) ".")))

; ; Extract the first segment of the domain (subdomain or domain name)
(declare-const domain_first_segment String)
(assert (= domain_first_segment (str.split_at host_section "." 0)))
(assert (> (str.len domain_first_segment) 0))

; ; Extract the last segment of the domain (TLD)
(declare-const tld_segment String)
(declare-const num_domain_segments Int)
(assert (= num_domain_segments (str.num_splits host_section ".")))
(assert (= tld_segment (str.split_at host_section "." (- num_domain_segments 1))))
(assert (>= (str.len tld_segment) 2))

; ; UNSAT example: user section must not contain consecutive dots
(assert (not (str.contains user_section "..")))

; ; SAT example: tld_segment must not be "com"
(assert (not (= tld_segment "com")))

(check-sat)
(exit)
(get-model)
