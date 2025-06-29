include config.mk

BIN=typetest

SRC=typetest.c

all: $(BIN)

$(BIN): $(SRC)
	$(LD) $(LDFLAGS) $^ -o $@

%.o: %.c
	$(CC) -c $(CFLAGS) -o $@ $^

clean:
	rm -f $(wildcard src/*.o) $(BIN)

dist:
	mkdir -p $(BIN)-$(VERSION)
	cp -rf $(BIN).c README.md LICENSE config.mk Makefile $(BIN)-$(VERSION)
	tar -cf $(BIN)-$(VERSION).tar $(BIN)-$(VERSION)
	gzip $(BIN)-$(VERSION).tar
	rm -rf $(BIN)-$(VERSION)

install:
	mkdir -p $(DESTDIR)/$(PREFIX)/bin
	cp -f $(BIN) $(DESTDIR)$(PREFIX)/bin/$(BIN)
	chmod 755 $(DESTDIR)$(PREFIX)/bin/$(BIN)

uninstall:
	rm -f $(DESTDIR)/$(PREFIX)/bin/$(BIN)

.PHONY: all clean dist install uninstall
