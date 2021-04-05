docker run --rm --name slate \
	-v $(pwd)/source/index.html.md:/srv/slate/source/index.html.md \
	-v $(pwd)/source/includes:/srv/slate/source/includes \
	-v $(pwd)/source/images:/srv/slate/source/images \
	-p 4567:4567 \
	slatedocs/slate serve 