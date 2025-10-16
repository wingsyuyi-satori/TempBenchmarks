(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation with stricter domain constraints
Focus: Valid TLDs, local-part character restrictions
|)

; Declare email variable and common delimiters
(declare-const email String)
(define-const at_delim String "@")
(define-const dot_delim String ".")

; Core email structure constraints
(assert (= (str.num_splits email at_delim) 2)) ; Exactly one @
(assert (not (str.contains (str.split_at email at_delim 0) at_delim))) ; No @ in local part
(assert (not (str.contains (str.split_at email at_delim 1) at_delim))) ; No @ in domain

; Local part constraints
(declare-const local String)
(assert (= local (str.split_at email at_delim 0)))
(assert (>= (str.len local) 1)) ; Minimum length 1
(assert (<= (str.len local) 64)) ; RFC 5321 max length

; Domain part constraints
(declare-const domain String)
(assert (= domain (str.split_at email at_delim 1)))
(assert (>= (str.num_splits domain dot_delim) 1)) ; At least one dot
(assert (<= (str.num_splits domain dot_delim) 5)) ; Reasonable max subdomains

; Domain segment constraints
(assert (forall ((i Int))
 (=> (and (>= i 0) (< i (str.num_splits domain dot_delim)))
 (let ((seg (str.split_at domain dot_delim i)))
 (and
 (>= (str.len seg) 1) ; No empty segments
 (not (str.prefixof "-" seg)) ; No leading hyphen
 (not (str.suffixof "-" seg)) ; No trailing hyphen
)
)
)
))

; TLD validation (must be 2+ chars and known TLD)
(declare-const tld String)
(assert (= tld (str.split_at domain dot_delim (- (str.num_splits domain dot_delim) 1))))
(assert (>= (str.len tld) 2))
(assert (or
 (= tld "com")
 (= tld "org")
 (= tld "net")
 (= tld "edu")
 (= tld "gov")
))

; Additional constraints
(assert (not (str.contains email ".."))) ; No consecutive dots
(assert (not (str.contains email "__"))) ; No consecutive underscores
(assert (not (str.contains local " "))) ; No spaces in local part

(check-sat)
(exit)
(get-model)
