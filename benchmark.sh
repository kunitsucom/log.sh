#!/bin/sh
set -e -u

# shellcheck disable=SC1091
. index.html

BenchmarkRecDEBUG_001() {
  echo "BenchmarkRecDEBUG_001"
  printf %s 'RecDEBUG(message only) * 100'
  time : "$(for _ in $(seq 1 100); do RecDEBUG "$(printf "\t\nA\t\nB\t\nC\t\n")" >/dev/null 2>&1; done)"
  echo
} && BenchmarkRecDEBUG_001

BenchmarkRecDEBUG_002() {
  echo "BenchmarkRecDEBUG_002"
  printf %s 'RecDEBUG(with 1 field) * 100'
  time : "$(for _ in $(seq 1 100); do RecDEBUG "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" >/dev/null 2>&1; done)"
  echo
} && BenchmarkRecDEBUG_002

#
# benchmark sample on commit 'init'
#
# BenchmarkRecDEBUG_001
# RecDEBUG(message only) * 100
# real    0m3.266s
# user    0m0.580s
# sys     0m1.613s
#
# BenchmarkRecDEBUG_002
# RecDEBUG(with 1 field) * 100
# real    0m5.053s
# user    0m0.945s
# sys     0m2.593s
#
