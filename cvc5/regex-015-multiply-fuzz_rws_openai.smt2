(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation scenario using SMT-LIB2 with split operations.
; Distinct constraints and variables from previous example.
|)

; Declare the email string variable
(declare-const addr String)

; The email address must contain exactly one "@" character
(assert (= (str.num_splits addr "@") 2))

; ; Extract user and host parts
(declare-const user String)
(declare-const host String)
(assert (= user (str.split_at addr "@" 0)))
(assert (= host (str.split_at addr "@" 1)))

; User part must not be empty and must not start or end with "."
(assert (> (str.len user) 0))
(assert (not (= (str.at user 0) ".")))
(assert (not (= (str.at user (- (str.len user) 1)) ".")))

; Host part must have at least two segments when split by "."
(assert (>= (str.num_splits host ".") 2))

; ; Extract the first and last segments of the host (e.g., subdomain and TLD)
(declare-const host_first String)
(declare-const host_last String)
(assert (= host_first (str.split_at host "." 0)))
(assert (= host_last (str.split_at host "." (- (str.num_splits host ".") 1))))

; Both first and last host segments must be non-empty
(assert (> (str.len host_first) 0))
(assert (> (str.len host_last) 0))

; Host must not start or end with a "."
(assert (not (= (str.at host 0) ".")))
(assert (not (= (str.at host (- (str.len host) 1)) ".")))

; ; Example of an unsatisfiable constraint: user part must NOT contain "@" or "."
(assert (not (str.contains user "@")))
(assert (not (str.contains user ".")))

; ; Example of a satisfiable constraint: host must not contain any spaces
(assert (not (str.contains host " ")))

(check-sat)
(exit)
(get-model)
