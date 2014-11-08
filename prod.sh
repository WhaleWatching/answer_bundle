#! /bin/bash
# build bundle prod

gulp env:prod path:bundle clean
gulp env:prod path:bundle pipe:res
gulp env:prod path:bundle pipe:views