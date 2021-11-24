#!/bin/sh
set -e -u

# shellcheck disable=SC1091
. index.html

export TZ=UTC REC_TIMESTAMP_KEY=timestamp REC_SEVERITY_KEY=severity REC_CALLER_KEY=caller REC_MESSAGE_KEY=message

#
# RecDEFAULT
#

TestRecDEFAULT_001() {
  export REC_SEVERITY=0
  if ! RecDEFAULT "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEFAULT","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecDEFAULT_001"
    return 1
  fi
  echo "PASS: TestRecDEFAULT_001"
} && TestRecDEFAULT_001
unset REC_SEVERITY

TestRecDEFAULT_002() {
  export REC_SEVERITY=1
  if [ "$(RecDEFAULT "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecDEFAULT_002"
    return 1
  fi
  echo "PASS: TestRecDEFAULT_002"
} && TestRecDEFAULT_002
unset REC_SEVERITY

#
# RecDEBUG
#

TestRecDEBUG_001() {
  export REC_SEVERITY=100
  if ! RecDEBUG "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEBUG","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecDEBUG_001"
    return 1
  fi
  echo "PASS: TestRecDEBUG_001"
} && TestRecDEBUG_001
unset REC_SEVERITY

TestRecDEBUG_002() {
  export REC_SEVERITY=101
  if [ "$(RecDEBUG "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecDEBUG_002"
    return 1
  fi
  echo "PASS: TestRecDEBUG_002"
} && TestRecDEBUG_002
unset REC_SEVERITY

#
# RecINFO
#

TestRecINFO_001() {
  export REC_SEVERITY=200
  if ! RecINFO "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"INFO","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecINFO_001"
    return 1
  fi
  echo "PASS: TestRecINFO_001"
} && TestRecINFO_001
unset REC_SEVERITY

TestRecINFO_002() {
  export REC_SEVERITY=201
  if [ "$(RecINFO "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecINFO_002"
    return 1
  fi
  echo "PASS: TestRecINFO_002"
} && TestRecINFO_002
unset REC_SEVERITY

#
# RecNOTICE
#

TestRecNOTICE_001() {
  export REC_SEVERITY=300
  if ! RecNOTICE "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"NOTICE","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecNOTICE_001"
    return 1
  fi
  echo "PASS: TestRecNOTICE_001"
} && TestRecNOTICE_001
unset REC_SEVERITY

TestRecNOTICE_002() {
  export REC_SEVERITY=301
  if [ "$(RecNOTICE "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecNOTICE_002"
    return 1
  fi
  echo "PASS: TestRecNOTICE_002"
} && TestRecNOTICE_002
unset REC_SEVERITY

#
# RecWARNING
#

TestRecWARNING_001() {
  export REC_SEVERITY=400
  if ! RecWARNING "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"WARNING","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecWARNING_001"
    return 1
  fi
  echo "PASS: TestRecWARNING_001"
} && TestRecWARNING_001
unset REC_SEVERITY

TestRecWARNING_002() {
  export REC_SEVERITY=401
  if [ "$(RecWARNING "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecWARNING_002"
    return 1
  fi
  echo "PASS: TestRecWARNING_002"
} && TestRecWARNING_002
unset REC_SEVERITY

#
# RecERROR
#

TestRecERROR_001() {
  export REC_SEVERITY=500
  if ! RecERROR "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"ERROR","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecERROR_001"
    return 1
  fi
  echo "PASS: TestRecERROR_001"
} && TestRecERROR_001
unset REC_SEVERITY

TestRecERROR_002() {
  export REC_SEVERITY=501
  if [ "$(RecERROR "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecERROR_002"
    return 1
  fi
  echo "PASS: TestRecERROR_002"
} && TestRecERROR_002
unset REC_SEVERITY

#
# RecCRITICAL
#

TestRecCRITICAL_001() {
  export REC_SEVERITY=600
  if ! RecCRITICAL "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"CRITICAL","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecCRITICAL_001"
    return 1
  fi
  echo "PASS: TestRecCRITICAL_001"
} && TestRecCRITICAL_001
unset REC_SEVERITY

TestRecCRITICAL_002() {
  export REC_SEVERITY=601
  if [ "$(RecCRITICAL "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecCRITICAL_002"
    return 1
  fi
  echo "PASS: TestRecCRITICAL_002"
} && TestRecCRITICAL_002
unset REC_SEVERITY

#
# RecALERT
#

TestRecALERT_001() {
  export REC_SEVERITY=700
  if ! RecALERT "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"ALERT","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecALERT_001"
    return 1
  fi
  echo "PASS: TestRecALERT_001"
} && TestRecALERT_001
unset REC_SEVERITY

TestRecALERT_002() {
  export REC_SEVERITY=701
  if [ "$(RecALERT "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecALERT_002"
    return 1
  fi
  echo "PASS: TestRecALERT_002"
} && TestRecALERT_002
unset REC_SEVERITY

#
# RecEMERGENCY
#

TestRecEMERGENCY_001() {
  export REC_SEVERITY=800
  if ! RecEMERGENCY "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"EMERGENCY","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecEMERGENCY_001"
    return 1
  fi
  echo "PASS: TestRecEMERGENCY_001"
} && TestRecEMERGENCY_001
unset REC_SEVERITY

TestRecEMERGENCY_002() {
  export REC_SEVERITY=801
  if [ "$(RecEMERGENCY "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecEMERGENCY_002"
    return 1
  fi
  echo "PASS: TestRecEMERGENCY_002"
} && TestRecEMERGENCY_002
unset REC_SEVERITY

#
# RecExec
#

TestRecExec_001() {
  export REC_SEVERITY=100
  if ! RecExec true 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEBUG","caller":"./test.sh","message":". true"}$'; then
    echo "FAIL: TestRecExec_001"
    return 1
  fi
  echo "PASS: TestRecExec_001"
} && TestRecExec_001
unset REC_SEVERITY

TestRecExec_002() {
  export REC_SEVERITY=101
  if [ "$(RecExec true 2>&1)" ]; then
    echo "FAIL: TestRecExec_002"
    return 1
  fi
  echo "PASS: TestRecExec_002"
} && TestRecExec_002
unset REC_SEVERITY

#
# RecRun
#

TestRecRun_001() {
  export REC_SEVERITY=100
  if ! RecRun date +%Y-%m-%d 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEBUG","caller":"./test.sh","message":". date .%Y-%m-%d","command":"date .%Y-%m-%d","stdout":"[0-9]+-[0-9]+-[0-9]+","stderr":"","return":"0"}$'; then
    echo "FAIL: TestRecRun_001"
    return 1
  fi
  echo "PASS: TestRecRun_001"
} && TestRecRun_001
unset REC_SEVERITY

TestRecRun_002() {
  export REC_SEVERITY=101
  if [ "$(RecRun date +%Y-%m-%d 2>&1)" ]; then
    echo "FAIL: TestRecRun_002"
    return 1
  fi
  echo "PASS: TestRecRun_002"
} && TestRecRun_002
unset REC_SEVERITY
