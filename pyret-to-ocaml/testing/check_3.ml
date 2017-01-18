(*
 * Playing with types and how to convert Pyret 'types' and 'data' 
 * to comparable data structures in ocaml.
 *
 * I think what I want to do is use basic building blocks like: int, float, string, bool, and list. 
 *
 * 	- I'm not sure pyret has equivalent primitives for these ocaml builtins: char, array, exn, options, functions, tuples
 *
 * After this, whenever I run into a 'type' in pyret, create a 'type' definiton in ocaml. So, for example, 
 *
 *	- (pyret) type Store = List<StoreCell> gets parsed into: 
 *			
 *			- name: Store
 *			- ann.ann: List
 *			- ann.args: Storecell
 *
 *	- turn this into the ocaml: type store = storecell list;
 *
 * Let's say I have a function in pyret like this:
 *
 * fun f(x :: Number, s :: Store):
 *   # do something
 * end
 *
 * if I'm converting everything to unitypes, how do I maintain the granularity s.t. when I compile that function
 * to ocaml and pass it a (S "hi") it'll give me a compile time error instead of a runtime error. 
 * 
 * I think using ADTs makes it almost impossible to get the kind of generality + granularity you need. First, I think
 * I'll work on data and types without any annotations. Later, when I worry about annotations, I'll probably need to 
 * to convert the current structure away from an ADT model to an oject model.
 *)

(* The key here is that you need to be able to access the fields, which is why I use ocaml records.

pyret code:

  fun f(st):
    cases(Store) st:
      | empty => empty
      | link(hd, tl) => link(hd.loc, f(tl))
    end
  end

ocaml code:

  let rec f (st : store) = 
    match st with
    | [] -> []
    | storecell :: tl -> let {loc = l; value = _} = storecell in l :: (f tl)
  ;;

*)

type store_cell = {loc: t; value: t;}
and storecell = STORE_CELL of store_cell 

(* add this to the basic type definition *)
and number = I of int | F of float

and newnum = number

and newstring = string

(* simple renaming of list to store. I like this - STORE is structurally a list; it can hold anything, including a storecell.
   also, in this way, I can simply rename number as a newnum and the only thing I need to do is recur on this new variant just
   like I do with N *)
and t = N of number | S of string | B of bool | L of t list | STORE of t list | STORECELL of storecell | NEWNUM of newnum | NEWSTRING of newstring ;;

(* check creating a storecell *)
let stcell = STORE_CELL{loc = (N (I 4)); value = (S "hi")} ;;

(* check creating a store *)
let st = STORE ((STORECELL (STORE_CELL {loc = (N (I 4)); value = (S "hi")})) :: []) ;;

let rec f (st : t list) = 
  match st with
  | [] -> []
  | (STORECELL (STORE_CELL {loc = l; value = _})) :: tl -> l :: (f tl)
;;
