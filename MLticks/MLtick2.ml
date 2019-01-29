exception Matches
fun last (x::[]) = x
  | last (x::xs) = last(xs)
  | last _ = raise Matches;

fun removelast (x::[],acc) = rev(acc)
  | removelast (x::xs,acc) =removelast (xs,x::acc)
  | removelast _ = raise Matches;
fun butlast (xs) = removelast (xs,[]);

fun nth(x::xs,0) = x
  | nth(x::xs,n) = nth(xs,n-1)
  | nth _ = raise Matches;
