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

(declare-sort var3951 0)
(declare-sort var1997 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const null-var1997 var1997)
(declare-const var2425 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2425 null-String)))
(define-const var2347 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(assert true)
(define-const var2113 Int (length/-134980193 var2425)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if i6 >= $i0 goto (branch) 
(assert (>= var2347 var2113)) ; Cond: i6 >= $i0 
 ; Statement: if i6 != 0 goto $i1 = i6 - 1 
(assert (not (not (= var2347 0)))) ; Negate: Cond: i6 != 0  
(define-const var1250 String "") ; Statement: $r6 = "" 
 ; Statement: goto [?= r1 = $r6] 
(assert true) ; Non Conditional
(define-const var1684 String var1250) ; Statement: r1 = $r6 
(define-const var432 var1997 null-var1997) ; Statement: r7 = null 
(assert (and true (and (>= var2347 0) (>= (str.len var2425) var2347))))
(define-const var280 String (substring/850833817 var2425 var2347)) ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6) 
(define-const var1356 Int (cast-from-Int-to-Int -1)) ; Statement: $i9 = (int) -1 
; split operation: var3749 = var280.split("\u005c.", var1356) ; Statement: $r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9) 
(define-const var2880 Int (get_split_length var280 "\u005c." var1356)) ; Statement: $i3 = lengthof $r4 
(define-const var1861 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= $i3 goto return r7 
(assert (>= var1861 var2880)) ; Cond: i7 >= $i3 
 ; Statement: return r7 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), cast-from-Int-to-Int=([int], int)}
; {var2425=r0, var3951=null_type, var2347=i6, var2113=$i0, var1250=$r6, var1684=r1, var1997=org.springframework.javapoet.ClassName, var432=r7, var280=$r2, var1356=$i9, var3749=$r4, var2880=$i3, var1861=i7}
; {r0=var2425, null_type=var3951, i6=var2347, $i0=var2113, $r6=var1250, r1=var1684, org.springframework.javapoet.ClassName=var1997, r7=var432, $r2=var280, $i9=var1356, $r4=var3749, $i3=var2880, i7=var1861}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i6 = 0;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if i6 >= $i0 goto (branch);	if i6 != 0 goto $i1 = i6 - 1;	$r6 = "";	goto [?= r1 = $r6];	r1 = $r6;	r7 = null;	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int)>(i6);	$i9 = (int) -1;	$r4 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i9);	$i3 = lengthof $r4;	i7 = 0;	if i7 >= $i3 goto return r7;	return r7
;block_num 7
(get-model)
