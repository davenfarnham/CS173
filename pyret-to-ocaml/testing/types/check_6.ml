- addition layer of wrapping:

	(* additional layer of wrapping *)
	type ps = PS of string
	and bs = BS of bool

        and t = B of bs | S of ps ;;

- redefine certain operators, for example:

	'+' only works with numbers and not strings; change "+" for strings to "++"

- lists are now monotyped

- if you are given a function that is annotated, like:

	hyp(x :: Number, y :: Number) -> Number:
		body
	end

		if there are annotations on this function (maybe keep track by passing around info in record),
		when you compile a number (or id) go down an additionally level, so instead of stopping at B(BS(true))
		go down another level to (BS true). 
