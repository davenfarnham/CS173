exception TypeError ;;

type integer = Integer of int ;;

type str = String of string ;;

type t = I of int | S of string ;;

(* get to to_int matching on the type annotation in pyret *)
let to_int (t_type : t) : integer =
  match t_type with
  | I(i) -> (I i)
  | _ -> raise TypeError
;;

let f (i : integer) = let (I k) = i in k + 4 ;;

let _ = f (to_int (S "hi")) ;;
