datatype 'a tree = Lf
                 | Br of 'a * 'a tree * 'a tree;
				 
fun insert (key:string, Lf) = Br(key,Lf,Lf)
  | insert (key, (Br(x,lt,rt))) =
    if (key<=x) then Br(x,(insert(key,lt)),rt)
    else Br(x,lt,(insert(key,rt)));

fun member (key:string, Lf) = false
  | member (key:string, Br(a,lt,rt)) = 
	if (key=a) then true 
	else if (key<a) then member(key,lt)
	else member(key,rt);

fun treetolist Lf = []
  | treetolist (Br(a,lt,rt)) = (treetolist(lt))@[a]@(treetolist(rt));
fun listtotree (x::[]) = insert(x, Lf)
  | listtotree (x::xs) = insert(x, listtotree(xs));
fun union (t1,t2) = listtotree(treetolist(t1)@treetolist(t2));

fun common (x:string list,[]) = []
  | common ([],y:string list) = []
  | common (x::xs,y::ys) = 
    if (x=y) then x::common(xs,ys)
	else if (x<y) then common(xs,y::ys)
	else common(x::xs,ys);
fun inter (t1,t2) = listtotree (common(treetolist(t1),treetolist(t2)));



fun maxkey (Br(key,_,Lf)) = key
  | maxkey (Br(key,_,rt)) = maxkey(rt);

exception notexist;

fun remove (a:string,Lf) = raise notexist
  | remove (a,Br(key,Lf,rt)) =
    if (a=key) then rt
	else if (a<key) then raise notexist
	else Br(key,Lf,remove(a,rt))
  | remove (a,Br(key,lt,Lf)) = 
    if (a=key) then lt 
	else if (a<key) then Br(key,remove(a,lt),Lf)
	else raise notexist
  | remove (a,Br(key,lt,rt)) =
    if (a<key) then Br(key,remove(a,lt),rt)
	else if (a>key) then Br(key,lt,remove(a,rt))
	else 
	let 
	  val maxls = maxkey(lt)
	in 
	  Br(maxls,remove(maxls,lt),rt) end;
