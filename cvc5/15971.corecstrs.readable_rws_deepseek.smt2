
; Configuration parsing with key-value pairs and INI sections
(set-logic QF_SLIA)

; String constants for delimiters
(declare-const eq_delim String)
(declare-const colon_delim String)
(declare-const nl_delim String)
(declare-const sec_open String)
(declare-const sec_close String)

(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= sec_open "["))
(assert (= sec_close "]"))

; Sample configuration content
(declare-const config String)
(assert (= config (str.++ 
 "[database]" nl_delim
 "host=localhost" nl_delim
 "port=5432" nl_delim
 "[logging]" nl_delim
 "level=info" nl_delim
)))

; ; Extract first section name
(declare-const db_section String)
(assert (= db_section 
 (str.split_at 
 (str.split_at config sec_open 1) 
 sec_close 0)))

; ; Extract host value from database section
(declare-const host_line String)
(assert (= host_line (str.split_at config nl_delim 1)))

(declare-const host_value String)
(assert (= host_value (str.split_at host_line eq_delim 1)))

; ; Extract port value from database section
(declare-const port_line String)
(assert (= port_line (str.split_at config nl_delim 2)))

(declare-const port_value String)
(assert (= port_value (str.split_at port_line eq_delim 1)))

; Section handling constraints
(assert (= (str.num_splits config sec_open) 3)) ; 2 sections

; ; Validate section names
(assert (= db_section "database"))
(assert (= (str.split_at 
 (str.split_at (str.split_at config sec_open 2) sec_close 0) 
 nl_delim 0) "logging"))

; ; Key validation - simple check for non-empty
(assert (not (= (str.split_at host_line eq_delim 0) "")))
(assert (not (= (str.split_at port_line eq_delim 0) "")))

; Value validation
(assert (= host_value "localhost"))
(assert (or (= port_value "5432") (= port_value "3306")))

; ; Unsatisfiable constraint example
(assert (not (and 
 (= (str.split_at config sec_open 1) "database]")
 (= (str.split_at config sec_open 1) "logging]")
)))

(check-sat)
(get-model)
