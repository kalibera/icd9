FROM rocker/r-devel:latest

# use unstable to get the right development library versions
RUN apt-get update && apt-get --yes dist-upgrade && apt-get --yes install \
	libxml2-dev/unstable \
	libssl-dev/unstable \
	libcurl4-openssl-dev \
	texlive-base \
	fonts-inconsolata \
	git \
	libssh2-1-dev \
	qpdf \
	pandoc \
    	pandoc-citeproc
# switch libssh2-1-dev, or all updates to 'unstable' at some point?

 RUN cd /tmp \
        && svn co http://svn.r-project.org/R/trunk R-devel

# GCC UBSAN and OpenMP don't work together in any version! appears to be no evidence of fix
# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=64888

ENV ASAN_OPTIONS detect_leaks=0:detect_odr_violation=0

# build R-devel again, but with sanitizers
RUN cd /tmp/R-devel \
        && R_PAPERSIZE=letter \
           R_BATCHSAVE="--no-save --no-restore" \
           R_BROWSER=xdg-open \
           PAGER=/usr/bin/pager \
           PERL=/usr/bin/perl \
           R_UNZIPCMD=/usr/bin/unzip \
           R_ZIPCMD=/usr/bin/zip \
           R_PRINTCMD=/usr/bin/lpr \
           LIBnn=lib \
           AWK=/usr/bin/awk \
           CFLAGS="-g -Wall -pedantic -O0" \
           CXXFLAGS="-g -Wall -pedantic -O0" \
           CC="gcc -std=gnu99 -fsanitize=address,undefined -fno-omit-frame-pointer" \
           CXX="g++ -fsanitize=address,undefined  -fno-omit-frame-pointer -fno-sanitize=object-size,vptr" \
           CXX1X="g++ -fsanitize=address,undefined  -fno-omit-frame-pointer -fno-sanitize=object-size,vptr" \
           FC="gfortran -fsanitize=address" \
           F77="gfortran -fsanitize=address" \
	   FCFLAGS="-g -O0 -mtune=native" \
	   FFLAGS="-g -O0 -mtune=native" \
	   MAIN_LDFLAGS="-fsanitize=address,undefined" \
           ./configure --enable-R-shlib \
               --without-blas \
               --without-lapack \
	       --disable-openmp \
               --with-readline \
               --without-recommended-packages \
               --program-suffix=dev \
        && make -j5 \
        && make install \
        && make clean

#TODO: remove or keep -O0 flags? Not sure which would be most helpful. Most code in production use is compiled O2, but I don't know whether O0 would uncover the same UBSAN bugs, or just allow them to be characterized more easily.

RUN Rscript -e 'install.packages(c("Rcpp", "checkmate", "testthat", "devtools", "knitr", "microbenchmark", "magrittr", "XML", "memoise", "profr", "ggplot2", "digest", "xtable", "rmarkdown", "codetools", "fastmatch"))'

ADD ../build_install_check_in_docker.sh /tmp/
ENV LD_PRELOAD /usr/lib/x86_64-linux-gnu/libasan.so.2
ENV R_CMD Rdevel
CMD ["/tmp/build_install_check_in_docker.sh"]
