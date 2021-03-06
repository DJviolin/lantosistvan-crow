FROM crow_base:1.0.0
MAINTAINER Istvan Lantos <kerozin.joe@gmail.com>
LABEL com.lantosistvan.version="1.0.0" \
      com.lantosistvan.environment="production" \
      com.lantosistvan.description="App"

ENV BOOST_VERSION="1.61.0" \
    BOOST_ARCHIVE="boost_1_61_0"

# gcc libc6-dev
RUN echo "\
    deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie main\n\
    deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie main\n\
    # 3.8\n\
    deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.8 main\n\
    deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.8 main\n\
    # 3.9\n\
    deb http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main\n\
    deb-src http://apt.llvm.org/jessie/ llvm-toolchain-jessie-3.9 main" > /etc/apt/sources.list.d/llvm.list \
    && buildDeps='\
        ca-certificates \
        curl \
        make' \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        $buildDeps \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        libtcmalloc-minimal4 \
    && ln -s /usr/lib/libtcmalloc_minimal.so.4 /usr/lib/libtcmalloc_minimal.so \
    && boostDeps='\
        gcc \
        g++ \
        python-dev \
        autotools-dev \
        libicu-dev \
        libbz2-dev \
        zlib1g-dev' \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        $boostDeps \
    && curl http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && clangDeps='\
        clang-4.0 \
        lldb-4.0' \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --force-yes --no-install-recommends --no-install-suggests \
        $clangDeps \
    && ln -s /usr/bin/clang-4.0 /usr/bin/clang \
    && ln -s /usr/bin/clang++-4.0 /usr/bin/clang++ \
    && clang --version \
    && clang++ --version \
    && rm -rf /var/lib/apt/lists/* \

    ##&& curl -fSL "http://downloads.sourceforge.net/project/boost/boost/$BOOST_VERSION/$BOOST_ARCHIVE.tar.gz" -o "$BOOST_ARCHIVE.tar.gz" \
    ##&& mkdir -p $HOME/boost /root/www/app/src/include/boost \
    ##&& tar -xzf "$BOOST_ARCHIVE.tar.gz" -C $HOME/boost --strip-components=1 \
    #&& cp -ar $HOME/boost/boost/ /root/www/app/src/include \
    #&& rm -rf "$BOOST_ARCHIVE"* $HOME/boost \
    #&& ls -al /root/www/app/src/include/boost \

    && curl -fSL "https://github.com/ipkn/crow/archive/master.tar.gz" -o "crow.tar.gz" \
    && mkdir -p $HOME/crow /root/www/app/src/include/amalgamate \
    && tar -xzf "crow.tar.gz" -C $HOME/crow --strip-components=1 \
    #&& cp -ar $HOME/crow/amalgamate/ /root/www/app/src/include \
    #&& rm -rf "crow.tar.gz"* $HOME/crow /root/www/app/src/include/amalgamate/merge_all.py \
    #&& ls -al /root/www/app/src/include/amalgamate \

    && curl -fSL "https://github.com/no1msd/mstch/archive/master.tar.gz" -o "mstch.tar.gz" \
    && mkdir -p $HOME/mstch /root/www/app/src/include/mstch \
    && tar -xzf "mstch.tar.gz" -C $HOME/mstch --strip-components=1
    #&& cp -ar $HOME/mstch/include/mstch/ /root/www/app/src/include \
    #&& rm -rf "mstch.tar.gz"* $HOME/mstch \
    #&& ls -al /root/www/app/src/include/mstch

RUN mkdir -p $HOME/boost \
    && curl -fSL "http://downloads.sourceforge.net/project/boost/boost/$BOOST_VERSION/$BOOST_ARCHIVE.tar.gz" -o "$BOOST_ARCHIVE.tar.gz" \
    && tar -xzf "$BOOST_ARCHIVE.tar.gz" -C $HOME/boost --strip-components=1

RUN mkdir -p /root/www/app/bin \
             #/root/www/app/src/include/boost \
             /root/www/app/src/include/crow \
             /root/www/app/src/include/mstch  \
    && ls -al /root/www/app/src/include \
    #&& cp -a $HOME/boost/boost/* /root/www/app/src/include/boost \
    #&& cp -ar $HOME/crow/amalgamate/ /root/www/app/src/include \
    && cp -a $HOME/crow/include/* /root/www/app/src/include/crow \
    && cp -a $HOME/mstch/include/mstch/* /root/www/app/src/include/mstch

COPY . /root/www/app

RUN cd $HOME/boost \
    && ./bootstrap.sh --show-libraries \
    && ./bootstrap.sh \
      --prefix=/usr/local \
      --without-libraries=mpi \
    && ./b2 --with=all install \
    && rm -rf $HOME/boost
    #&& ls -al /root/www/app/src/include/boost
RUN cd /root/www/app \
    && make \
    && chmod +x /root/www/app/bin/main

    && apt-get purge -y --auto-remove \
        $buildDeps \
        $clangDeps \
    && echo "Showing /var/lib/apt/lists directory:" \
    && ls -al /var/lib/apt/lists \
    && rm -rf /usr/src/* /var/lib/apt/lists/*

CMD ["echo", "lantosistvan_app container finished!"]
