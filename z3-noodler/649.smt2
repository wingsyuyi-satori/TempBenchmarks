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

(declare-sort var2980 0)
(declare-sort var2366 0)
(declare-sort var191 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun containsKey/437427949 (var2366 var191) Bool)
(declare-fun cast-from-String-to-var191 (String) var191)
(declare-fun getFirst/-1258182190 (var2366 String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2980 var2980)
(declare-const null-var2366 var2366)
(declare-const var3557 var2980) ; Statement: r4 := @this: edu.stanford.nlp.pipeline.StanfordCoreNLPServer 
(assert (not (= var3557 null-var2980)))
(declare-const var1866 var2366) ; Statement: r0 := @parameter0: com.sun.net.httpserver.Headers 
(assert (not (= var1866 null-var2366)))
(define-const var1355 String "application/x-www-form-urlencoded") ; Statement: r5 = "application/x-www-form-urlencoded" 
(assert true)
(define-const var3986 Bool (containsKey/437427949 var1866 (cast-from-String-to-var191 "Content-type"))) ; Statement: $z0 = virtualinvoke r0.<com.sun.net.httpserver.Headers: boolean containsKey(java.lang.Object)>("Content-type") 
 ; Statement: if $z0 == 0 goto return r5 
(assert (not (= (ite var3986 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var1448 String (getFirst/-1258182190 var1866 "Content-type")) ; Statement: $r1 = virtualinvoke r0.<com.sun.net.httpserver.Headers: java.lang.String getFirst(java.lang.String)>("Content-type") 
; split operation: var1168 = var1448.split(";") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var3615 String (get_split_element var1448 ";" -1 0)) ; Statement: $r3 = $r2[0] 
(assert true)
(define-const var1355!1 String (trim/-847153721 var3615)) ; Statement: r5 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
(assert true) ; Non Conditional
 ; Statement: return r5 
(check-sat)
; {containsKey/437427949=([com.sun.net.httpserver.Headers, java.lang.Object], boolean), cast-from-String-to-var191=([java.lang.String], java.lang.Object), getFirst/-1258182190=([com.sun.net.httpserver.Headers, java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2980=edu.stanford.nlp.pipeline.StanfordCoreNLPServer, var3557=r4, var2366=com.sun.net.httpserver.Headers, var1866=r0, var1355=r5, var191=java.lang.Object, var3986=$z0, var1448=$r1, var1168=$r2, var3615=$r3}
; {edu.stanford.nlp.pipeline.StanfordCoreNLPServer=var2980, r4=var3557, com.sun.net.httpserver.Headers=var2366, r0=var1866, r5=var1355, java.lang.Object=var191, $z0=var3986, $r1=var1448, $r2=var1168, $r3=var3615}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r4 := @this: edu.stanford.nlp.pipeline.StanfordCoreNLPServer;	r0 := @parameter0: com.sun.net.httpserver.Headers;	r5 = "application/x-www-form-urlencoded";	$z0 = virtualinvoke r0.<com.sun.net.httpserver.Headers: boolean containsKey(java.lang.Object)>("Content-type");	if $z0 == 0 goto return r5;	$r1 = virtualinvoke r0.<com.sun.net.httpserver.Headers: java.lang.String getFirst(java.lang.String)>("Content-type");	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r3 = $r2[0];	r5 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	return r5
;block_num 3
(get-model)
