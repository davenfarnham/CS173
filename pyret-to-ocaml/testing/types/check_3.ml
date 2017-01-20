(* 

  So let's say I'm given this pyret program:

      data StoreCell:
        | store_cell(loc, value)
      end 
      
      type Newnum = Number     
      type Store = List<StoreCell>

  how should I convert it to ocaml?

  1) First, you want to add everything defined with 'type' to your type t, using the type definition given. So, for example, add:

	NEWNUM of number | STORE of t list 		(* capitalize name, lowercase type; if list add 't' *)

  2) after adding these things to the type definition ** don't add delimiting ';;' ** add the data defintion, with the above 
  becoming:

	  type t = ... | ... | NEWNUM of number | STORE of t list | STORECELL of storecell

  3) next handle the variants in the data with 'and':

	  and store_cell = {loc: t; value: t}	(* assume all types are of type t - you've added everything to t *)

  4) finally add the name of the data with the variants:

	  and storecell = STORE_CELL of store_cell ;;	(* delimiting this final piece with ';;' *)

  5) next, you need to update the functions that deal with the unitype. I think I need to break up the functions and also have
     an environment to keep track of new types mapped to base types.

*)
