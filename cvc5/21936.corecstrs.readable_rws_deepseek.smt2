
; SMT-LIB2 script for token validation with split operations
(set-logic QF_SLIA)
(set-option :produce-models true)

; Declare delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; JWT token validation
(declare-const jwt_token String)
; JWT must have exactly 3 parts when split by dot
(assert (= (str.num_splits jwt_token dot) 3))
(assert (>= (str.len (str.split_at jwt_token dot 0)) 1)) ; header exists
(assert (>= (str.len (str.split_at jwt_token dot 1)) 1)) ; payload exists
(assert (>= (str.len (str.split_at jwt_token dot 2)) 1)) ; signature exists

; API key validation
(declare-const api_key String)
; API key must have prefix and two parts separated by colon
(assert (= (str.num_splits api_key colon) 2))
(assert (str.prefixof "AKIA" (str.split_at api_key colon 0))) ; AWS-like prefix
(assert (= (str.len (str.split_at api_key colon 1)) 32)) ; secret key length

; Session token validation
(declare-const session_token String)
; Session token must have 4 parts separated by dash
(assert (= (str.num_splits session_token dash) 4))
(assert (= (str.len (str.split_at session_token dash 0)) 8)) ; part1 length
(assert (= (str.len (str.split_at session_token dash 1)) 4)) ; part2 length
(assert (= (str.len (str.split_at session_token dash 2)) 4)) ; part3 length
(assert (= (str.len (str.split_at session_token dash 3)) 12)) ; part4 length

; Combined constraints for valid case
(echo "Checking valid token constraints")
(assert (= jwt_token "header.payload.signature"))
(assert (= api_key "AKIA1234:abcdefghijklmnopqrstuvwxyz123456"))
(assert (= session_token "12345678-90ab-cdef-ghijklmnopqr"))
(check-sat)


(get-model)
