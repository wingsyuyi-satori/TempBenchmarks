
; JWT and API key validation with split operations
(set-logic QF_SLIA)

; Declare constants for delimiters
(declare-const dot String)
(assert (= dot "."))
(declare-const dash String)
(assert (= dash "-"))
(declare-const colon String)
(assert (= colon ":"))

; Declare token variables
(declare-const jwt String)
(declare-const api_key String)

; JWT Validation Constraints
; A JWT must have exactly 3 parts separated by dots
(assert (= (str.num_splits jwt dot) 3))

(declare-const jwt_header String)
(declare-const jwt_payload String)
(declare-const jwt_signature String)

; Split JWT into components
(assert (= jwt_header (str.split_at jwt dot 0)))
(assert (= jwt_payload (str.split_at jwt dot 1)))
(assert (= jwt_signature (str.split_at jwt dot 2)))

; Header must be non-empty and start with '{'
(assert (not (= jwt_header "")))
(assert (str.prefixof "{" jwt_header))

; Payload must be non-empty and contain ':'
(assert (not (= jwt_payload "")))
(assert (>= (str.num_splits jwt_payload colon) 1))

; Signature must be exactly 43 chars (base64 encoded)
(assert (= (str.len jwt_signature) 43))

; API Key Validation Constraints
; API key must have 4 parts separated by dashes
(assert (= (str.num_splits api_key dash) 4))

(declare-const api_prefix String)
(declare-const api_id String)
(declare-const api_timestamp String)
(declare-const api_hash String)

; Split API key into components
(assert (= api_prefix (str.split_at api_key dash 0)))
(assert (= api_id (str.split_at api_key dash 1)))
(assert (= api_timestamp (str.split_at api_key dash 2)))
(assert (= api_hash (str.split_at api_key dash 3)))

; Prefix must be "AKIA"
(assert (= api_prefix "AKIA"))

; ID must be 16 uppercase alphanumeric chars
(assert (= (str.len api_id) 16))
(assert (str.is_digit (str.at api_id 0))) ; First char must be digit

; Timestamp must be 10 digits
(assert (= (str.len api_timestamp) 10))
(assert (str.is_digit (str.at api_timestamp 0)))

; Hash must be 32 lowercase hex chars
(assert (= (str.len api_hash) 32))
(assert (str.contains "abcdef" (str.at api_hash 0)))

; ; Combined constraint: JWT and API key must have matching timestamps
(assert (str.contains jwt_payload api_timestamp))

(check-sat)
(exit)
(get-model)
