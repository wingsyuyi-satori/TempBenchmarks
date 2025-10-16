
; SMT-LIB2 script for JWT and API key validation
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)
(declare-fun is_base64 (String) Bool)

; Declare variables
(declare-const jwt_token String)
(declare-const api_key String)
(declare-const expected_signature String)

; JWT constraints (3 segments separated by '.')
(assert (= (str.num_splits jwt_token ".") 3))
(assert (is_base64 (str.split_at jwt_token "." 0))) ; Header must be base64
(assert (is_base64 (str.split_at jwt_token "." 1))) ; Payload must be base64
(assert (not (is_base64 (str.split_at jwt_token "." 2)))) ; Signature is raw bytes

; Signature verification constraint
(assert (= (str.split_at jwt_token "." 2) expected_signature))

; API key constraints (3 segments separated by '-')
(assert (= (str.num_splits api_key "-") 3))
(assert (= (str.len (str.split_at api_key "-" 0)) 8)) ; First segment 8 chars
(assert (= (str.len (str.split_at api_key "-" 1)) 6)) ; Second segment 6 chars
(assert (= (str.len (str.split_at api_key "-" 2)) 4)) ; Third segment 4 chars

; Combined constraints (satisfiable case)
(assert (str.contains (str.split_at jwt_token "." 1) "admin:true"))
(assert (str.prefixof "ak_" (str.split_at api_key "-" 0)))

; Additional unsatisfiable constraints (commented out)
; (assert (= (str.num_splits jwt_token ".") 2)) ; Would conflict with earlier constraint
; (assert (str.contains (str.split_rest api_key "-" 1) "xyz")) ; Would make unsat

; ; Time-based validation example
(declare-const timestamp String)
(assert (= (str.num_splits timestamp ":") 3)) ; HH:MM:SS format
(assert (>= (str.to_int (str.split_at timestamp ":" 0)) 0))
(assert (<= (str.to_int (str.split_at timestamp ":" 0)) 23))
(assert (>= (str.to_int (str.split_at timestamp ":" 1)) 0))
(assert (<= (str.to_int (str.split_at timestamp ":" 1)) 59))

(check-sat)
(exit)
(get-model)
