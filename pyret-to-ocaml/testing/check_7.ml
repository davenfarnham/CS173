class t = 
  object
    method get_value = ()
    method add_value = ()
  end 
;;

(* make all objects have the same add_value method *)
class integer (value : int) = 
  object
    val mutable i : int = value
    method get_value = i
    method add_value (y : integer) = i <- (y#get_value + i)
  end
;;

class str (value : string) = 
  object
    val mutable s : string = value
    method get_value = s
    method add_value (y : str) = s <- (y#get_value ^ s)
  end
;;

(* pyret: 4 + 3 *)  
let x = new integer 4 in
  let y = new integer 3 in
    assert(x#add_value y; x#get_value = 7)
;;


(* creates a compile time error instead of a dynamic error *)
let a = new integer 4 in 
  let b = new str "hi" in
    a#add_value b
;;


(*
  fun f(x :: Number) -> String:
    ---
  end

  f(4)
*)

let c = new integer 4 ;;
let d = new str "hi" ;;

let f (x : integer) : string =
  "hi"
;;

(*f d ;;*)

(* how do you deal with lists? *)
(* have an overarching type t that you cast up to, this has a single self function
to cast back down -> return unit *)
(* use this when construcing lists and then going from lists back to specific type
objects *)
