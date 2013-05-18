wavelect: wavelect.cmo
	ocamlc graphics.cma unix.cma wavelect.cmo

wavelect.cmo: wavelect.ml
	ocamlc -c wavelect.ml

wavelect.ml: wavelect.mll
	ocamllex wavelect.mll

clean:
	rm -f wavelect.ml *.cmi *.cmo *.out
