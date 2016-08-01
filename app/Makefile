CC := clang++
#CFLAGS := -std=c++1z
CFLAGS := -g -Wall -std=c++1z -Isrc/include
BINARY := -Wextra -Wformat -Werror -pedantic
SILENCE := -Wno-unused-parameter -Wno-pessimizing-move -Wno-inconsistent-missing-override -Wno-comment
OPTIMIZE := -Ofast -march=native -ffast-math
BOOST := -lboost_system -lboost_thread
#BOOST_MINGW := -DBOOST_USE_WINDOWS_H
#BOOST_MINGW := -L"C:\msys64\mingw64\lib" -DBOOST_USE_WINDOWS_H
BOOST_MINGW := -DNOGDI -DBOOST_USE_WINDOWS_H -DWIN32_LEAN_AND_MEAN -DBOOST_THREAD_VERSION=4

SRC := $(wildcard src/*.cpp)
BIN := $(patsubst src/%.cpp,bin/%,$(SRC))

all: clean cpp

clean:
	mkdir -p ./bin
	rm -f bin/*

cpp: $(BIN)
$(BIN): bin/%: src/%.cpp
	$(CC) $(CFLAGS) $(BINARY) $(SILENCE) $(OPTIMIZE) $(BOOST) $(BOOST_MINGW) $^ -o $@
