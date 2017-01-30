(* recursive modules + functors. The goal is to solve the problem of lists, and cases
   when lists can have other lists inside them -> you need to put everything into a unitype.
   Check_3.ml is not allowing me to recurisvely define objects and types *)

module Integer =
  struct
    let i = ref 0
    let get_value () = !i
    let add_value y = (i := !i + y) 
  end
;;

module Str = 
  struct
    type t = I of 
    let s = ref ""
    let get_value () = !s
    let add_value y = (s := !s ^ y) 
  end
;;
(* and Lists = (* todo *) *)
  
