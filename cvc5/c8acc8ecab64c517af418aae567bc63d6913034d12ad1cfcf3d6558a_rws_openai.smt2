(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation scenario using str.split_at, str.num_splits, str.split_rest.
Delimiters: '@' and '.'
Unique constraint configuration.
|)

; Declare the email variable
(declare-const email_addr String)

; ; Constraint: There must be exactly one '@' in the email address
(assert (= (str.num_splits email_addr "@") 2))

; ; Extract the local and domain parts
(declare-const user_name String)
(declare-const host_part String)
(assert (= user_name (str.split_at email_addr "@" 0)))
(assert (= host_part (str.split_at email_addr "@" 1)))

; ; Constraint: The local part (user_name) must NOT start or end with a dot
(assert (not (= (str.at user_name 0) ".")))
(assert (not (= (str.at user_name (- (str.len user_name) 1)) ".")))

; ; Constraint: The host_part (domain) must contain at least one dot
(assert (>= (str.num_splits host_part ".") 2))

; ; Extract the first and second segments of the domain
(declare-const domain_label String)
(declare-const tld_label String)
(assert (= domain_label (str.split_at host_part "." 0)))
(assert (= tld_label (str.split_at host_part "." 1)))

; ; Constraint: Domain label (before first dot) must be at least 2 characters
(assert (>= (str.len domain_label) 2))

; ; Constraint: TLD label (after first dot) must be alphabetic (simulate: cannot contain digits)
(assert (not (str.contains tld_label "0")))
(assert (not (str.contains tld_label "1")))
(assert (not (str.contains tld_label "2")))
(assert (not (str.contains tld_label "3")))
(assert (not (str.contains tld_label "4")))
(assert (not (str.contains tld_label "5")))
(assert (not (str.contains tld_label "6")))
(assert (not (str.contains tld_label "7")))
(assert (not (str.contains tld_label "8")))
(assert (not (str.contains tld_label "9")))

; ; Unsatisfiable constraint: the email address is empty
(assert (= email_addr ""))

(check-sat)
(get-model)
