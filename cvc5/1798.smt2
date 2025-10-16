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

(declare-sort var2167 0)
(declare-sort var2911 0)
(declare-sort var1661 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1661_newHashMap/701256970 () var2911)
(declare-const null-String String)
(declare-const var3626 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3626 null-String)))
; split operation: var2412 = var3626.split("[,;]") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var1251 var2911 var1661_newHashMap/701256970) ; Statement: r2 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var2087 Int (get_split_length var3626 "[,;]" -1)) ; Statement: i0 = lengthof r1 
(define-const var3822 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto return r2 
(assert (>= var3822 var2087)) ; Cond: i3 >= i0 
 ; Statement: return r2 
(check-sat)
; {var1661_newHashMap/701256970=([], java.util.Map)}
; {var3626=r0, var2167=null_type, var2412=r1, var2911=java.util.Map, var1661=edu.stanford.nlp.util.Generics, var1251=r2, var2087=i0, var3822=i3}
; {r0=var3626, null_type=var2167, r1=var2412, java.util.Map=var2911, edu.stanford.nlp.util.Generics=var1661, r2=var1251, i0=var2087, i3=var3822}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	r2 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto return r2;	return r2
;block_num 3
(get-model)
