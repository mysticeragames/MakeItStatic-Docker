#!/bin/bash

# remove existing local images
if [ -n "$(docker images -q mysticeragames/makeitstatic-cms:base-local 2> /dev/null)" ]; then
    docker rmi -f mysticeragames/makeitstatic-cms:base-local
fi
if [ -n "$(docker images -q mysticeragames/makeitstatic-cms:local 2> /dev/null)" ]; then
    docker rmi -f mysticeragames/makeitstatic-cms:local
fi

echo ""

# cms must have been checked out in directory './cloned-cms-test/'
if [ ! -d "cloned-cms-test" ]; then
    echo "cms directory does not exist yet, run ./clone_cms.sh"
    echo "(or clone another branch manually)"
    exit 1
fi

# build cms-base:
docker build --no-cache -t mysticeragames/makeitstatic-cms:base-local .

# build cms (need to run './local-clone.cms' once first)
docker build --no-cache -t mysticeragames/makeitstatic-cms:local --build-arg BASE_VERSION=local -f ./cloned-cms-test/Dockerfile ./cloned-cms-test/

# run tests
docker run --rm mysticeragames/makeitstatic-cms:local php bin/phpunit
