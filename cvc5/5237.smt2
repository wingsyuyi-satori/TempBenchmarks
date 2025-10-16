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

(declare-sort var1901 0)
(declare-sort var2871 0)
(declare-sort var2257 0)
(declare-sort var1840 0)
(declare-sort var1047 0)
(declare-sort var1241 0)
(declare-sort var855 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var1840-init () var1840)
(declare-fun <init>/2076123439 (var1840 (Array Int Int) Int) void)
(declare-fun var2257_write/489016319 (var2257 var1840) void)
(declare-fun var1901_hasEntry/-919956893 (var1901 String) Bool)
(declare-fun getWriteIndex/-1813127352 (var1840) Int)
(declare-fun var1047-init () var1047)
(declare-fun <init>/-513080946 (var1047 (Array Int Int)) void)
(declare-fun var1901_createDocument/310456128 (var1901 String Int var855) var1241)
(declare-fun cast-from-var1047-to-var855 (var1047) var855)
(declare-const null-var1901 var1901)
(declare-const null-String String)
(declare-const null-var2257 var2257)
(declare-const var1973 var1901) ; Statement: r12 := @parameter0: org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry 
(assert (not (= var1973 null-var1901)))
(declare-const var37 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var37 null-String)))
(declare-const var2585 var2257) ; Statement: r3 := @parameter2: org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord 
(assert (not (= var2585 null-var2257)))
; split operation: var1475 = var37.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var3193 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
(define-const var2716 Int (get_split_length var37 "/" -1)) ; Statement: $i0 = lengthof r1 
(define-const var1376 Int (- var2716 1)) ; Statement: $i1 = $i0 - 1 
 ; Statement: if i5 >= $i1 goto r14 = newarray (byte)[5000] 
(assert (>= var3193 var1376)) ; Cond: i5 >= $i1 
(define-const var3512 (Array Int Int) arr-Int-init) ; Statement: r14 = newarray (byte)[5000] 
(define-const var2928 var1840 var1840-init) ; Statement: $r2 = new org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream 
(assert true)
;(assert (<init>/2076123439 var2928 var3512 0)) ; Statement: specialinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: void <init>(byte[],int)>(r14, 0) 

(declare-const var2928!1 var1840)
(declare-const var3512!1 (Array Int Int))
(declare-const var1875 Int)
;(assert (var2257_write/489016319 var2585 var2928!1)) ; Statement: interfaceinvoke r3.<org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord: void write(org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream)>($r2) 

(declare-const var2585!1 var2257)
(declare-const var2928!2 var1840)
(define-const var7 Int (get_split_length var37 "/" -1)) ; Statement: $i2 = lengthof r1 
(define-const var291 Int (- var7 1)) ; Statement: $i3 = $i2 - 1 
(define-const var144 String (get_split_element var37 "/" -1 var291)) ; Statement: r4 = r1[$i3] 
(define-const var2667 Bool (var1901_hasEntry/-919956893 var1973 var144)) ; Statement: $z0 = interfaceinvoke r12.<org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry: boolean hasEntry(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $i4 = virtualinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>() 
(assert (= (ite var2667 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3006 Int (getWriteIndex/-1813127352 var2928!2)) ; Statement: $i4 = virtualinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>() 
(define-const var1004 var1047 var1047-init) ; Statement: $r5 = new org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1 
(assert true)
;(assert (<init>/-513080946 var1004 var3512!1)) ; Statement: specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1: void <init>(byte[])>(r14) 

(declare-const var1004!1 var1047)
(declare-const var3512!2 (Array Int Int))
(define-const var1469 var1241 (var1901_createDocument/310456128 var1973 var144 var3006 (cast-from-var1047-to-var855 var1004!1))) ; Statement: $r6 = interfaceinvoke r12.<org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry: org.docx4j.org.apache.poi.poifs.filesystem.DocumentEntry createDocument(java.lang.String,int,org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener)>(r4, $i4, $r5) 
 ; Statement: return $r6 
(check-sat)
; {arr-Int-init=([], byte[]), var1840-init=([], org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream), <init>/2076123439=([org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream, byte[], int], void), var2257_write/489016319=([org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord, org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream], void), var1901_hasEntry/-919956893=([org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry, java.lang.String], boolean), getWriteIndex/-1813127352=([org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream], int), var1047-init=([], org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1), <init>/-513080946=([org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1, byte[]], void), var1901_createDocument/310456128=([org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry, java.lang.String, int, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener], org.docx4j.org.apache.poi.poifs.filesystem.DocumentEntry), cast-from-var1047-to-var855=([org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1], org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener)}
; {var1901=org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry, var1973=r12, var37=r0, var2871=null_type, var2257=org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord, var2585=r3, var1475=r1, var3193=i5, var2716=$i0, var1376=$i1, var3512=r14, var1840=org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream, var2928=$r2, var1875=0, var7=$i2, var291=$i3, var144=r4, var2667=$z0, var3006=$i4, var1047=org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1, var1004=$r5, var1241=org.docx4j.org.apache.poi.poifs.filesystem.DocumentEntry, var855=org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener, var1469=$r6}
; {org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry=var1901, r12=var1973, r0=var37, null_type=var2871, org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord=var2257, r3=var2585, r1=var1475, i5=var3193, $i0=var2716, $i1=var1376, r14=var3512, org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream=var1840, $r2=var2928, 0=var1875, $i2=var7, $i3=var291, r4=var144, $z0=var2667, $i4=var3006, org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1=var1047, $r5=var1004, org.docx4j.org.apache.poi.poifs.filesystem.DocumentEntry=var1241, org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener=var855, $r6=var1469}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r12 := @parameter0: org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	i5 = 0;	$i0 = lengthof r1;	$i1 = $i0 - 1;	if i5 >= $i1 goto r14 = newarray (byte)[5000];	r14 = newarray (byte)[5000];	$r2 = new org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream;	specialinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: void <init>(byte[],int)>(r14, 0);	interfaceinvoke r3.<org.docx4j.org.apache.poi.poifs.crypt.standard.EncryptionRecord: void write(org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream)>($r2);	$i2 = lengthof r1;	$i3 = $i2 - 1;	r4 = r1[$i3];	$z0 = interfaceinvoke r12.<org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry: boolean hasEntry(java.lang.String)>(r4);	if $z0 == 0 goto $i4 = virtualinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>();	$i4 = virtualinvoke $r2.<org.docx4j.org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>();	$r5 = new org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1;	specialinvoke $r5.<org.docx4j.org.apache.poi.poifs.crypt.DataSpaceMapUtils$1: void <init>(byte[])>(r14);	$r6 = interfaceinvoke r12.<org.docx4j.org.apache.poi.poifs.filesystem.DirectoryEntry: org.docx4j.org.apache.poi.poifs.filesystem.DocumentEntry createDocument(java.lang.String,int,org.docx4j.org.apache.poi.poifs.filesystem.POIFSWriterListener)>(r4, $i4, $r5);	return $r6
;block_num 4
(get-model)
