fun nfold f 0 x = x
  | nfold f n x = f (nfold f (n-1) x);

fun sum m n = nfold (fn x => x+1) m n;

fun product m n = nfold (fn x => x+m) n 0;

fun power m n = nfold (fn x => x*m) n 1;



datatype 'a stream = Cons of 'a * (unit -> 'a stream);

fun from k = Cons(k, fn()=> from(k+1));

fun nth (Cons(x,xf) , 1) = x
    | nth (Cons(x,xf) , n) = nth(xf() , n-1);

fun sqr k = Cons(k*k, fn()=> sqr(k+1));
val squares = sqr 1;
nth (squares, 49);

fun map2 f (Cons(x,xf)) (Cons(y,yf)) = Cons(f x y, fn() => map2 f (xf()) (yf()));
