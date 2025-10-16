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

(declare-sort var3706 0)
(declare-sort var1968 0)
(declare-sort var90 0)
(declare-sort var1694 0)
(declare-sort var3147 0)
(declare-sort var2903 0)
(declare-sort var1835 0)
(declare-sort var3564 0)
(declare-sort var676 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun makeReaderAndWriter/-2081966930 (var90) var1968)
(declare-fun cast-from-var3706-to-var90 (var3706) var90)
(declare-fun flags/-865622323 (var90) var1694)
(declare-fun trainFile/-179725236 (var1694) String)
(declare-fun biasedTrainFile/-179725236 (var1694) String)
(declare-fun makeObjectBankFromFile/1614303798 (var90 String var1968) var3147)
(declare-fun var2903-init () var2903)
(declare-fun <init>/100578090 (var2903) void)
(declare-fun getDataset/-980257756 (var3706 var3564 var676 var676) var1835)
(declare-fun cast-from-var3147-to-var3564 (var3147) var3564)
(declare-fun cast-from-var2903-to-var676 (var2903) var676)
(declare-fun getBiasedDataset/-1766800797 (var3706 var3147 var676 var676) var1835)
(declare-fun var676_size/127987506 (var676) Int)
(declare-fun arr-Float64-2-init () (Array Int (Array Int Float64)))
(declare-fun getLength-Arr-Float64-2 ((Array Int (Array Int Float64))) Int)
(declare-fun confusionMatrix/-179725236 (var1694) String)
(declare-fun trainSemiSup/448771690 (var3706 var1835 var1835 (Array Int (Array Int Float64))) void)
(declare-const null-var3706 var3706)
(declare-const var1534 var3706) ; Statement: r0 := @this: edu.stanford.nlp.ie.ner.CMMClassifier 
(assert (not (= var1534 null-var3706)))
(assert true)
(define-const var1566 var1968 (makeReaderAndWriter/-2081966930 (cast-from-var3706-to-var90 var1534))) ; Statement: r1 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.DocumentReaderAndWriter makeReaderAndWriter()>() 
(define-const var138 var1694 (flags/-865622323 (cast-from-var3706-to-var90 var1534))) ; Statement: $r2 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var2321 String (trainFile/-179725236 var138)) ; Statement: r3 = $r2.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String trainFile> 
(define-const var2246 var1694 (flags/-865622323 (cast-from-var3706-to-var90 var1534))) ; Statement: $r4 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var3182 String (biasedTrainFile/-179725236 var2246)) ; Statement: r5 = $r4.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String biasedTrainFile> 
(assert true)
(define-const var3876 var3147 (makeObjectBankFromFile/1614303798 (cast-from-var3706-to-var90 var1534) var2321 var1566)) ; Statement: r6 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromFile(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r3, r1) 
(assert true)
(define-const var3252 var3147 (makeObjectBankFromFile/1614303798 (cast-from-var3706-to-var90 var1534) var3182 var1566)) ; Statement: r7 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromFile(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r5, r1) 
(define-const var1105 var2903 var2903-init) ; Statement: $r8 = new edu.stanford.nlp.util.HashIndex 
(assert true)
;(assert (<init>/100578090 var1105)) ; Statement: specialinvoke $r8.<edu.stanford.nlp.util.HashIndex: void <init>()>() 

(declare-const var1105!1 var2903)
(define-const var2297 var2903 var2903-init) ; Statement: $r9 = new edu.stanford.nlp.util.HashIndex 
(assert true)
;(assert (<init>/100578090 var2297)) ; Statement: specialinvoke $r9.<edu.stanford.nlp.util.HashIndex: void <init>()>() 

(declare-const var2297!1 var2903)
(assert true)
(define-const var712 var1835 (getDataset/-980257756 var1534 (cast-from-var3147-to-var3564 var3876) (cast-from-var2903-to-var676 var1105!1) (cast-from-var2903-to-var676 var2297!1))) ; Statement: r10 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.classify.Dataset getDataset(java.util.Collection,edu.stanford.nlp.util.Index,edu.stanford.nlp.util.Index)>(r6, $r8, $r9) 
(assert true)
(define-const var847 var1835 (getBiasedDataset/-1766800797 var1534 var3252 (cast-from-var2903-to-var676 var1105!1) (cast-from-var2903-to-var676 var2297!1))) ; Statement: r11 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.classify.Dataset getBiasedDataset(edu.stanford.nlp.objectbank.ObjectBank,edu.stanford.nlp.util.Index,edu.stanford.nlp.util.Index)>(r7, $r8, $r9) 
(define-const var2659 Int (var676_size/127987506 (cast-from-var2903-to-var676 var2297!1))) ; Statement: $i1 = interfaceinvoke $r9.<edu.stanford.nlp.util.Index: int size()>() 
(define-const var2133 Int (var676_size/127987506 (cast-from-var2903-to-var676 var2297!1))) ; Statement: $i0 = interfaceinvoke $r9.<edu.stanford.nlp.util.Index: int size()>() 
(define-const var2608 (Array Int (Array Int Float64)) arr-Float64-2-init) ; Statement: r12 = newmultiarray (double)[$i1][$i0] 
(define-const var454 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
(define-const var2834 Int (getLength-Arr-Float64-2 var2608)) ; Statement: $i2 = lengthof r12 
 ; Statement: if i8 >= $i2 goto $r13 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(assert (>= var454 var2834)) ; Cond: i8 >= $i2 
(define-const var2021 var1694 (flags/-865622323 (cast-from-var3706-to-var90 var1534))) ; Statement: $r13 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags> 
(define-const var3831 String (confusionMatrix/-179725236 var2021)) ; Statement: r40 = $r13.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String confusionMatrix> 
; split operation: var2764 = var3831.split(":") ; Statement: r14 = virtualinvoke r40.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var3742 Int (get_split_length var3831 ":" -1)) ; Statement: i9 = lengthof r14 
(define-const var2859 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
 ; Statement: if i10 >= i9 goto i11 = lengthof r12 
(assert (>= var2859 var3742)) ; Cond: i10 >= i9 
(define-const var1455 Int (getLength-Arr-Float64-2 var2608)) ; Statement: i11 = lengthof r12 
(define-const var1805 Int 0) ; Statement: i12 = 0 
(assert true) ; Non Conditional
 ; Statement: if i12 >= i11 goto i13 = 0 
(assert (>= var1805 var1455)) ; Cond: i12 >= i11 
(define-const var3842 Int 0) ; Statement: i13 = 0 
(assert true) ; Non Conditional
(define-const var1603 Int (getLength-Arr-Float64-2 var2608)) ; Statement: $i3 = lengthof r12 
 ; Statement: if i13 >= $i3 goto i15 = 0 
(assert (>= var3842 var1603)) ; Cond: i13 >= $i3 
(define-const var2385 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var949 Int (getLength-Arr-Float64-2 var2608)) ; Statement: $i4 = lengthof r12 
 ; Statement: if i15 >= $i4 goto specialinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: void trainSemiSup(edu.stanford.nlp.classify.Dataset,edu.stanford.nlp.classify.Dataset,double[][])>(r10, r11, r12) 
(assert (>= var2385 var949)) ; Cond: i15 >= $i4 
(assert true)
;(assert (trainSemiSup/448771690 var1534 var712 var847 var2608)) ; Statement: specialinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: void trainSemiSup(edu.stanford.nlp.classify.Dataset,edu.stanford.nlp.classify.Dataset,double[][])>(r10, r11, r12) 

(declare-const var1534!1 var3706)
(declare-const var712!1 var1835)
(declare-const var847!1 var1835)
(declare-const var2608!1 (Array Int (Array Int Float64)))
 ; Statement: return 
(check-sat)
; {makeReaderAndWriter/-2081966930=([edu.stanford.nlp.ie.AbstractSequenceClassifier], edu.stanford.nlp.sequences.DocumentReaderAndWriter), cast-from-var3706-to-var90=([edu.stanford.nlp.ie.ner.CMMClassifier], edu.stanford.nlp.ie.AbstractSequenceClassifier), flags/-865622323=([edu.stanford.nlp.ie.AbstractSequenceClassifier], edu.stanford.nlp.sequences.SeqClassifierFlags), trainFile/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], java.lang.String), biasedTrainFile/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], java.lang.String), makeObjectBankFromFile/1614303798=([edu.stanford.nlp.ie.AbstractSequenceClassifier, java.lang.String, edu.stanford.nlp.sequences.DocumentReaderAndWriter], edu.stanford.nlp.objectbank.ObjectBank), var2903-init=([], edu.stanford.nlp.util.HashIndex), <init>/100578090=([edu.stanford.nlp.util.HashIndex], void), getDataset/-980257756=([edu.stanford.nlp.ie.ner.CMMClassifier, java.util.Collection, edu.stanford.nlp.util.Index, edu.stanford.nlp.util.Index], edu.stanford.nlp.classify.Dataset), cast-from-var3147-to-var3564=([edu.stanford.nlp.objectbank.ObjectBank], java.util.Collection), cast-from-var2903-to-var676=([edu.stanford.nlp.util.HashIndex], edu.stanford.nlp.util.Index), getBiasedDataset/-1766800797=([edu.stanford.nlp.ie.ner.CMMClassifier, edu.stanford.nlp.objectbank.ObjectBank, edu.stanford.nlp.util.Index, edu.stanford.nlp.util.Index], edu.stanford.nlp.classify.Dataset), var676_size/127987506=([edu.stanford.nlp.util.Index], int), arr-Float64-2-init=([], double[][]), getLength-Arr-Float64-2=([double[][]], int), confusionMatrix/-179725236=([edu.stanford.nlp.sequences.SeqClassifierFlags], java.lang.String), trainSemiSup/448771690=([edu.stanford.nlp.ie.ner.CMMClassifier, edu.stanford.nlp.classify.Dataset, edu.stanford.nlp.classify.Dataset, double[][]], void)}
; {var3706=edu.stanford.nlp.ie.ner.CMMClassifier, var1534=r0, var1968=edu.stanford.nlp.sequences.DocumentReaderAndWriter, var90=edu.stanford.nlp.ie.AbstractSequenceClassifier, var1566=r1, var1694=edu.stanford.nlp.sequences.SeqClassifierFlags, var138=$r2, var2321=r3, var2246=$r4, var3182=r5, var3147=edu.stanford.nlp.objectbank.ObjectBank, var3876=r6, var3252=r7, var2903=edu.stanford.nlp.util.HashIndex, var1105=$r8, var2297=$r9, var1835=edu.stanford.nlp.classify.Dataset, var3564=java.util.Collection, var676=edu.stanford.nlp.util.Index, var712=r10, var847=r11, var2659=$i1, var2133=$i0, var2608=r12, var454=i8, var2834=$i2, var2021=$r13, var3831=r40, var2764=r14, var3742=i9, var2859=i10, var1455=i11, var1805=i12, var3842=i13, var1603=$i3, var2385=i15, var949=$i4}
; {edu.stanford.nlp.ie.ner.CMMClassifier=var3706, r0=var1534, edu.stanford.nlp.sequences.DocumentReaderAndWriter=var1968, edu.stanford.nlp.ie.AbstractSequenceClassifier=var90, r1=var1566, edu.stanford.nlp.sequences.SeqClassifierFlags=var1694, $r2=var138, r3=var2321, $r4=var2246, r5=var3182, edu.stanford.nlp.objectbank.ObjectBank=var3147, r6=var3876, r7=var3252, edu.stanford.nlp.util.HashIndex=var2903, $r8=var1105, $r9=var2297, edu.stanford.nlp.classify.Dataset=var1835, java.util.Collection=var3564, edu.stanford.nlp.util.Index=var676, r10=var712, r11=var847, $i1=var2659, $i0=var2133, r12=var2608, i8=var454, $i2=var2834, $r13=var2021, r40=var3831, r14=var2764, i9=var3742, i10=var2859, i11=var1455, i12=var1805, i13=var3842, $i3=var1603, i15=var2385, $i4=var949}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.ner.CMMClassifier;	r1 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.DocumentReaderAndWriter makeReaderAndWriter()>();	$r2 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	r3 = $r2.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String trainFile>;	$r4 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	r5 = $r4.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String biasedTrainFile>;	r6 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromFile(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r3, r1);	r7 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.objectbank.ObjectBank makeObjectBankFromFile(java.lang.String,edu.stanford.nlp.sequences.DocumentReaderAndWriter)>(r5, r1);	$r8 = new edu.stanford.nlp.util.HashIndex;	specialinvoke $r8.<edu.stanford.nlp.util.HashIndex: void <init>()>();	$r9 = new edu.stanford.nlp.util.HashIndex;	specialinvoke $r9.<edu.stanford.nlp.util.HashIndex: void <init>()>();	r10 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.classify.Dataset getDataset(java.util.Collection,edu.stanford.nlp.util.Index,edu.stanford.nlp.util.Index)>(r6, $r8, $r9);	r11 = virtualinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.classify.Dataset getBiasedDataset(edu.stanford.nlp.objectbank.ObjectBank,edu.stanford.nlp.util.Index,edu.stanford.nlp.util.Index)>(r7, $r8, $r9);	$i1 = interfaceinvoke $r9.<edu.stanford.nlp.util.Index: int size()>();	$i0 = interfaceinvoke $r9.<edu.stanford.nlp.util.Index: int size()>();	r12 = newmultiarray (double)[$i1][$i0];	i8 = 0;	$i2 = lengthof r12;	if i8 >= $i2 goto $r13 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	$r13 = r0.<edu.stanford.nlp.ie.ner.CMMClassifier: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;	r40 = $r13.<edu.stanford.nlp.sequences.SeqClassifierFlags: java.lang.String confusionMatrix>;	r14 = virtualinvoke r40.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	i9 = lengthof r14;	i10 = 0;	if i10 >= i9 goto i11 = lengthof r12;	i11 = lengthof r12;	i12 = 0;	if i12 >= i11 goto i13 = 0;	i13 = 0;	$i3 = lengthof r12;	if i13 >= $i3 goto i15 = 0;	i15 = 0;	$i4 = lengthof r12;	if i15 >= $i4 goto specialinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: void trainSemiSup(edu.stanford.nlp.classify.Dataset,edu.stanford.nlp.classify.Dataset,double[][])>(r10, r11, r12);	specialinvoke r0.<edu.stanford.nlp.ie.ner.CMMClassifier: void trainSemiSup(edu.stanford.nlp.classify.Dataset,edu.stanford.nlp.classify.Dataset,double[][])>(r10, r11, r12);	return
;block_num 11
(get-model)
