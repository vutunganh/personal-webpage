#!/bin/bash

source ./properties.sh

scp *.html *.css *.js "${USERNAME}"@"${SERVER_NAME}":"${TARGET_PATH}"
