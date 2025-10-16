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

(declare-sort var2917 0)
(declare-sort var1350 0)
(declare-sort var1752 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var2917) var1752)
(declare-fun getColumnSize/-165698927 (var1752) Int)
(declare-const null-var2917 var2917)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var651 var2917) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var651 null-var2917)))
(declare-const var1047 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var1047 null-String)))
(declare-const var3917 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var3917 null-Int)))
(declare-const var2654 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var2654 null-Int)))
(declare-const var3755 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var3755 null-String)))
(define-const var1888 var1752 (commander/-2133873678 var651)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var570 Int (getColumnSize/-165698927 var1888)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var2014 = var3755.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var839 Int var2654) ; Statement: i14 = i1 
(define-const var518 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var1696 Int (get_split_length var3755 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var518 var1696)) ; Cond: i15 >= $i2 
 ; Statement: return 
(check-sat)
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int)}
; {var2917=com.beust.jcommander.DefaultUsageFormatter, var651=r0, var1047=r5, var3917=i10, var2654=i1, var3755=r2, var1350=null_type, var1752=com.beust.jcommander.JCommander, var1888=$r1, var570=i0, var2014=r3, var839=i14, var518=i15, var1696=$i2}
; {com.beust.jcommander.DefaultUsageFormatter=var2917, r0=var651, r5=var1047, i10=var3917, i1=var2654, r2=var3755, null_type=var1350, com.beust.jcommander.JCommander=var1752, $r1=var1888, i0=var570, r3=var2014, i14=var839, i15=var518, $i2=var1696}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 3
(get-model)
