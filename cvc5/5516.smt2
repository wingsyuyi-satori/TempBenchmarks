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

(declare-sort var1088 0)
(declare-sort var3087 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3087-init () var3087)
(declare-fun <init>/1228603609 (var3087 Int) void)
(declare-const null-String String)
(declare-const var3384 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3384 null-String)))
; split operation: var1747 = var3384.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2280 String null-String) ; Statement: r7 = null 
(define-const var2511 var3087 var3087-init) ; Statement: $r2 = new java.util.ArrayList 
(define-const var1359 Int (get_split_length var3384 "," -1)) ; Statement: $i0 = lengthof r1 
(assert true)
;(assert (<init>/1228603609 var2511 var1359)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0) 

(declare-const var2511!1 var3087)
(declare-const var1359!1 Int)
(define-const var170 Int (get_split_length var3384 "," -1)) ; Statement: i1 = lengthof r1 
(define-const var2162 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return $r2 
(assert (>= var2162 var170)) ; Cond: i2 >= i1 
 ; Statement: return $r2 
(check-sat)
; {var3087-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void)}
; {var3384=r0, var1088=null_type, var1747=r1, var2280=r7, var3087=java.util.ArrayList, var2511=$r2, var1359=$i0, var170=i1, var2162=i2}
; {r0=var3384, null_type=var1088, r1=var1747, r7=var2280, java.util.ArrayList=var3087, $r2=var2511, $i0=var1359, i1=var170, i2=var2162}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	r7 = null;	$r2 = new java.util.ArrayList;	$i0 = lengthof r1;	specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0);	i1 = lengthof r1;	i2 = 0;	if i2 >= i1 goto return $r2;	return $r2
;block_num 3
(get-model)
