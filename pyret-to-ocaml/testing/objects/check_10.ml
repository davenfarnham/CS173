(*
      data StoreCell:
        | store_cell(loc :: String, val :: Number)
      end 
      
      type Store = List<StoreCell>
      
      fun f(sto):
        cases(Store) sto:
          | link(hd, tl) => 
            cases(StoreCell) hd:
              | store_cell(l, v) => l
            end
        end
      end
*)

(* basic types *)
type t = I of int | F of float | S of string | L of t list ;; 

type store_cell = {loc: t; value: t; } ;;

(* storecell is a STORE_CELL *)
type storecell = | STORE_CELL of store_cell ;;

type store = storecell list ;;

let rec f sto = 
  (match sto with
   | (hd :: tl) -> (match hd with
		  | STORE_CELL({loc = l; value = _}) -> l))
;;

(* create store_cell *)
let create_store_cell l v : store_cell = {loc = l; value = v} ;;

(* create storecell *)
let create_storecell s : storecell = STORE_CELL(s) ;;

(* create store *)
let create_store v : store = [v] ;;

let _ = f (create_store (STORE_CELL({loc = (I 4); value = (S "hi")}))) ;;

let x = (create_store (STORE_CELL({loc = (I 4); value = (S "hi")}))) in
  let y = (create_store (STORE_CELL({loc = (I 4); value = (S "hi")}))) in
    match x with
    | hd :: tl -> (match y with
		   | h1 :: tl1 -> tl @ tl1)
;;
