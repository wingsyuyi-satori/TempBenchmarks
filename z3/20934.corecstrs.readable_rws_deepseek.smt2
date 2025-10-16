; SMT-LIB2 script for configuration file parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and variables
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.at (String Int) String)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.indexof (String String Int) Int)
(declare-fun str.replace (String String String) String)
(declare-fun str.prefixof (String String) Bool)
(declare-fun str.suffixof (String String) Bool)

; Custom split operations for configuration parsing
(declare-fun str.split_at (String String Int) String) ; k-th segment after split
(declare-fun str.num_splits (String String) Int) ; total segments after split
(declare-fun str.split_rest (String String Int) String) ; segments from k onwards

; ; Example configuration content
(declare-const config_content String)
(assert (= config_content 
 (str.++ "[Database]\n"
 "host=localhost\n"
 "port:5432\n"
 "\n"
 "[Auth]\n"
 "api_key=abc123\n"
 "timeout=30\n")))

; Test variables
(declare-const db_section String)
(declare-const auth_section String)
(declare-const host_value String)
(declare-const port_value String)
(declare-const api_key_value String)
(declare-const timeout_value String)

; ; Section extraction
(assert (= db_section (str.split_at config_content "[Database]" 1)))
(assert (= auth_section (str.split_at config_content "[Auth]" 1)))

; ; Key-value pair extraction from Database section
(assert (= host_value (str.split_at (str.split_at db_section "host=" 1) "\n" 0)))
(assert (= port_value (str.split_at (str.split_at db_section "port:" 1) "\n" 0)))

; ; Key-value pair extraction from Auth section
(assert (= api_key_value (str.split_at (str.split_at auth_section "api_key=" 1) "\n" 0)))
(assert (= timeout_value (str.split_at (str.split_at auth_section "timeout=" 1) "\n" 0)))

; Validation constraints
(assert (str.prefixof host_value "local")) ; host should start with "local"
(assert (str.contains port_value "5432")) ; port should contain "5432"
(assert (>= (str.len api_key_value) 6)) ; api_key should be at least 6 chars
(assert (str.suffixof timeout_value "30")) ; timeout should end with "30"

; ; Section boundary checks
(assert (str.contains db_section "host="))
(assert (str.contains db_section "port:"))
(assert (str.contains auth_section "api_key="))
(assert (str.contains auth_section "timeout="))

; ; Unsatisfiable constraint example (comment out for satisfiable version)
;(assert (str.contains port_value "8080")) ; This would conflict with earlier port constraint

; ; Check if configuration has exactly 2 sections
(assert (= (str.num_splits config_content "[") 3)) ; 3 because of initial empty segment

; ; Check rest of content after first section
(declare-const after_db String)
(assert (= after_db (str.split_rest config_content "[Database]" 1)))
(assert (str.contains after_db "[Auth]"))

(check-sat)
(get-model)
