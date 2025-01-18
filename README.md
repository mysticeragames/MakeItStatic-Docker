# **MakeIt***Static*-Docker

Base Docker image for [MakeItStatic-CMS](https://github.com/mysticeragames/MakeItStatic-CMS)

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mysticeragames/makeitstatic-docker/trigger.release.yml)](https://github.com/mysticeragames/makeitstatic-docker/actions/workflows/trigger.release.yml)
[![GitHub Release Date](https://img.shields.io/github/release-date/mysticeragames/makeitstatic-docker)
](https://github.com/mysticeragames/makeitstatic-docker/releases/latest)
[![GitHub Release](https://img.shields.io/github/v/release/mysticeragames/makeitstatic-docker?sort=semver)](https://github.com/mysticeragames/makeitstatic-docker/releases/latest)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/mysticeragames/makeitstatic-cms-base/latest)
[![Docker Pulls](https://img.shields.io/docker/pulls/mysticeragames/makeitstatic-cms-base)](https://hub.docker.com/r/mysticeragames/makeitstatic-cms-base/tags)
![GitHub License](https://img.shields.io/github/license/mysticeragames/makeitstatic-cms)

## Development

[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mysticeragames/makeitstatic-docker/trigger.main.yml?branch=main&label=build%20(dev-main))](https://github.com/mysticeragames/makeitstatic-docker/actions/workflows/trigger.main.yml)
[![GitHub commits since latest release (branch)](https://img.shields.io/github/commits-since/mysticeragames/makeitstatic-docker/latest/main)](https://github.com/mysticeragames/makeitstatic-docker/commits/main/)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/mysticeragames/makeitstatic-cms-base/dev-main)

## Related

[MakeItStatic-CMS](https://github.com/mysticeragames/MakeItStatic-CMS) |
[MakeItStatic-CI](https://github.com/mysticeragames/MakeItStatic-CI)

## Build & Test locally

```bash
# if needed: get a frech clone:
rm -rf ./cloned-cms-test; ./clone_cms.sh

# build & run phpunit tests
./build_test.sh

# see coverage (optional)
./coverage.sh
```

## Locate installed versions

https://pkgs.alpinelinux.org/packages?name=php84-ctype

```bash
docker run --rm mysticeragames/makeitstatic-cms-base:0.1.4 apk list --installed php84-ctype

# or:
docker run --rm mysticeragames/makeitstatic-cms-base:0.1.4 apk list --installed php84*
```

