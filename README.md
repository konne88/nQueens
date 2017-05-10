Running
=======

Build with: 

    docker build -t queens .

Find a solution for an 8x8 chessboard with:

    docker run queens

Development
===========

Run development environment console:
    
    docker rm -f queens; docker run --name queens --entrypoint /bin/bash -v $(pwd):/queens -ti queens

If you like the `fish` shell (i do) run:

    docker rm -f queens; docker run --name queens --entrypoint /usr/bin/fish -v (pwd):/queens -ti queens

Build project in development environment console:
    
    make -C /queens

Connect emacs to development environment locally:

    emacs /docker:queens:/queens/src/coq/Queens.v

Connect emacs to development environment remotely:

    emacs "/ssh:user@machine|docker:queens:/queens/src/coq/Queens.v"

Make sure your emacs has `ProofGeneral` and `docker-tramp` installed, and
`enable-remote-dir-locals` must be set.

