FROM lantosistvan_base:1.0.0
MAINTAINER Istvan Lantos <kerozin.joe@gmail.com>
LABEL com.lantosistvan.version="1.0.0" \
      com.lantosistvan.environment="production" \
      com.lantosistvan.description="App"

ENV BOOST_VERSION="1.61.0" \
    BOOST_ARCHIVE="boost_1_61_0.tar.gz"

COPY . /root/www/app

# gcc libc6-dev
RUN mkdir -p /root/www/app/bin /root/www/app/src/include/{amalgamate,boost,mstch} \
    && echo "\
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
        make \
        wget' \
    && apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        $buildDeps \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        libtcmalloc-minimal4 \
    && ln -s /usr/lib/libtcmalloc_minimal.so.4 /usr/lib/libtcmalloc_minimal.so
RUN wget -O - http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    #&& curl http://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && clangDeps='\
        clang-4.0 \
        lldb-4.0' \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends --no-install-suggests \
        $clangDeps \
    && rm -rf /var/lib/apt/lists/* \

    && curl -fSL "http://downloads.sourceforge.net/project/boost/boost/$BOOST_VERSION/$BOOST_ARCHIVE" -o "$BOOST_ARCHIVE" \
    && tar -xzf "$BOOST_ARCHIVE" boost -C /root/www/app/src/include/boost --strip-components=1 \
    && ls -al /root/www/app/src/include/boost \
    && rm "$BOOST_ARCHIVE"* \

    && curl -fSL "https://github.com/ipkn/crow/archive/master.tar.gz" -o "crow.tar.gz" \
    && tar -xzf "crow.tar.gz" amalgamate -C /root/www/app/src/include/amalgamate --strip-components=1 \
    && ls -al /root/www/app/src/include/amalgamate \
    && rm "crow.tar.gz"* \
    && rm /root/www/app/src/include/amalgamate/merge_all.py \

    && curl -fSL "https://github.com/no1msd/mstch/archive/master.zip" -o "mstch.tar.gz" \
    && tar -xzf "mstch.tar.gz" include/mstch -C /root/www/app/src/include/mstch --strip-components=1 \
    && ls -al /root/www/app/src/include/mstch \
    && rm "mstch.tar.gz"* \

    && cd /root/www/app
RUN make \
    && chmod +x /root/www/app/bin/main

    && apt-get purge -y --auto-remove \
        $buildDeps \
        $clangDeps \
    && echo "Showing /var/lib/apt/lists directory:" \
    && ls -al /var/lib/apt/lists \
    && rm -rf /usr/src/* /var/lib/apt/lists/*

CMD ["echo", "lantosistvan_app container finished!"]
