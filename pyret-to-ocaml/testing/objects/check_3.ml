exception TypeError

(* object for integers *)
class integer (value : int) =
  object
    val mutable i : int = value
    method get_value = i
    method add_value (y : integer) = i <- (y#get_value + i)
  end

(* object for floats *)
and floating (value : float) =
  object
    val mutable f : float = value
    method get_value = f
    method add_value (y : floating) = f <- (y#get_value +. f)
  end

(* object for strings *)
and str (value : string) =
  object
    val mutable s : string = value
    method get_value = s
    method add_value (y : str) = s <- (y#get_value ^ s)
  end

(* object for bools *)
and boolean (value : bool) =
  object
    val mutable b : bool = value
    method get_value = b
    method add_value (y : boolean) : bool = raise TypeError
  end
;;


(* trouble here - I want this type definition to include lists *)
type t = I of integer | F of floating | S of str | B of boolean 

(* object for lists *)
and class listing (value : t) = 
  object
    val mutable l = [value]
    method get_value = l
    method add_value (y : listing) = l <- (y#get_value @ l)
  end
;;
