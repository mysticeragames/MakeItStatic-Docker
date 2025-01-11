# **MakeIt***Static*-Docker

Base Docker image for [MakeItStatic-CMS](https://github.com/mysticeragames/MakeItStatic-CMS)

- https://hub.docker.com/r/mysticeragames/makeitstatic-cms/tags?name=base-


## Test locally

```bash
# build cms-base:
docker build --no-cache -t mysticeragames/makeitstatic-cms:base-local .

# build cms:
docker build --no-cache -t mysticeragames/makeitstatic-cms:local --build-arg BASE_VERSION=local -f ../MakeItStatic-CMS/Dockerfile ../MakeItStatic-CMS

# run tests
docker run --rm mysticeragames/makeitstatic-cms:local php bin/phpunit
docker run --rm mysticeragames/makeitstatic-cms:local php -v
```
