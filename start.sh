#!/bin/bash

/usr/local/bin/gitlab-runner register --non-interactive --url "https://gitlab.com/" --registration-token ${TOKEN} --executor "shell" --description ${HOSTNAME} --tag-list "glr,test" --run-untagged --locked="false" -c /home/gitlab-runner/config.toml

TOKEN=`cat /home/gitlab-runner/config.toml | grep token | awk -F '"' '{print $2}'`

/usr/local/bin/gitlab-runner run-single -u "https://gitlab.com" -t ${TOKEN} --executor "shell" --max-builds 1

/usr/local/bin/gitlab-runner unregister -u "https://gitlab.com" -t ${TOKEN}