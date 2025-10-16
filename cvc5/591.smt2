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

(declare-sort var870 0)
(declare-sort var1743 0)
(declare-sort var3350 0)
(declare-sort var2264 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3350-init () var3350)
(declare-fun <init>/-325640736 (var3350) void)
(declare-fun var2264_isEmpty/-153543822 (var2264) Bool)
(declare-fun cast-from-var3350-to-var2264 (var3350) var2264)
(declare-const null-var870 var870)
(declare-const null-String String)
(declare-const var962 var870) ; Statement: r3 := @this: org.springframework.boot.loader.launch.PropertiesLauncher 
(assert (not (= var962 null-var870)))
(declare-const var2232 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2232 null-String)))
(define-const var2113 var3350 var3350-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2113)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2113!1 var3350)
; split operation: var2964 = var2232.split(",") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2128 Int (get_split_length var2232 "," -1)) ; Statement: i0 = lengthof r2 
(define-const var448 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
(assert (>= var448 var2128)) ; Cond: i1 >= i0 
(define-const var2050 Bool (var2264_isEmpty/-153543822 (cast-from-var3350-to-var2264 var2113!1))) ; Statement: $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z0 == 0 goto return $r0 
(assert (= (ite var2050 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r0 
(check-sat)
; {var3350-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var2264_isEmpty/-153543822=([java.util.List], boolean), cast-from-var3350-to-var2264=([java.util.ArrayList], java.util.List)}
; {var870=org.springframework.boot.loader.launch.PropertiesLauncher, var962=r3, var2232=r1, var1743=null_type, var3350=java.util.ArrayList, var2113=$r0, var2964=r2, var2128=i0, var448=i1, var2264=java.util.List, var2050=$z0}
; {org.springframework.boot.loader.launch.PropertiesLauncher=var870, r3=var962, r1=var2232, null_type=var1743, java.util.ArrayList=var3350, $r0=var2113, r2=var2964, i0=var2128, i1=var448, java.util.List=var2264, $z0=var2050}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: org.springframework.boot.loader.launch.PropertiesLauncher;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto $z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	$z0 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	if $z0 == 0 goto return $r0;	return $r0
;block_num 4
(get-model)
