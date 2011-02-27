CC      = gcc
CFLAGS  ?= -O2 -pipe -Wall -Wextra -Wno-variadic-macros -Wno-strict-aliasing
STRIP   = strip
INSTALL = install

LUA_VERSION = 5.1
PREFIX      = /usr/local
LIBDIR      = $(PREFIX)/lib/lua/$(LUA_VERSION)

programs = gettimeofday.so

ifdef NDEBUG
CFLAGS += -DNDEBUG
endif

.PHONY: all strip install clean
.PRECIOUS: %.o

all: $(programs)

%.o: %.c
	@echo '  CC $@'
	@$(CC) $(CFLAGS) -fPIC -nostartfiles -c $< -o $@

%.so: %.o
	@echo '  LD $@'
	@$(CC) -shared $(LDFLAGS) $^ -o $@

%-strip: %
	@echo '  STRIP $<'
	@$(STRIP) $<

strip: $(programs:%=%-strip)

libdir-install:
	@echo "  INSTALL -d $(LIBDIR)"
	@$(INSTALL) -d $(DESTDIR)$(LIBDIR)

%.so-install: %.so libdir-install
	@echo "  INSTALL $<"
	@$(INSTALL) $< $(DESTDIR)$(LIBDIR)/$<

install: $(programs:%=%-install)

clean:
	rm -f $(programs) *.o *.c~ *.h~
