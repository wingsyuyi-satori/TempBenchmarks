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

(declare-sort var901 0)
(declare-sort var390 0)
(declare-sort var3475 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3475-init () var3475)
(declare-fun <init>/1228603609 (var3475 Int) void)
(declare-const null-var901 var901)
(declare-const null-String String)
(declare-const var375 var901) ; Statement: r13 := @this: edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser 
(assert (not (= var375 null-var901)))
(declare-const var1341 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1341 null-String)))
(define-const var452 Int 0) ; Statement: i3 = 0 
; split operation: var3105 = var1341.split(" ") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3772 var3475 var3475-init) ; Statement: $r2 = new java.util.ArrayList 
(define-const var1163 Int (get_split_length var1341 " " -1)) ; Statement: $i0 = lengthof r1 
(assert true)
;(assert (<init>/1228603609 var3772 var1163)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0) 

(declare-const var3772!1 var3475)
(declare-const var1163!1 Int)
(define-const var2576 Int (get_split_length var1341 " " -1)) ; Statement: i1 = lengthof r1 
(define-const var3500 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i1 goto return $r2 
(assert (>= var3500 var2576)) ; Cond: i4 >= i1 
 ; Statement: return $r2 
(check-sat)
; {var3475-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void)}
; {var901=edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser, var375=r13, var1341=r0, var390=null_type, var452=i3, var3105=r1, var3475=java.util.ArrayList, var3772=$r2, var1163=$i0, var2576=i1, var3500=i4}
; {edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser=var901, r13=var375, r0=var1341, null_type=var390, i3=var452, r1=var3105, java.util.ArrayList=var3475, $r2=var3772, $i0=var1163, i1=var2576, i4=var3500}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r13 := @this: edu.stanford.nlp.sequences.TrueCasingForNISTDocumentReaderAndWriter$LineToTrueCasesParser;	r0 := @parameter0: java.lang.String;	i3 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r2 = new java.util.ArrayList;	$i0 = lengthof r1;	specialinvoke $r2.<java.util.ArrayList: void <init>(int)>($i0);	i1 = lengthof r1;	i4 = 0;	if i4 >= i1 goto return $r2;	return $r2
;block_num 3
(get-model)
