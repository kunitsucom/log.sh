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

BenchmarkRecDebugJSON_001() {
  echo "BenchmarkRecDebugJSON_001"
  printf %s 'RecDebugJSON(message only) * 100'
  time : "$(for _ in $(seq 1 100); do RecDebugJSON "$(printf "\t\nA\t\nB\t\nC\t\n")"; done >/tmp/rec.sh_BenchmarkRecDebugJSON_001.log 2>&1)"
  echo
} && BenchmarkRecDebugJSON_001

BenchmarkRecDebugJSON_002() {
  echo "BenchmarkRecDebugJSON_002"
  printf %s 'RecDebugJSON(with 1 field) * 100'
  time : "$(for _ in $(seq 1 100); do RecDebugJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")"; done >/tmp/rec.sh_BenchmarkRecDebugJSON_002.log 2>&1)"
  echo
} && BenchmarkRecDebugJSON_002

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
# 2022-04-09T07:30:54+00:00 [     INFO] $ sh -c 'uname -s -v -m; sysctl -a machdep.cpu.brand_string'
# Darwin Darwin Kernel Version 21.4.0: Fri Mar 18 00:45:05 PDT 2022; root:xnu-8020.101.4~15/RELEASE_X86_64 x86_64
# machdep.cpu.brand_string: Intel(R) Core(TM) i7-9750H CPU @ 2.60GHz
#
# BenchmarkRecDebugJSON_001
# RecDebugJSON(message only) * 100
# real	0m1.890s
# user	0m0.730s
# sys	0m1.639s
#
# BenchmarkRecDebugJSON_002
# RecDebugJSON(with 1 field) * 100
# real	0m3.108s
# user	0m1.219s
# sys	0m2.855s
# -------------------------------------------------------------------------------------------------
