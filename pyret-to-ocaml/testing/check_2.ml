(*
 * This is the initial idea behind creating unitypes and then 
 * handling those with ocaml functions. This handles the basic primitive
 * builtins: 
 *
 *		(pyret)     (ocaml)
 *
 *		Numbers       int 
 *			     float
 *		 String      string
 *	         Boolean      bool
 *	 	  List        list
 *)

open Core.Std

exception TypeError
exception Unsupported

type t = I of int | F of float | S of string | B of bool | L of t list ;;

let to_bool t : bool = match t with | B(b) -> b | _ -> raise TypeError ;;

(* string to int -> int -> int function *)
let s_to_op s =
  match s with
  | "-" -> ( - )
  | "*" -> ( * )
  | "/" -> ( / )
  | _ -> raise Unsupported
;;

(* string to float -> float -> float function *)
let s_to_fop s =
  match s with
  | "-." -> ( -. )
  | "*." -> ( *. )
  | "/." -> ( /. )
  | _ -> raise Unsupported
;;

(* string to 'a -> 'a -> bool function *)
let s_to_bop s =
  match s with
  | ">" -> ( > )
  | ">=" -> ( >= )
  | "<" -> ( < )
  | "<=" -> ( <= )
  | "==" -> ( = )
  | "<=>" -> phys_equal 
  | _ -> raise Unsupported
;;

(* redefine overloaded operators for t type *)
let t_ol op l r : t = 
  match op with
  | "op+" -> 
	(match l with
         | I(a) -> (match r with
                    | I(b) -> I(a + b)
                    | F(b) -> F(Float.of_int a +. b) (* contagion *) 
                    | _ -> raise TypeError)
    	 | F(a) -> (match r with
                    | I(b) -> F(a +. Float.of_int b) (* contagion *)
                    | F(b) -> F(a +. b)
                    | _ -> raise TypeError)
         | S(a) -> (match r with
            	      | S(b) -> S(a ^ b)
               	      | _ -> raise TypeError)
  	 | L(a) -> (match r with
                    | L(b) -> L(a @ b)
                    | _ -> raise TypeError)
	 | _ -> raise TypeError)
  | "op>" | "op>=" | "op<" | "op<=" as op' -> 
	(match l with
         | I(a) -> (match r with
                    | I(b) -> B((s_to_bop op') a b)
                    | F(b) -> B((s_to_bop op') (Float.of_int a)  b) (* contagion *)
                    | _ -> raise TypeError)
         | F(a) -> (match r with
                    | I(b) -> B((s_to_bop op') a (Float.of_int b)) (* contagion *)
                    | F(b) -> B((s_to_bop op') a b)
                    | _ -> raise TypeError)
         | S(a) -> (match r with
                    | S(b) -> B((s_to_bop op') a b)
                    | _ -> raise TypeError)
         | _ -> raise TypeError)
  | "op=" | "op<=>" as op' ->
  	(match l with
	 | I(a) -> (match r with
		    | I(b) -> B((s_to_bop op') a b)
		    | F(b) -> B((s_to_bop op') (Float.of_int a) b) (* contagion *)
	  	    | _ -> B(false))
	 | F(a) -> (match r with
		    | I(b) -> B((s_to_bop op') a (Float.of_int b)) (* contagion *)
		    | F(b) -> B((s_to_bop op') a b) 
	  	    | _ -> B(false))
	 | S(a) -> (match r with
		    | S(b) -> B((s_to_bop op') a b)
		    | _ -> B(false))
	 | B(a) -> (match r with
		    | B(b) -> B((s_to_bop op') a b)
		    | _ -> B(false))
	 | L(a) -> (match r with
		    | L(b) -> B((s_to_bop op') a b)
		    | _ -> B(false)))
;;

(* redefine number operators for t type *)
let t_num op l r : t = 
  match op with
  | "op-" | "op*" | "op/" as op' -> 
  	(match l with
	 | I(a) -> (match r with
		    | I(b) -> I((s_to_op op') a b)
		    | F(b) -> F((s_to_fop (op' ^ ".")) (Float.of_int a) b) (* contagion *)
		    | _ -> raise TypeError)
	 | F(a) -> (match r with
		    | I(b) -> F((s_to_fop (op' ^ ".")) a (Float.of_int b)) (* contagion *)
		    | F(b) -> F((s_to_fop (op' ^ ".")) a b)
		    | _ -> raise TypeError)
	 | _ -> raise TypeError)
;;
