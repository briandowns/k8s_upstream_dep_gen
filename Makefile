GO     ?= go
DOCKER ?= docker

BINDIR = bin
BINARY = dep_gen

VERSION = v0.1.0
PREFIX = /usr/local

LDFLAGS = -ldflags "-X main.gitSHA=$(shell git rev-parse HEAD) -X main.version=$(VERSION) -X main.name=$(BINARY)"

$(BINDIR)/$(BINARY): $(BINDIR) clean
	$(GO) build -v -o $@ $(LDFLAGS)

$(BINDIR):
	mkdir -p $@

.PHONY: install
install: $(BINDIR)/$(BINARY)
	mkdir -p $(PREFIX)/bin
	cp $< $(PREFIX)/bin

.PHONY: uninstall
uninstall:
	rm -f $(PREFIX)/bin/$(BINDIR)/$(BINARY)

.PHONY: image-build
image-build:
	$(DOCKER) build -t briandowns/$(BINARY):$(VERSION) .

.PHONY: image-push
image-push:
	$(DOCKER) push briandowns/$(BINARY):$(VERSION)

.PHONY: clean
clean:
	$(GO) clean
	rm -f $(BINDIR)/*
	rm -rf tmp/* tmp/.drone.yml
	rm -f *.out
