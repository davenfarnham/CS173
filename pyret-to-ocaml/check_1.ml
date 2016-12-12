open Core.Std ;;

(*
 * This is a valid pyret program:
 *
 * fun f(x): g(x + x) end
 *
 * fun g(y): y * y end
 *
 * f(10)
 *
 * I need to switch around the order s.t. the function in f(), g(), gets compiled
 * before f(), like below.
 *)

let g y = y * y;;

let f x = g(x + x);;

f(10);;
