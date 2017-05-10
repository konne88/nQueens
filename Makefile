SRC_COQ=src/coq
SRC_RKT=src/racket

.PHONY: build clean

build: 
	# build and extract coq
	cd $(SRC_COQ); find . -name '*.v' -exec coq_makefile -R . "Queens" -o Makefile {} +
	make -C$(SRC_COQ)
	# assemble racket program queens.rkt
	cp $(SRC_RKT)/header.rkt queens.rkt
	tail -n +4 $(SRC_COQ)/queens.scm >> queens.rkt
	cat $(SRC_RKT)/queens.rkt >> queens.rkt
	# make SpaceSearch racket files discoverable
	mkdir src/racket/rosette; ln -sf `opam config var coq:lib`/user-contrib/SpaceSearch/*.rkt src/racket/rosette/
	# compile program
	raco make queens.rkt
	chmod +x queens.rkt

clean:
	find . \( \
          -name "*.glob" -o \
          -name "*.v.d" -o \
          -name "*.scm" -o \
          -name "*.vo" -o \
          -name ".*.aux" -o \
          -name "#*#" -o \
          -name ".#*" -o \
          -name "*~" \
        \) -exec rm -f {} +
	find . -name .coq-native -o -name compiled -exec rm -r {} +
	rm -rf $(SRC_COQ)/Makefile queens.rkt src/racket/rosette/

