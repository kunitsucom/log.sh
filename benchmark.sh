#!/usr/bin/env bash
set -E -e -o pipefail -u

# shellcheck disable=SC1091
. index.html

export TZ=UTC REC_SEVERITY=0 REC_TIMESTAMP_KEY=timestamp REC_SEVERITY_KEY=severity REC_CALLER_KEY=caller REC_MESSAGE_KEY=message

DisplayRuntimeInfo() {
  cmd="uname -s -v -m"
  if [ "$(uname -s)" = Linux ]; then
    cmd="${cmd:?}; grep model.name /proc/cpuinfo | sort -u"
  elif [ "$(uname -s)" = Darwin ]; then
    cmd="${cmd:?}; sysctl -a machdep.cpu.brand_string"
  fi
  RecExec sh -c "${cmd:?}"
  echo
} && DisplayRuntimeInfo

BenchmarkRecDebug_001() {
  echo "BenchmarkRecDebug_001"
  printf %s 'RecDebug(message only) * 100'
  time : "$(for _ in $(seq 1 100); do RecDebug "$(printf "\t\nA\t\nB\t\nC\t\n")"; done >/tmp/rec.sh_BenchmarkRecDebug_001.log 2>&1)"
  echo
} && BenchmarkRecDebug_001

BenchmarkRecDebug_002() {
  echo "BenchmarkRecDebug_002"
  printf %s 'RecDebug(with 1 field) * 100'
  time : "$(for _ in $(seq 1 100); do RecDebug "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")"; done >/tmp/rec.sh_BenchmarkRecDebug_002.log 2>&1)"
  echo
} && BenchmarkRecDebug_002

# benchmark sample on commit 'init'
# -------------------------------------------------------------------------------------------------
# $ docker run -it --rm -v "$(pwd -P)":"$(pwd -P)" -w "$(pwd -P)" --env-file <(env) ubuntu:20.04 ./benchmark.sh
# {"timestamp":"2021-11-28T02:40:48+00:00","severity":"INFO","caller":"./benchmark.sh","message":"$ sh -c 'uname -s -v -m; grep model.name /proc/cpuinfo | sort -u'"}
# Linux #1 SMP Sat Jul 3 21:51:47 UTC 2021 x86_64
# model name      : Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
#
# BenchmarkRecDebug_001
# RecDebug(message only) * 100
# real    0m0.596s
# user    0m0.397s
# sys     0m0.556s
#
# BenchmarkRecDebug_002
# RecDebug(with 1 field) * 100
# real    0m0.878s
# user    0m0.608s
# sys     0m0.876s
# -------------------------------------------------------------------------------------------------
# $ ./benchmark.sh
# {"timestamp":"2021-11-28T02:39:38+00:00","severity":"INFO","caller":"./benchmark.sh","message":"$ sh -c 'uname -s -v -m; sysctl -a machdep.cpu.brand_string'"}
# Darwin Darwin Kernel Version 20.6.0: Mon Aug 30 06:12:21 PDT 2021; root:xnu-7195.141.6~3/RELEASE_X86_64 x86_64
# machdep.cpu.brand_string: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
#
# BenchmarkRecDebug_001
# RecDebug(message only) * 100
# real    0m3.694s
# user    0m0.702s
# sys     0m2.035s
#
# BenchmarkRecDebug_002
# RecDebug(with 1 field) * 100
# real    0m5.973s
# user    0m1.154s
# sys     0m3.422s
# -------------------------------------------------------------------------------------------------
