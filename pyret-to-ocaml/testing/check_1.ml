(*
 * This is a valid pyret program:
 *
 * fun f(x): g(x + x) end
 *
 * fun g(y): y * y end
 *
 * f(10)
 *
 * Problem: I need to switch around the order s.t. the function in f(), g(), gets compiled
 * before f(), like below.
 *
 * Solution: Recursively compile functions s.t. you use 'and' instead of 'let rec' for sub-functions
 * i.e. not top-level functions.
 *)

let rec f x = g(x + x)

and g y = y * y;;

f(10);;
