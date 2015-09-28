
CCS := $(wildcard src/*.cc)
HHS := $(wildcard include/*.hh)

CXXFLAGS := -std=gnu++11 -I./include
LIBS := -lgc

bin/snow: $(CCS) $(HHS)
	g++ -g -o bin/snow $(CCS) $(CXXFLAGS) $(LIBS)

clean:
	rm bin/snow
