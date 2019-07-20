TOP				=	../..
SRC				=	$(TOP)/src
DOC_SRC			=	$(TOP)/doc

GEN				=	gen
DOC_GEN			=	$(GEN)/doc

DESTDIR			?=	/opt
NET_TIME_MODE	?=	debug

GPRBUILD		=	gprbuild
GPRINSTALL		=	gprinstall
GPRCLEAN		=	gprclean
INSTALL			=	install
CAT				=	cat

#########################################################################################################################

all: net_time.gpr tests.gpr

.PHONY: net_time.gpr tests.gpr

# Add lib targets here.
net_time.gpr:
	$(GPRBUILD) -p -XNET_TIME_MODE=$(NET_TIME_MODE) -Pnet_time.gpr

#########################################################################################################################
# Tests

tests.gpr:
	$(GPRBUILD) -p -XNET_TIME_MODE=$(NET_TIME_MODE) -Ptests.gpr

# Add clean lib targets here

.PHONY: clean

clean:
	$(GPRCLEAN) -Pnet_time.gpr
	$(GPRCLEAN) -Ptests.gpr

#########################################################################################################################

.PHONY: todo

todo:
	grep -riw --color TODO $(SRC)
