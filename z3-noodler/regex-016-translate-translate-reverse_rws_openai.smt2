(set-logic QF_SLIA)

; Alternative email validation scenario with different constraints and variable names

; Declare the email string
(declare-const email_address String)

; The email must contain exactly one '@' symbol (splits into 2 segments)
(assert (= (str.num_splits email_address "@") 2))

; ; Extract username and domain parts
(declare-const username String)
(declare-const domain String)
(assert (= username (str.split_at email_address "@" 0)))
(assert (= domain (str.split_at email_address "@" 1)))

; The username must be non-empty and must not contain '.'
(assert (> (str.len username) 0))
(assert (not (str.contains username ".")))

; The domain must contain at least one '.' (splits into at least 2 segments)
(assert (>= (str.num_splits domain ".") 2))

; ; Extract the first domain segment (subdomain) and the rest (TLD and any sub-TLDs)
(declare-const subdomain String)
(declare-const tld_chain String)
(assert (= subdomain (str.split_at domain "." 0)))
(assert (= tld_chain (str.split_rest domain "." 1)))

; The subdomain must be non-empty and does not contain '@'
(assert (> (str.len subdomain) 0))
(assert (not (str.contains subdomain "@")))

; The tld_chain must not be empty and must contain at least one '.'
(assert (> (str.len tld_chain) 0))
(assert (str.contains tld_chain "."))

; The email must not start or end with '@'
(assert (not (= (str.at email_address 0) "@")))
(assert (not (= (str.at email_address (- (str.len email_address) 1)) "@")))

; The username must not contain '@' (redundant, but for clarity)
(assert (not (str.contains username "@")))

; ; Unsatisfiable constraint: the domain is exactly "com" (which would violate the domain structure constraints above)
(assert (= domain "com"))

(check-sat)
(exit)
(get-model)
