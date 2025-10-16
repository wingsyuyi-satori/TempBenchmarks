
(set-logic ALL)
(set-option :produce-models true)

; Declare string sort and operations
(declare-fun str.++ (String String) String)
(declare-fun str.len (String) Int)
(declare-fun str.contains (String String) Bool)
(declare-fun str.substr (String Int Int) String)
(declare-fun str.indexof (String String Int) Int)
(declare-fun str.split_at (String String Int) String)
(declare-fun str.num_splits (String String) Int)
(declare-fun str.split_rest (String String Int) String)
(declare-fun str.at (String Int) String)

; Declare constants for delimiters
(declare-const equals String)
(assert (= equals "="))
(declare-const colon String)
(assert (= colon ":"))
(declare-const newline String)
(assert (= newline "\n"))
(declare-const open_bracket String)
(assert (= open_bracket "["))
(declare-const close_bracket String)
(assert (= close_bracket "]"))

; Variables for configuration parsing
(declare-const config_line String)
(declare-const ini_section String)
(declare-const full_config String)
(declare-const key String)
(declare-const value String)

; ; Example 1: Simple key-value pair parsing
(assert (= config_line "timeout=30"))
(assert (= key (str.split_at config_line equals 0)))
(assert (= value (str.split_at config_line equals 1)))
(assert (>= (str.len key) 1)) ; Key must not be empty
(assert (>= (str.len value) 1)) ; Value must not be empty

; ; Example 2: Alternative delimiter (colon)
(declare-const alt_config String)
(assert (= alt_config "port:8080"))
(assert (or
 (= (str.split_at alt_config equals 0) alt_config) ; No equals in string
 (= (str.split_at alt_config colon 1) "8080")
))

; ; Example 3: INI section parsing
(assert (= ini_section "[database]"))
(assert (str.contains ini_section open_bracket))
(assert (str.contains ini_section close_bracket))
(assert (= (str.split_at ini_section open_bracket 1) "database]"))
(assert (= (str.substr ini_section 1 (- (str.len ini_section) 2)) "database"))

; ; Example 4: Multi-line configuration parsing
(assert (= full_config (str.++ "[server]" newline "host=localhost" newline "port=8080")))
(assert (>= (str.num_splits full_config newline) 2)) ; At least 2 lines
(assert (= (str.split_at full_config newline 0) "[server]"))
(assert (str.contains (str.split_at full_config newline 1) equals))

; ; Example 5: Key validation - no special characters
(assert (not (str.contains key equals)))
(assert (not (str.contains key colon)))
(assert (not (str.contains key newline)))
(assert (not (str.contains key open_bracket)))

; ; Example 6: Unsatisfiable case - malformed section header
(declare-const bad_section String)
(assert (= bad_section "database]"))
(assert (str.contains bad_section close_bracket))
(assert (not (str.contains bad_section open_bracket))) ; Missing opening bracket
(assert (= (str.split_at bad_section open_bracket 0) bad_section)) ; No split possible

; ; Example 7: Value extraction from rest of line
(declare-const long_value String)
(assert (= long_value "path=/usr/local/bin:/usr/bin:/bin"))
(assert (= (str.split_at long_value equals 0) "path"))
(assert (str.contains (str.split_rest long_value equals 1) colon)) ; Rest contains colons

; ; Example 8: Section with multiple key-value pairs
(declare-const db_section String)
(assert (= db_section (str.++ "[database]" newline "host=localhost" newline "port=3306" newline "user=root")))
(assert (= (str.num_splits db_section newline) 4)) ; Section header + 3 key-value pairs
(assert (= (str.split_at (str.split_at db_section newline 1) equals 0) "host"))
(assert (= (str.split_at (str.split_at db_section newline 2) equals 1) "3306"))

; ; Example 9: Empty value case (satisfiable)
(declare-const empty_value String)
(assert (= empty_value "cache_size="))
(assert (= (str.split_at empty_value equals 0) "cache_size"))
(assert (= (str.len (str.split_at empty_value equals 1)) 0)) ; Empty value

; ; Example 10: Unsatisfiable case - line with only delimiter
(declare-const only_delim String)
(assert (= only_delim "="))
(assert (>= (str.len (str.split_at only_delim equals 0)) 1)) ; Requires non-empty key
(assert (>= (str.len (str.split_at only_delim equals 1)) 1)) ; Requires non-empty value

(check-sat)
(get-model)
