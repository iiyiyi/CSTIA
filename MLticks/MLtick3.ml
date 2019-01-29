datatype 'a tree = Lf
                 | Br of 'a* 'a tree * 'a tree;
fun tcons v Lf = Br (v, Lf, Lf)
  | tcons v (Br (w, t1, t2)) = Br (v, tcons w t2, t1);
	  
fun arrayoflist [] = Lf
  | arrayoflist (x::xs) = tcons x (arrayoflist (xs));

fun merge (l1,[]) = l1
  | merge (x1::xs1,x2::xs2) = [x1,x2] @ merge(xs1, xs2);  

fun listofarray Lf = []
  | listofarray (Br(w, t1, t2)) = [w] @ merge (listofarray(t1),listofarray(t2));
  
fun getSubs ([],_) = []
  | getSubs (x::xs,n)= if (x mod 2=0) then [n] @ getSubs(xs,n+1)
					 else getSubs(xs,n+1);
fun getSubsOfEvens tree = getSubs(listofarray(tree),1);
