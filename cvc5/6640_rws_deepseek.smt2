
(set-logic QF_SLIA)
(set-option :produce-models true)

; String declarations
(declare-const config_str String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; Delimiter declarations
(declare-const eq_delim String)
(declare-const colon_delim String)
(declare-const nl_delim String)
(declare-const sec_open String)
(declare-const sec_close String)

; Define delimiters as string constants
(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= sec_open "["))
(assert (= sec_close "]"))

; Sample configuration content
(assert (= config_str (str.++ 
 "[database]" nl_delim
 "host=localhost" nl_delim
 "port:5432" nl_delim
 "[auth]" nl_delim
 "api_key=secret123" nl_delim)))

; Split into lines
(assert (= line1 (str.split_at config_str nl_delim 0)))
(assert (= line2 (str.split_at config_str nl_delim 1)))
(assert (= line3 (str.split_at config_str nl_delim 2)))

; Section header validation
(assert (str.prefixof sec_open line1))
(assert (str.suffixof sec_close line1))

; Key-value pair processing
(declare-const host_key String)
(declare-const host_val String)
(assert (= host_key (str.split_at line2 eq_delim 0)))
(assert (= host_val (str.split_at line2 eq_delim 1)))

; Alternative delimiter processing
(declare-const port_key String)
(declare-const port_val String)
(assert (= port_key (str.split_at line3 colon_delim 0)))
(assert (= port_val (str.split_at line3 colon_delim 1)))

; Key validation constraints
(assert (not (str.contains host_key " ")))
(assert (not (str.contains port_key " ")))

; Value constraints
(assert (= host_val "localhost"))
(assert (= port_val "5432"))

; Count total lines
(declare-const line_count Int)
(assert (= line_count (str.num_splits config_str nl_delim)))
(assert (= line_count 5))

; ; Section content extraction
(declare-const auth_section String)
(assert (= auth_section (str.split_rest config_str nl_delim 3)))

; Verify auth section contains api_key
(assert (str.contains auth_section "api_key"))

(check-sat)
(exit)
(get-model)
