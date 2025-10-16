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

(declare-sort var267 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getContentType/125337655 (var267) String)
(declare-const null-var267 var267)
(declare-const var1845 var267) ; Statement: r0 := @parameter0: java.net.URLConnection 
(assert (not (= var1845 null-var267)))
(assert true)
(define-const var1602 String (getContentType/125337655 var1845)) ; Statement: r1 = virtualinvoke r0.<java.net.URLConnection: java.lang.String getContentType()>() 
; split operation: var1652 = var1602.split(";") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var341 String "utf-8") ; Statement: r6 = "utf-8" 
(define-const var127 Int (get_split_length var1602 ";" -1)) ; Statement: i0 = lengthof r2 
(define-const var3435 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return r6 
(assert (>= var3435 var127)) ; Cond: i2 >= i0 
 ; Statement: return r6 
(check-sat)
; {getContentType/125337655=([java.net.URLConnection], java.lang.String)}
; {var267=java.net.URLConnection, var1845=r0, var1602=r1, var1652=r2, var341=r6, var127=i0, var3435=i2}
; {java.net.URLConnection=var267, r0=var1845, r1=var1602, r2=var1652, r6=var341, i0=var127, i2=var3435}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.URLConnection;	r1 = virtualinvoke r0.<java.net.URLConnection: java.lang.String getContentType()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	r6 = "utf-8";	i0 = lengthof r2;	i2 = 0;	if i2 >= i0 goto return r6;	return r6
;block_num 3
(get-model)
