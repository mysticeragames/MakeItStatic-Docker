#!/bin/bash

# clone cms into a local folder (latest main branch, without other history)
git clone --depth=1 --branch main https://github.com/mysticeragames/MakeItStatic-CMS.git cloned-cms-test

# other branch:
#git clone --depth=1 --branch phpcs https://github.com/mysticeragames/MakeItStatic-CMS.git cloned-cms-test
