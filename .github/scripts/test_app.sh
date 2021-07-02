#!/bin/bash

set -eo pipefail

xcodebuild -project DinkleBot/DinkleBot.xcodeproj \
            -scheme DinkleBot \
            -destination platform=iOS\ Simulator,OS=14.4,name=iPhone\ 11 \
            clean test | xcpretty
