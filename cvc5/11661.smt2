(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var2436 0)
(declare-sort var345 0)
(declare-sort var2402 0)
(declare-sort var887 0)
(declare-sort var2407 0)
(declare-sort var1928 0)
(declare-sort var2064 0)
(declare-sort var2133 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2407-init () var2407)
(declare-fun charset/-811599492 (var887) var1928)
(declare-fun <init>/-1518332612 (var2407 var2064 var1928) void)
(declare-fun cast-from-var345-to-var2064 (var345) var2064)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun read/-1845806611 (var2133 (Array Int Int)) Int)
(declare-fun cast-from-var2407-to-var2133 (var2407) var2133)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2436 var2436)
(declare-const null-var345 var345)
(declare-const null-var2402 var2402)
(declare-const null-var887 var887)
(declare-const var1820 var2436) ; Statement: r14 := @this: org.apache.poi.poifs.macros.VBAMacroReader 
(assert (not (= var1820 null-var2436)))
(declare-const var156 var345) ; Statement: r1 := @parameter0: org.apache.poi.poifs.filesystem.DocumentInputStream 
(assert (not (= var156 null-var345)))
(declare-const var3458 var2402) ; Statement: r15 := @parameter1: java.util.Map 
(assert (not (= var3458 null-var2402)))
(declare-const var2205 var887) ; Statement: r2 := @parameter2: org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap 
(assert (not (= var2205 null-var887)))
(define-const var1073 var2407 var2407-init) ; Statement: $r0 = new java.io.InputStreamReader 
(define-const var209 var1928 (charset/-811599492 var2205)) ; Statement: $r3 = r2.<org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap: java.nio.charset.Charset charset> 
(assert true)
;(assert (<init>/-1518332612 var1073 (cast-from-var345-to-var2064 var156) var209)) ; Statement: specialinvoke $r0.<java.io.InputStreamReader: void <init>(java.io.InputStream,java.nio.charset.Charset)>(r1, $r3) 

(declare-const var1073!1 var2407)
(declare-const var156!1 var345)
(declare-const var209!1 var1928)
(define-const var3067 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3067)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3067!1 String)
(assert (= var3067!1 ""))
(define-const var2498 (Array Int Int) arr-Int-init) ; Statement: r5 = newarray (char)[512] 
(assert true) ; Non Conditional
(assert true)
(define-const var1610 Int (read/-1845806611 (cast-from-var2407-to-var2133 var1073!1) var2498)) ; Statement: $i0 = virtualinvoke $r0.<java.io.InputStreamReader: int read(char[])>(r5) 
 ; Statement: if $i0 < 0 goto r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (< var1610 0)) ; Cond: $i0 < 0 
(assert true)
(define-const var423 String (toString/-2075883882 var3067!1)) ; Statement: r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
; split operation: var490 = var423.split("\r\n|\n\r") ; Statement: r7 = virtualinvoke r6.<java.lang.String: java.lang.String[] split(java.lang.String)>("\r\n|\n\r") 
(define-const var1128 Int (get_split_length var423 "\r\n|\n\r" -1)) ; Statement: i1 = lengthof r7 
(define-const var972 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
 ; Statement: if i10 >= i1 goto return 
(assert (>= var972 var1128)) ; Cond: i10 >= i1 
 ; Statement: return 
(check-sat)
; {var2407-init=([], java.io.InputStreamReader), charset/-811599492=([org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap], java.nio.charset.Charset), <init>/-1518332612=([java.io.InputStreamReader, java.io.InputStream, java.nio.charset.Charset], void), cast-from-var345-to-var2064=([org.apache.poi.poifs.filesystem.DocumentInputStream], java.io.InputStream), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-Int-init=([], char[]), read/-1845806611=([java.io.Reader, char[]], int), cast-from-var2407-to-var2133=([java.io.InputStreamReader], java.io.Reader), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2436=org.apache.poi.poifs.macros.VBAMacroReader, var1820=r14, var345=org.apache.poi.poifs.filesystem.DocumentInputStream, var156=r1, var2402=java.util.Map, var3458=r15, var887=org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap, var2205=r2, var2407=java.io.InputStreamReader, var1073=$r0, var1928=java.nio.charset.Charset, var209=$r3, var2064=java.io.InputStream, var3067=$r4, var2498=r5, var2133=java.io.Reader, var1610=$i0, var423=r6, var490=r7, var1128=i1, var972=i10}
; {org.apache.poi.poifs.macros.VBAMacroReader=var2436, r14=var1820, org.apache.poi.poifs.filesystem.DocumentInputStream=var345, r1=var156, java.util.Map=var2402, r15=var3458, org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap=var887, r2=var2205, java.io.InputStreamReader=var2407, $r0=var1073, java.nio.charset.Charset=var1928, $r3=var209, java.io.InputStream=var2064, $r4=var3067, r5=var2498, java.io.Reader=var2133, $i0=var1610, r6=var423, r7=var490, i1=var1128, i10=var972}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r14 := @this: org.apache.poi.poifs.macros.VBAMacroReader;	r1 := @parameter0: org.apache.poi.poifs.filesystem.DocumentInputStream;	r15 := @parameter1: java.util.Map;	r2 := @parameter2: org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap;	$r0 = new java.io.InputStreamReader;	$r3 = r2.<org.apache.poi.poifs.macros.VBAMacroReader$ModuleMap: java.nio.charset.Charset charset>;	specialinvoke $r0.<java.io.InputStreamReader: void <init>(java.io.InputStream,java.nio.charset.Charset)>(r1, $r3);	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	r5 = newarray (char)[512];	$i0 = virtualinvoke $r0.<java.io.InputStreamReader: int read(char[])>(r5);	if $i0 < 0 goto r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	r7 = virtualinvoke r6.<java.lang.String: java.lang.String[] split(java.lang.String)>("\r\n|\n\r");	i1 = lengthof r7;	i10 = 0;	if i10 >= i1 goto return;	return
;block_num 5
(get-model)
