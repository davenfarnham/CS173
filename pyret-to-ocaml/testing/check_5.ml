(* This is my first look at possibly converting the structure of my compiler to deal with objects instead of an ADT:
 * 
 * I think maybe what I want to do is create objects. If a function is annotated to take an (I int), 
 * I want it to only be able to take that, not any of the pyret unitype. I also want functions, though, 
 * that substitute for normal operators like '+', '-', etc that can take any of the pyret unitype. So essentially, 
 * I want to pass a more general unitype and have the annotation pare it down.
 *)

(* have a type t that all others inherit from, then match on the kind of object when rewriting operators *)

(* class number and string inherit from class t -> so t is a subtype of number and string since any function expecting a 
 * class t will accept a number and string. However, if a function expects an object of type number, you can't pass it a string.
 *)

(* maybe have dummy methods within objects to differntiate them - they are typed structurally 
 * based on their methods
 *)

(* *** I think the key here is to use class types *** *)

(* use this to mimic subtyping -> i might need to use modules *)
class type ty = 
  object
  end
;;

class t = 
  object
    val c = 42
  end
;;

class number = 
  object
    inherit t
  end
;;

class str = 
  object
  end
;;

let f (ty : t) = 
  51
;;

let t' = new t ;;

let _ = f t' ;;

let number' = new number ;;

let _ =  f number' ;;

let str' = new str ;;

let _ =  f str' ;;
