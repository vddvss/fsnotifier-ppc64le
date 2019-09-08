# Copyright 2019 Colin Samples
#
# SPDX-License-Identifier: Apache-2.0
#

# Compile flags and versioning from:
# https://github.com/JetBrains/intellij-community/blob/8bccacc45e0e9d93fdc68103eca440aa65fd3acd/native/fsNotifier/linux/make.sh

CFLAGS := -O2 -Wall -Wextra -Wpedantic -std=c11 -D_DEFAULT_SOURCE

prefix := /usr/local
libexecdir := $(prefix)/libexec

version := $(shell date "+%Y%m%d.%H%M")

objects := $(patsubst %.c,%.o,$(wildcard *.c))

output-binary := fsnotifier-ppc64le

.INTERMEDIATE: fsnotifier.h.version
fsnotifier.h.version:
	sed -i 's/#define VERSION .*/#define VERSION "$(version)"/' fsnotifier.h

%.o : %.c fsnotifier.h.version
	$(CC) -c $(CFLAGS) $< -o $@

$(output-binary): $(objects)
	$(CC) $(LDFLAGS) $^ -o $@

.DEFAULT_GOAL := all
.PHONY: all
all: $(output-binary)

.PHONY: check
check: $(output-binary)
	./$(output-binary) --selftest

.PHONY: install
install: $(output-binary)
	install -d $(DESTDIR)$(libexecdir)
	install $< -t $(DESTDIR)$(libexecdir)
	@echo
	@echo Installation complete.
	@echo
	@echo "Add the below line to your idea.properties file \
	(more information is available in README.md or at \
	https://www.jetbrains.com/help/idea/tuning-the-ide.html#configure-platform-properties):"
	@echo
	@echo idea.filewatcher.executable.path=$(shell realpath $(DESTDIR)$(libexecdir)/$(output-binary))
	@echo

.PHONY: clean
clean:
	rm -f *.o $(output-binary)
