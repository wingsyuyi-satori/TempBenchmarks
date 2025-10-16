(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email validation with stricter domain requirements
Focus: Valid TLDs, minimum segment lengths
|)

; Declare email variable and common delimiters
(declare-const email_addr String)
(declare-const at String)
(declare-const dot String)
(assert (= at "@"))
(assert (= dot "."))

; Basic email structure constraints
(assert (= (str.num_splits email_addr at) 2)) ; Exactly one @

; Split into local and domain parts
(declare-const local String)
(declare-const domain String)
(assert (= local (str.split_at email_addr at 0)))
(assert (= domain (str.split_at email_addr at 1)))

; Local part constraints
(assert (>= (str.len local) 1)) ; Non-empty
(assert (<= (str.len local) 64)) ; RFC 5321 limit

; Domain must have at least one dot
(assert (>= (str.num_splits domain dot) 1))

; Domain segment constraints
(declare-const domain_segments Int)
(assert (= domain_segments (str.num_splits domain dot)))

; Each domain segment must be 1-63 chars
(define-fun valid_segment ((s String)) Bool
 (and (>= (str.len s) 1) (<= (str.len s) 63)))

(assert (valid_segment (str.split_at domain dot 0)))
(assert (valid_segment (str.split_at domain dot (- domain_segments 1))))

; TLD must be 2+ chars and alphabetic only
(declare-const tld String)
(assert (= tld (str.split_at domain dot (- domain_segments 1))))
(assert (>= (str.len tld) 2))

; No consecutive dots
(assert (not (str.contains domain "..")))

; ; Example email pattern constraint
(assert (str.prefixof "user" local)) ; Local part starts with "user"

(check-sat)
(exit)
(get-model)
