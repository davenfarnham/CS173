(* trying to pull it all together - for this to work you need to keep an environment around 
 * mapping new types -> the basic types they're renaming. So, for example, below you'd have something
 * like this:
 *
 *			{     STORE -> list      }
 *			{ STORECELL -> storecell }
 *			{    NEWNUM -> number 	 }
 *			{  NEWSTRING -> string   }
 *)

exception TypeError
exception Unsupported

(* helpful list functions *)
let link a b = a :: b ;;
let empty = [] ;;

(* basic types: after compiling types and data *)
type t = N of number | S of string | B of bool | L of t list | STORE of t list (* ADD HERE: type definitions *)

and number = I of int | F of float

(* ADD HERE *)

;;
               
let to_bool t : bool = match t with | B(b) -> b | _ -> raise TypeError ;;

(* string to int -> int -> int function *)
let s_to_op s =
  match s with
  | "op-" -> ( - )
  | "op*" -> ( * )
  | "op/" -> ( / )
  | _ -> raise Unsupported
;;

(* string to float -> float -> float function *)
let s_to_fop s =
  match s with
  | "op-." -> ( -. )
  | "op*." -> ( *. )
  | "op/." -> ( /. )
  | _ -> raise Unsupported
;;

(* string to 'a -> 'a -> bool function *)
let s_to_bop s =
  match s with
  | "op>" -> ( > )
  | "op>=" -> ( >= )
  | "op<" -> ( < )
  | "op<=" -> ( <= )
  | "op==" -> ( = )
  | "op<=>" -> ( == )
  | _ -> raise Unsupported
;;

(* string operations *)
let string_op op a b = 
  match op with
  | "op+" -> S(a ^ b)
  | "op>" | "op>=" | "op<" | "op<=" as op' -> B((s_to_bop op') a b)
  | "op==" | "op<=>" as op' -> B((s_to_bop op') a b)
  | "op=~" -> raise Unsupported
  | _ -> raise TypeError
;;

(* int operations *)
let int_op op a b = 
  match op with
  | "op+" -> N(I(a + b))
  | "op>" | "op>=" | "op<" | "op<=" | "op==" | "op<=>" as op' -> B((s_to_bop op') a b)
  | "op-" | "op*" | "op/" as op' -> N(I((s_to_op op') a b))
  | "op=~" -> raise Unsupported
  | _ -> raise TypeError
;;

(* float operations *)
let float_op op a b = 
  match op with
  | "op+" -> N(F(a +. b)) (* contagion *)
  | "op>" | "op>=" | "op<" | "op<=" | "op==" | "op<=>" as op' -> B((s_to_bop op') a b)
  | "op-" | "op*" | "op/" as op' -> N(F((s_to_fop (op' ^ ".")) a b)) 
  | "op=~" -> raise Unsupported
  | _ -> raise TypeError
;;

(* list operations *)
let list_op op a b = 
  match op with
  | "op+" -> L(a @ b)
  | "op>" | "op>=" | "op<" | "op<=" | "op==" | "op<=>" as op' -> B((s_to_bop op') a b)
  | "op=~" -> raise Unsupported
  | _ -> raise TypeError
;;  

(* bool operations *)
let bool_op op a b = 
  match op with
  | "op==" | "op<=>" as op' -> B((s_to_bop op') a b)
  | "op=~" -> raise Unsupported
  | _ -> raise TypeError
;;

(* the below will have to have some dynamically generated sections *)

(* branch based on right type *)
let t_int_right op a r = 
  match r with
  | N(I(b)) -> int_op op a b
  | N(F(b)) -> float_op op (float_of_int a) b

  (* ADD HERE *)

  | _ -> raise TypeError
;;

let t_float_right op a r = 
  match r with
  | N(I(b)) -> float_op op a (float_of_int b)
  | N(F(b)) -> float_op op a b

  (* ADD HERE *)

  | _ -> raise TypeError
;;

let t_str_right op a r = 
  match r with
  | S(b) -> string_op op a b

  (* ADD HERE *)

  | _ -> raise TypeError
;;

let t_bool_right op a r =
  match r with
  | B(b) -> bool_op op a b

  (* ADD HERE *)

  | _ -> raise TypeError 
;;

let t_list_right op a r = 
  match r with
  | L(b) -> list_op op a b 

  (* ADD HERE *)

  | _ -> raise TypeError
;;

(* redefine operators for t type - branch based on left type *)
let t_left op l r : t =
  match l with
  | N(I(a)) -> t_int_right op a r
  | N(F(a)) -> t_float_right op a r
  | S(a) -> t_str_right op a r
  | B(a) -> t_bool_right op a r
  | L(a) -> t_list_right op a r

  (* ADD HERE *)

  (* can't use binary operators with new types that aren't renaming of basic types *)
  | _ -> raise TypeError
;;
