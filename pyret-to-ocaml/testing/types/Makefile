all: check_1 check_2 check_3 check_4 check_5

check_1: check_1.ml
	corebuild check_1.native

check_2: check_2.ml
	corebuild check_2.native

check_3: check_3.ml
	corebuild check_3.native

check_4: check_4.ml
	corebuild check_4.native

check_5: check_5.ml
	corebuild check_5.native

clean:
	rm -rf *.native _build
