fun evalquad (a,b,c,x:real)=a*(x*x)+b*x+c;

exception NegativeNumber
fun facr n = 
	if n=0 then 1
		else if n>0 then n*facr(n-1)
					else raise NegativeNumber;	

fun faci2 (n,total)=
	if n=0 then total
		else if n>0 then faci2(n-1,total*n)
					else raise NegativeNumber; 
fun faci n =faci2(n,1);

					   
exception NonPositiveNumber
fun sumt n =
	if n=1 then 1.0
	       else if n>1 then 1.0+sumt(n-1)/2.0
				       else raise NonPositiveNumber;
