#!/bin/bash

find static/img/blog -name '*.png' | xargs -I{} optipng -clobber -force {}
