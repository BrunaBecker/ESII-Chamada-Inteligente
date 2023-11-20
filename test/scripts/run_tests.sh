#!/bin/bash

# Define an array of test files
TEST_FILES=(
  "test/integration_test/login_test.dart"
  "test/integration_test/iniciar_chamada_test.dart"
  "test/integration_test/chamada_ativa_test.dart"
  "test/unit_test/interagir_turma_test.dart.dart"
#  "test/unit_test/interagir_turma_student_test.dart.dart"
  "test/unit_test/minhas_turmas_student_test.dart.dart"
  "test/unit_test/minhas_turmas_student_test.dart.dart"
)

# Iterate over the array and run each test
for testFile in "${TEST_FILES[@]}"; do
  flutter test "$testFile"
done
