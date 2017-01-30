(* 
  So let's say I'm given this pyret program:

      data StoreCell:
        | store_cell(loc, value)
      end 
      
      type Newnum = Number     
      type Store = List<StoreCell>

  how should I convert it to ocaml?

  1) have a function that sorts out all type and data expressions from the list of 'stmts'

		- if I see a 'type' or 'data' defined, take what is in brackets, so the type of the new datatype, and add this to ta:

			1.1) 'and name (lowercase) = type (whatever was in brackets)'. so above would turn into:

				(* for 'types' *)
				and newnum = number

				and store = t list

				(* create a match case for the elements in the data, like below *)
				and storecell = STORE_CELL of store_cell 


			     also add '| NEWNUM of newnum' to ta:

				ta = ta + " | NEWNUM of newnum' ;;

			1.2) add name -> type to environment; you can then call a function on the environment which'll update
		             the other global variables sprinkled around the type definition.

		
				{    NEWNUM -> number 	}
				{   NEWERNUM -> newnum  }
				{     STORE -> t list   }

			1.3) call a function on the environment to reduce to basic types:

				{    NEWNUM -> number 	}
				{   NEWERNUM -> number  }
				{     STORE -> t list   }
			
			1.4) add these definitions to all the match cases


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
