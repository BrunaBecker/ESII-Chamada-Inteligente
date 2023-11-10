#!/bin/bash

cd test_driver/test/integration_test

# Iterate and run each test file
for testFile in $(find . -name '*_test.dart'); do
  flutter drive --target="$testFile"
done
