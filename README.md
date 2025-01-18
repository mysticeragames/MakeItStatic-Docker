# **MakeIt***Static*-Docker

Base Docker image for [MakeItStatic-CMS](https://github.com/mysticeragames/MakeItStatic-CMS)

[![GitHub Release](https://img.shields.io/github/v/release/mysticeragames/MakeItStatic-Docker?sort=semver&label=Release)](https://github.com/mysticeragames/MakeItStatic-Docker/releases/latest)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mysticeragames/MakeItStatic-Docker/trigger.release.yml?label=Docker%20Release)](https://github.com/mysticeragames/MakeItStatic-Docker/actions/workflows/trigger.release.yml)
[![GitHub Actions Workflow Status](https://img.shields.io/github/actions/workflow/status/mysticeragames/MakeItStatic-Docker/trigger.main.yml?branch=main&label=Docker%20Development%20(dev-main))](https://github.com/mysticeragames/MakeItStatic-Docker/actions/workflows/trigger.main.yml)
[![Docker Pulls](https://img.shields.io/docker/pulls/mysticeragames/makeitstatic-cms-base?label=Docker%20Pulls%20(cms-base))](https://hub.docker.com/r/mysticeragames/makeitstatic-cms-base/tags)

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

