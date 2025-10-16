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

(declare-sort var3886 0)
(declare-sort var823 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-118428381 (var3886) void)
(declare-const null-var3886 var3886)
(declare-const null-String String)
(declare-const var326 var3886) ; Statement: r0 := @this: kong.unirest.core.QueryParams 
(assert (not (= var326 null-var3886)))
(declare-const var3021 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3021 null-String)))
(assert true)
;(assert (<init>/-118428381 var326)) ; Statement: specialinvoke r0.<kong.unirest.core.QueryParams: void <init>()>() 

(declare-const var326!1 var3886)
; split operation: var2772 = var3021.split("\u005c?") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?") 
(define-const var1828 Int (get_split_length var3021 "\u005c?" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 1 goto return 
(assert (<= var1828 1)) ; Cond: $i0 <= 1 
 ; Statement: return 
(check-sat)
; {<init>/-118428381=([kong.unirest.core.QueryParams], void)}
; {var3886=kong.unirest.core.QueryParams, var326=r0, var3021=r1, var823=null_type, var2772=r2, var1828=$i0}
; {kong.unirest.core.QueryParams=var3886, r0=var326, r1=var3021, null_type=var823, r2=var2772, $i0=var1828}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: kong.unirest.core.QueryParams;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<kong.unirest.core.QueryParams: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?");	$i0 = lengthof r2;	if $i0 <= 1 goto return;	return
;block_num 2
(get-model)
