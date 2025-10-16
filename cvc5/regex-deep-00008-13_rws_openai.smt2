; SMT-LIB2 file for Configuration Parsing (Key-Value and INI style)
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; ; Declare string variables representing configuration lines and extracted parts
(declare-fun conf_line1 () String)
(declare-fun conf_line2 () String)
(declare-fun section_header () String)
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun section_name () String)

; ; Example 1: key-value pair extraction using '='
; conf_line1 = "username=admin"
(assert (= conf_line1 "username=admin"))

; key1 is the part before '='
(assert (= key1 (str.split_at conf_line1 "=" 0)))
; value1 is the part after '='
(assert (= value1 (str.split_at conf_line1 "=" 1)))

; Key validation: key1 must not be empty and must not contain whitespace
(assert (not (= key1 "")))
(assert (not (str.contains key1 " ")))

; ; Value extraction: value1 must be at least 3 characters
(assert (>= (str.len value1) 3))

; ; Example 2: key-value pair extraction using ':'
; conf_line2 = "port:8080"
(assert (= conf_line2 "port:8080"))

; key2 is the part before ':'
(assert (= key2 (str.split_at conf_line2 ":" 0)))
; value2 is the part after ':'
(assert (= value2 (str.split_at conf_line2 ":" 1)))

; Key validation: key2 must be "port"
(assert (= key2 "port"))
; ; Value extraction: value2 must be all digits and length 4 (for "8080")
(assert (= (str.len value2) 4))
(assert (str.contains "0123456789" (str.at value2 0)))
(assert (str.contains "0123456789" (str.at value2 1)))
(assert (str.contains "0123456789" (str.at value2 2)))
(assert (str.contains "0123456789" (str.at value2 3)))

; ; Example 3: Section handling with '[section]'
; section_header = "[database]"
(assert (= section_header "[database]"))

; ; Extract section name between '[' and ']'
; First, remove '['
(assert (= section_name (str.split_at (str.split_rest section_header "[" 1) "]" 0)))
; Section name must not be empty
(assert (not (= section_name "")))
; Section name must not contain ']'
(assert (not (str.contains section_name "]")))

; ; Example 4: Key-value lines in a section separated by '\n'
(declare-fun section_block () String)
; section_block = "host=127.0.0.1\nport:5432"
(assert (= section_block "host=127.0.0.1\nport:5432"))

; Split section_block into lines
(declare-fun lineA () String)
(declare-fun lineB () String)
(assert (= lineA (str.split_at section_block "\n" 0)))
(assert (= lineB (str.split_at section_block "\n" 1)))

; lineA should start with "host="
(assert (str.prefixof "host=" lineA))
; ; Extract host value after '='
(declare-fun host_val () String)
(assert (= host_val (str.split_at lineA "=" 1)))
; host_val should be "127.0.0.1"
(assert (= host_val "127.0.0.1"))

; lineB should be "port:5432"
(assert (= lineB "port:5432"))
; ; Extract port value after ':'
(declare-fun port_val () String)
(assert (= port_val (str.split_at lineB ":" 1)))
; port_val should be "5432"
(assert (= port_val "5432"))

; ; Example 5: Section block with multiple lines: check number of splits
; There should be 2 lines after splitting by '\n'
(assert (= (str.num_splits section_block "\n") 2))

; ; Example 6: Unsatisfiable combination: key contains whitespace (should be impossible)
(declare-fun bad_line () String)
(declare-fun bad_key () String)
; bad_line = "user name=alice"
(assert (= bad_line "user name=alice"))
(assert (= bad_key (str.split_at bad_line "=" 0)))
; Assert key validation: bad_key must NOT contain whitespace, but here it does, so it's UNSAT
(assert (not (str.contains bad_key " ")))

; ; Example 7: Unsatisfiable: value after '=' is empty
(declare-fun empty_val_line () String)
(declare-fun empty_val () String)
(assert (= empty_val_line "password="))
(assert (= empty_val (str.split_at empty_val_line "=" 1)))
; Assert value must be non-empty, but here it's empty, so UNSAT
(assert (not (= empty_val "")))

(check-sat)
(exit)
(get-model)
