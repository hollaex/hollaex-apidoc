#!/bin/bash

docker build -t hollaex-apidocs .

docker run --rm --name hollaex-apidocs -v $(pwd)/build:/srv/slate/build hollaex-apidocs