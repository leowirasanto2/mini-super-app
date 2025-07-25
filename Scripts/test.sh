#!/bin/bash

# Change to the MiniSAPlayground directory
cd "${ROOT:-$(cd "$(dirname "$0")/.." && pwd)}/MiniSAPlayground" || exit 1

# Run tests for MiniSAPlaygroundTests
xcodebuild test \
  -workspace MiniSAPlayground.xcworkspace \
  -scheme MiniSAPlayground \
  -destination "platform=iOS Simulator,name=iPhone 14" \
  -only-testing:MiniSAPlaygroundTests \
  -configuration Debug

# Return the exit code from xcodebuild
exit $?