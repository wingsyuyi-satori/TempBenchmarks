(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation with stricter domain requirements
Focus: Valid TLDs, minimum segment lengths
|)

; Declare email string variable
(declare-const email_addr String)

; Core email constraints
(assert (str.contains email_addr "@")) ; Must contain @
(assert (not (str.contains email_addr ".."))) ; No consecutive dots
(assert (not (str.prefixof "." email_addr))) ; Cannot start with dot
(assert (not (str.suffixof "." email_addr))) ; Cannot end with dot

; Split into local and domain parts
(assert (= (str.num_splits email_addr "@") 2))
(declare-const local String)
(declare-const domain String)
(assert (= local (str.split_at email_addr "@" 0)))
(assert (= domain (str.split_at email_addr "@" 1)))

; Local part constraints
(assert (>= (str.len local) 1)) ; Minimum length 1
(assert (not (str.contains local " "))) ; No spaces allowed

; Domain part constraints
(assert (>= (str.num_splits domain ".") 1)) ; At least one dot
(assert (<= (str.num_splits domain ".") 5)) ; At most 5 segments

; ; Extract and validate TLD (last segment)
(declare-const tld String)
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len tld) 2)) ; TLD minimum length 2
(assert (<= (str.len tld) 6)) ; TLD maximum length 6

; ; Validate common TLDs
(assert (or
 (= tld "com")
 (= tld "org")
 (= tld "net")
 (= tld "edu")
 (= tld "gov")
 (str.prefixof "co." tld) ; Country codes like co.uk
 (str.prefixof "com." tld) ; Multi-level TLDs
))

; ; Validate domain segments are not empty
(declare-const domain_seg1 String)
(declare-const domain_seg2 String)
(assert (= domain_seg1 (str.split_at domain "." 0)))
(assert (>= (str.len domain_seg1) 1))
(assert (=> (>= (str.num_splits domain ".") 2)
 (and
 (= domain_seg2 (str.split_at domain "." 1))
 (>= (str.len domain_seg2) 1)
)
))

(check-sat)
(get-model)
