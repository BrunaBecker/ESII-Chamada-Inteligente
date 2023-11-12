#!/bin/bash

# Define an array of test files
TEST_FILES=(
  "test/integration_test/login_test.dart"
  "test/integration_test/notification_test.dart"
)

# Iterate over the array and run each test
for testFile in "${TEST_FILES[@]}"; do
  flutter test "$testFile"
done
