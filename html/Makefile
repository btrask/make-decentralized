# Ironic, isn't it?

.PHONY: all
all: index.html

index.html: ./head.html ../Makefile generate-html.js
	cat ./head.html > $@
	./generate-html.js ../Makefile >> $@


