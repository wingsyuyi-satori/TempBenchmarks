(set-info :smt-lib-version 2.6) 
(set-logic QF_SLIA) 
(set-info :source | 
Email validation with stricter constraints 
Focus: Domain structure and local-part format 
|) 

; Declare email string variable 
(declare-const email String) 

; Basic format: must contain exactly one '@' 

; Split into local and domain parts 
(declare-const local String) 
(declare-const domain String) 
(assert (= local (str.split_at email "@" 0))) 
(assert (= domain (str.split_at email "@" 1))) 

; Local part constraints 
; Must be 1-64 chars and not start/end with dot 
(assert (<= 1 (str.len local) 64)) 
(assert (not (str.prefixof "." local))) 
(assert (not (str.suffixof "." local))) 

; Domain must have at least one dot 
(assert (str.contains domain ".")) 

; Split domain into subdomains 
(assert (>= (str.num_splits domain ".") 2)) 

; Each domain segment must be 1-63 chars 
(declare-const domain_seg1 String) 
(declare-const domain_seg2 String) 
(assert (= domain_seg1 (str.split_at domain "." 0))) 
(assert (= domain_seg2 (str.split_rest domain "." 1))) 

(assert (<= 1 (str.len domain_seg1) 63)) 
(assert (<= 1 (str.len domain_seg2) 253)) 

; TLD must be 2+ chars 
(declare-const last_dot_pos Int) 
(assert (>= (- (str.len domain) last_dot_pos) 2)) 

; No consecutive dots anywhere 
(assert (not (str.contains email ".."))) 

(check-sat) 
(get-model)
