
(set-logic QF_SLIA)
(set-option :produce-models true)

; String declarations
(declare-const config String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const section String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)

; Sample configuration content
(assert (= config "[database]\nhost=localhost\nport=5432"))

; Split into sections
(assert (= section (str.substr config 1 (- (str.indexof config "]" 0) 1))))
(assert (= (str.split_at config "\n" 0) "[database]"))

; Split lines after section header
(assert (= line1 (str.split_at config "\n" 1)))
(assert (= line2 (str.split_at config "\n" 2)))

; Parse key-value pairs
(assert (= key1 (str.split_at line1 "=" 0)))
(assert (= value1 (str.split_at line1 "=" 1)))
(assert (= key2 (str.split_at line2 "=" 0)))
(assert (= value2 (str.split_at line2 "=" 1)))

; Validation constraints
(assert (= section "database"))
(assert (= key1 "host"))
(assert (= value1 "localhost"))
(assert (= key2 "port"))
(assert (str.is_digit value2)) ; port must be numeric

; ; Check number of splits
(assert (= (str.num_splits config "\n") 3))
(assert (= (str.num_splits line1 "=") 2))
(assert (= (str.num_splits line2 "=") 2))

; Unsatisfiable condition for testing
(assert (not (= (str.len value2) 4))) ; port length not 4

(check-sat)
(get-model)
