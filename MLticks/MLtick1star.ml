fun approx(n:int,sum:real,acc:real,term:real)=
if (n=1) then sum
else approx(n-1,sum+acc,acc/(term+1.0),term+1.0);
fun eapprox n = approx(n,1.0,1.0,1.0);

fun zapprox(n:int,z:real,sum:real,acc:real,term:real)=
if (n=1) then sum
else zapprox(n-1,z,sum+acc,acc*z/(term+1.0),term+1.0);
fun exp (z,n) = zapprox(n,z,1.0,z,1.0);

fun gcd(a,b)=
if (a=b) then a
else if (a mod 2=0 andalso b mod 2=0) then 2*gcd(a div 2,b div 2)
else if (a mod 2=1 andalso b mod 2=0) then gcd(a,b div 2)
else if (a mod 2=0 andalso b mod 2=1) then gcd(a div 2,b)
else if (a>b) then gcd(b,a-b)
else gcd(a,b-a);
