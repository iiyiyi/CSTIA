type color = int*int*int;   (* RGB colour components, 0..255 *)
type xy = int*int;       (* points (x, y) and sizes (w, h) *)
datatype image = Image of xy * color array array;
fun image ((w, h):xy) (c:color) = Image((w, h), Array.tabulate(h, fn i => Array.tabulate(w, fn i => c)));
fun size (Image((w, h):xy, carr)) = (w, h):xy;
fun drawPixel (Image(wh, carr)) (c:color) ((x,y):xy) = Array.update(Array.sub(carr, y), x, c);

fun format4 i = StringCvt.padLeft #" " 4 (Int.toString i);

fun colorToString ((r, g, b):color) = format4 r ^ format4 g ^ format4 b;

fun toPPM (Image(wh, carr)) filename =
  let val oc = TextIO.openOut filename
      val (w,h) = size (Image(wh, carr):image)
  in
     TextIO.output(oc,"P3\n" ^ Int.toString w ^ " " ^ Int.toString h ^ "\n255\n");
     (* code to output image rows, one per line goes here *)
	 Array.app (fn i  => (Array.app (fn j => (TextIO.output(oc, colorToString j))) i; TextIO.output(oc,"\n"))) carr;
     TextIO.closeOut oc
  end;
  
fun drawHoriz _ _ _ 0 = ()
  | drawHoriz img c (x, y) i = ((drawPixel img c (x, y)); (drawHoriz img c ((x+1, y):xy) (i-1)));
  
fun drawVert _ _ _ 0 = ()
  | drawVert img c (x, y) i = ((drawPixel img c (x, y)); (drawVert img c ((x, y+1):xy) (i-1)));
  
fun drawDiag _ _ _ 0 = ()
  | drawDiag img c (x, y) i = ((drawPixel img c (x, y)); (drawDiag img c ((x+1, y+1):xy) (i-1)));
  

fun drawLine (img:image) (c:color) ((x0,y0):xy) ((x1,y1):xy) = 
let val dx = Int.abs(x1 - x0)
    val dy = Int.abs(y1 - y0)
	val sx = if (x0 < x1) then 1 else ~1
	val sy = if (y0 < y1) then 1 else ~1
	val err = dx - dy
	fun loop (x, y) myErr = 
	let val e2 = myErr * 2
	in
        (drawPixel img c (x, y);
		 if ((x = x1) andalso (y = y1)) then ()
		 else if (e2 > ~dy) andalso (e2< dx) then loop (x+sx, y+sy) (myErr - dy + dx) (*do not forget the case if both conditions are true*)
		 else if (e2 > ~dy) then loop (x+sx, y)  (myErr-dy)       (*use () outside expression myErr-dy*)
		 else if (e2 < dx) then loop (x, y+sy) (myErr+dx) 
		 else ())
	end;
in loop (x0, y0) err end;
