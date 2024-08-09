#!/bin/bash

PATH=../../src:$PATH

function test_output() {
  test_title="$1"
  expected_output_file="$2"

  if diff - "$expected_output_file" >/dev/null 2>&1; then
    echo "$test_title: OK"
  else
    echo "$test_title: KO"
  fi
}

echo -ne "a\0" | list-files-and-dirs | test_output "Test 1" <(echo -ne "a\0")
echo -ne "/a\0" | list-files-and-dirs | test_output "Test 2" <(echo -ne "/a\0")
echo -ne "a/b/c/d\0" | list-files-and-dirs | test_output "Test 3" <(echo -ne "a/b/c/d\0a/b/c\0a/b\0a\0")
echo -ne "/a/b/c/d\0" | list-files-and-dirs | test_output "Test 4" <(echo -ne "/a/b/c/d\0/a/b/c\0/a/b\0/a\0")
echo -ne "a/b/c\0d/e/f\0" | list-files-and-dirs | test_output "Test 5" <(echo -ne "a/b/c\0a/b\0a\0d/e/f\0d/e\0d\0")
echo -ne "/a/b/c\0/d/e/f\0" | list-files-and-dirs | test_output "Test 6" <(echo -ne "/a/b/c\0/a/b\0/a\0/d/e/f\0/d/e\0/d\0")
echo -ne "/a/b/c\0d/e/f\0" | list-files-and-dirs | test_output "Test 7" <(echo -ne "/a/b/c\0/a/b\0/a\0d/e/f\0d/e\0d\0")
echo -ne "a/b/c\0/d/e/f\0" | list-files-and-dirs | test_output "Test 8" <(echo -ne "a/b/c\0a/b\0a\0/d/e/f\0/d/e\0/d\0")
echo -ne "a/b\nc/d\0" | list-files-and-dirs | test_output "Test 9" <(echo -ne "a/b\nc/d\0a/b\nc\0a\0")
