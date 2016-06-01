# Ironic, isn't it?

.PHONY: all
all: index.html

.PHONY: clean
clean:
	@- rm ./index.html

./index.html: ./head.html ../Makefile generate-html.js
	./generate-html.js ./head.html ../Makefile > $@


