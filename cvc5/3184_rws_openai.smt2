(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
SMT-LIB2: Email validation scenario with string split reasoning.
; This file uses different constraints and variables from the previous example.
|)

; Declare the email string variable
(declare-const EMAIL String)

; Split at '@': must have exactly 2 segments (local + domain)
(assert (= (str.num_splits EMAIL "@") 2))

; Define variables for local and domain parts
(declare-const USERNAME String)
(declare-const DOMAIN String)
(assert (= USERNAME (str.split_at EMAIL "@" 0)))
(assert (= DOMAIN (str.split_at EMAIL "@" 1)))

; The username must not be empty and must not start or end with '.'
(assert (> (str.len USERNAME) 0))
(assert (not (= (str.at USERNAME 0) ".")))
(assert (not (= (str.at USERNAME (- (str.len USERNAME) 1)) ".")))

; The domain part must have at least 2 segments (domain + TLD)
(assert (>= (str.num_splits DOMAIN ".") 2))

; ; The first segment of the domain must be at least 2 chars (e.g., "mail" in "mail.example.com")
(declare-const DOMAIN_SEG0 String)
(assert (= DOMAIN_SEG0 (str.split_at DOMAIN "." 0)))
(assert (>= (str.len DOMAIN_SEG0) 2))

; The last segment (TLD) must be at least 2 and at most 4 chars (e.g., "com", "info")
(declare-const TLD String)
(assert (= TLD 
 (str.split_at DOMAIN "." 
 (- (str.num_splits DOMAIN ".") 1)
)
))
(assert (>= (str.len TLD) 2))
(assert (<= (str.len TLD) 4))

; The domain must not start or end with a dot
(assert (not (= (str.at DOMAIN 0) ".")))
(assert (not (= (str.at DOMAIN (- (str.len DOMAIN) 1)) ".")))

; The email must not have multiple '@' in a row (unsatisfiable if present)
(assert (not (str.contains EMAIL "@@")))

; ; Unsatisfiable constraint: USERNAME and DOMAIN must be equal (real emails never have this)
(assert (= USERNAME DOMAIN))

(check-sat)
(exit)
(get-model)
