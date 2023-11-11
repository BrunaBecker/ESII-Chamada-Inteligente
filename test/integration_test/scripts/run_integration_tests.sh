#!/bin/bash

# Define an array of test files
TEST_FILES=(
  "/home/runner/work/ESII-Chamada-Inteligente/ESII-Chamada-Inteligente/test/integration_test/login_test.dart"
  "/home/runner/work/ESII-Chamada-Inteligente/ESII-Chamada-Inteligente/test/integration_test/notification_test.dart"
)

# Iterate over the array and run each test
for testFile in "${TEST_FILES[@]}"; do
  flutter drive --target="$testFile"
done
