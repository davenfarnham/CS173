open Core.Std

exception ListError

(* basic higher order functions *)
let rec fold_left f i l = 
  match l with
  | [] -> i
  | hd :: tl -> (f hd (fold_left f i tl))
;;

let rec map f l =
  match l with
  | [] -> []
  | hd :: tl -> (f hd) :: (map f tl)
;;

let rec filter p l =
  match l with
  | [] -> []
  | hd :: tl -> if p hd then (hd :: filter p tl) else (filter p tl)
;;

assert(fold_left (fun _ y -> 1 + y) 0 [1;2;3;4] = 4)
assert(map (fun x -> 1 + x) [1;2;3;4] = [2;3;4;5])
assert(filter (fun x -> x > 2) [1;2;3;4] = [3;4])

(* write map and filter with fold_left *)
let map' f = fold_left (fun x y -> (f x) :: y) [] ;;
let filter' f = fold_left (fun x y -> if (f x) then x :: y else y) []

assert(map' (fun x -> 1 + x) [1;2;3;4] = [2;3;4;5])
assert(filter' (fun x -> x > 2) [1;2;3;4] = [3;4])

(* easy applications *)

(* find the max of a list *)
let max l = fold_left (fun x y -> match (x, y) with
				| (_, None) -> x
				| (Some x', Some y') -> if y' > x' then y else x) None l
;;

assert(max [Some 1; Some 9; Some 4; Some (-2)] = (Some )9) ;;

(* some slightly more advanced problems *)

(* given a list 'lst', find the (min, max) *)
let bounds (lst:int list) : (int option * int option) =
  fold_left (fun x y -> (match y with
		          | (Some hd1, Some hd2) -> if x < hd1 then (Some x, Some hd2)
					            else (if x > hd2 then (Some hd1, Some x) else (Some hd1, Some hd2))
		          | (None, None) -> (Some x, Some x)
			  | _ -> raise ListError)) (None, None) lst
;;

assert(bounds [1;2;3] = (Some 1, Some 3)) ;;
assert(bounds [3;2;1] = (Some 1, Some 3)) ;;
assert(bounds [1;2;3] = (Some 1, Some 3)) ;;
assert(bounds [4;-1;5;2;3] = (Some (-1), Some 5)) ;;

(* given a list of lists, find the largest value. Hint: use bounds *)
let max_max (lst : (int list) list) =
  let (_, Some max) = fold_left (fun x y -> (match y with
			                     | (None, None) -> x
			                     | (_, Some y_max) as t -> let (_, Some x_max) = x in
					            	 	         if (y_max > x_max) then t else x
			                     | _ -> raise ListError)) (None, None) (map bounds lst) in max
;;

assert(max_max [[1;2;3];[9;0;8];[10;2;4];[4;3;4]] = 10) ;;

(* zip two lists; assume equal lengths *)
let rec zip lst1 lst2 = 
  match (lst1, lst2) with
  | ([], []) -> []
  | hd :: tl , hd1 :: tl1 -> (hd, hd1) :: (zip tl tl1)
;;

assert(zip [] [] = [])
assert(zip [1;2;3] [4;5;6] = [(1,4); (2,5); (3,6)])

let map2 f lst1 lst2 = fold_left (fun x y -> match x with
				             | (None, None) -> y
				             | (Some hd, Some hd') -> (f hd hd') :: y) [] (zip lst1 lst2)
;;

(* from class *)
let rec list_longer l1 l2 = 
  match (l1, l2) with
  | ([], []) -> false
  | ([], _ :: _) -> false
  | (_ :: _, []) -> true
  | (_ :: tl1, _ :: tl2) -> list_longer tl1 tl2
;;

assert(list_longer [] [] = false) ;;
assert(list_longer [1;2] [3;4] = false) ;;
assert(list_longer [1;2] [3] = true) ;;
assert(list_longer [1;2] [3;4;5] = false) ;;

(* from class *)
let intersect l1 l2 = 
  fold_left (fun x y -> (fold_left (fun x' y' -> if x = x' then x :: y' else y') [] l2) @ y) [] l1 ;;

let intersect' l1 l2 = 
  fold_left (fun x y -> (filter (fun x' -> x = x') l2) @ y) [] l1 ;;

let rec print_list l = 
  match l with
  | [] -> ()
  | hd :: tl -> print_int hd; print_string "\n"; print_list tl
;;

assert(intersect' [] [] = []) ;;
assert(intersect' [1;2;3] [1;2] = [1;2]) ;;
assert(intersect' [1;2;3;4;5;6;7] [1;2;7;4] = [1;2;4;7]) ;;
assert(intersect' [1;2;7;4] [1;2;3;4;5;6;7]  = [1;2;7;4]) ;;

assert(intersect' [] [] = intersect [] []) ;;
assert(intersect' [1;2;3] [1;2] = intersect [1;2;3] [1;2]) ;;
assert(intersect' [1;2;3;4;5;6;7] [1;2;7;4] = intersect [1;2;3;4;5;6;7] [1;2;7;4]) ;;
assert(intersect' [1;2;7;4] [1;2;3;4;5;6;7]  = intersect [1;2;7;4] [1;2;3;4;5;6;7]) ;;

(* from class *)
let list_reverse l = fold_left (fun x y -> y @ [x]) [] l ;;

assert(list_reverse [1;2;3] = [3;2;1]) ;;

let rec fold_right f acc l = 
  match l with
  | [] -> acc
  | hd :: tl -> fold_right f (f hd acc) l
;;

let rec is_set l = 
  match l with
  | [] -> true
  | hd :: tl -> (fold_left (fun x y -> if x = hd then false && y else true && y) true tl) && is_set tl
;;

assert(is_set [1;2;3] = true) ;;
assert(is_set [1;2;3;2] = false) ;;
assert(is_set ["a";"b";"c"] = true) ;;
