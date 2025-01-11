#!/bin/bash

# run tests with (coverage) reports

# Run the cms container as root (needed because the volume is also mounted as root)
# Mount local './phpunit_reports/' to container '/var/www/html/reports/'
# Run the phpunit tests, output to ./reports
# Then finally, make your current user the owner of all the files in ./report (chown)

docker run --rm \
    --name makeitstatic-phpunit \
    -u 0:0 \
    -e UID=$(id -u) \
    -e GID=$(id -g) \
    -v $(pwd)/phpunit_reports:/var/www/html/reports \
    mysticeragames/makeitstatic-cms:local sh -c "rm -rf ./reports/* && XDEBUG_MODE=coverage php bin/phpunit --testdox-html ./reports/testdox.html --log-junit ./reports/junit.xml --log-events-text ./reports/log-events.txt --log-teamcity ./reports/log-teamcity.txt --log-events-verbose-text ./reports/log-events-verbose.txt --coverage-html ./reports/coverage && chown -R $UID:$GID ./reports"

# Show reports (WSL2)
powershell.exe -c phpunit_reports/coverage/index.html
powershell.exe -c phpunit_reports/testdox.html
