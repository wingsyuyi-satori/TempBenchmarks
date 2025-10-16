
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.at (String Int) String)
(declare-fun str.is_base64 (String) Bool)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)

; Constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; JWT token validation constraints
(declare-const jwt_token String)
(declare-const api_key String)

; JWT must have exactly 3 segments when split by dots (header.payload.signature)
(assert (= (str.num_splits jwt_token dot) 3))

; ; Extract JWT segments
(declare-const jwt_header String)
(assert (= jwt_header (str.split_at jwt_token dot 0)))
(declare-const jwt_payload String)
(assert (= jwt_payload (str.split_at jwt_token dot 1)))
(declare-const jwt_signature String)
(assert (= jwt_signature (str.split_at jwt_token dot 2)))

; Header and payload must be valid base64
(assert (str.is_base64 jwt_header))
(assert (str.is_base64 jwt_payload))

; Signature must be non-empty
(assert (> (str.len jwt_signature) 0))

; API key validation constraints
; API key must have exactly 2 segments when split by colon (id:secret)
(assert (= (str.num_splits api_key colon) 2))

; ; Extract API key segments
(declare-const api_id String)
(assert (= api_id (str.split_at api_key colon 0)))
(declare-const api_secret String)
(assert (= api_secret (str.split_at api_key colon 1)))

; API ID must be alphanumeric with dashes (simplified validation)
(assert (> (str.len api_id) 0))
(assert (not (str.contains api_id dot))) ; No dots allowed in ID
(assert (not (str.contains api_id colon))) ; No colons allowed in ID

; API secret must be base64 encoded
(assert (str.is_base64 api_secret))

; Combined authentication scenario
; Either JWT or API key must be valid (but not both)
(declare-const use_jwt Bool)
(assert (or (and use_jwt 
 (> (str.len jwt_token) 0)
 (not (> (str.len api_key) 0)))
 (and (not use_jwt)
 (> (str.len api_key) 0)
 (not (> (str.len jwt_token) 0)))))

; ; Unsatisfiable constraint: token cannot have both JWT and API key format
(declare-const invalid_token String)
(assert (= (str.num_splits invalid_token dot) 3))
(assert (= (str.num_splits invalid_token colon) 2))

(check-sat)
(get-model)
