
; SMT-LIB2 file for JWT and API key validation
; Using delimiters: '.', '-', ':'
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.contains (String String) Bool)
(declare-fun str.prefixof (String String) Bool)
(declare-fun str.suffixof (String String) Bool)
(declare-fun str.len (String) Int)
(declare-fun str.at (String Int) String)
(declare-fun str.is_base64 (String) Bool)
(declare-fun str.is_alphanum (String) Bool)

; Custom split operations
(define-fun str.split_at ((x String) (d String) (k Int)) String
 (ite (= k 0)
 (ite (str.contains x d)
 (str.substr x 0 (str.indexof x d 0))
 x)
 (str.split_at (str.substr x (+ (str.indexof x d 0) 1) (str.len x)) d (- k 1))))

(define-fun str.num_splits ((x String) (d String)) Int
 (ite (str.contains x d)
 (+ 1 (str.num_splits (str.substr x (+ (str.indexof x d 0) 1) (str.len x)) d))
 1))

(define-fun str.split_rest ((x String) (d String) (k Int)) String
 (ite (= k 0)
 x
 (str.split_rest (str.substr x (+ (str.indexof x d 0) 1) (str.len x)) d (- k 1))))

; JWT validation constraints
(declare-const jwt String)
(declare-const header String)
(declare-const payload String)
(declare-const signature String)

; JWT must have exactly 3 parts separated by '.'
(assert (= (str.num_splits jwt ".") 3))
(assert (= header (str.split_at jwt "." 0)))
(assert (= payload (str.split_at jwt "." 1)))
(assert (= signature (str.split_at jwt "." 2)))

; Header and payload must be valid base64
(assert (str.is_base64 header))
(assert (str.is_base64 payload))

; Signature must be at least 32 chars (minimum for HS256)
(assert (>= (str.len signature) 32))

; API key validation constraints
(declare-const api_key String)
(declare-const prefix String)
(declare-const key_id String)
(declare-const secret String)

; API key must have format "PREFIX-KEYID:SECRET"
(assert (= (str.num_splits api_key "-") 2))
(assert (= prefix (str.split_at api_key "-" 0)))
(assert (= (str.split_rest api_key "-" 1) (str.++ key_id ":" secret)))

; Key ID must be 8 alphanumeric chars
(assert (= (str.num_splits (str.split_rest api_key "-" 1) ":") 2))
(assert (= (str.len key_id) 8))
(assert (str.is_alphanum key_id))

; Secret must be at least 16 chars and base64
(assert (>= (str.len secret) 16))
(assert (str.is_base64 secret))

; Prefix must be one of known values
(assert (or (= prefix "PROD") (= prefix "TEST") (= prefix "DEV")))

; Negative test case: Invalid JWT with only 2 segments
(declare-const bad_jwt String)
(assert (= (str.num_splits bad_jwt ".") 2))

; ; Check satisfiability of valid cases
(check-sat)


(exit)
(get-model)
