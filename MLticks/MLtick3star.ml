exception Matches
fun allcons (m,x::[]) = [m::x]
  | allcons (m,x::xs) = [m::x] @ allcons(m,xs);
fun choose (1,x::[]) = [[x]]
  | choose (1,x::xs) = [[x]] @ choose (1,xs)
  | choose (n,x::xs) = if (length(x::xs)>n) then allcons(x,choose(n-1,xs)) @ choose(n,xs)
					   else if (length(x::xs)=n) then allcons(x,choose(n-1,xs))
					   else []
  | choose _ = raise Matches;
