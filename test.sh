#!/bin/sh
set -e -u

# shellcheck disable=SC1091
. index.html

export TZ=UTC REC_SEVERITY=0 REC_TIMESTAMP_KEY=timestamp REC_SEVERITY_KEY=severity REC_CALLER_KEY=caller REC_MESSAGE_KEY=message

#
# RecDefaultJSON
#

TestRecDefaultJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=0
  if ! RecDefaultJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEFAULT","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecDefaultJSON_001"
    return 1
  fi
  echo "PASS: TestRecDefaultJSON_001"
} && TestRecDefaultJSON_001

TestRecDefaultJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=1
  if [ "$(RecDefaultJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecDefaultJSON_002"
    return 1
  fi
  echo "PASS: TestRecDefaultJSON_002"
} && TestRecDefaultJSON_002

#
# RecDebugJSON
#

TestRecDebugJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=100
  if ! RecDebugJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEBUG","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecDebugJSON_001"
    return 1
  fi
  echo "PASS: TestRecDebugJSON_001"
} && TestRecDebugJSON_001

TestRecDebugJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=101
  if [ "$(RecDebugJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecDebugJSON_002"
    return 1
  fi
  echo "PASS: TestRecDebugJSON_002"
} && TestRecDebugJSON_002

#
# RecInfoJSON
#

TestRecInfoJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=200
  if ! RecInfoJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"INFO","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecInfoJSON_001"
    return 1
  fi
  echo "PASS: TestRecInfoJSON_001"
} && TestRecInfoJSON_001

TestRecInfoJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=201
  if [ "$(RecInfoJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecInfoJSON_002"
    return 1
  fi
  echo "PASS: TestRecInfoJSON_002"
} && TestRecInfoJSON_002

#
# RecNoticeJSON
#

TestRecNoticeJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=300
  if ! RecNoticeJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"NOTICE","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecNoticeJSON_001"
    return 1
  fi
  echo "PASS: TestRecNoticeJSON_001"
} && TestRecNoticeJSON_001

TestRecNoticeJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=301
  if [ "$(RecNoticeJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecNoticeJSON_002"
    return 1
  fi
  echo "PASS: TestRecNoticeJSON_002"
} && TestRecNoticeJSON_002

#
# RecWarningJSON
#

TestRecWarningJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=400
  if ! RecWarningJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"WARNING","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecWarningJSON_001"
    return 1
  fi
  echo "PASS: TestRecWarningJSON_001"
} && TestRecWarningJSON_001

TestRecWarningJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=401
  if [ "$(RecWarningJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecWarningJSON_002"
    return 1
  fi
  echo "PASS: TestRecWarningJSON_002"
} && TestRecWarningJSON_002

#
# RecErrorJSON
#

TestRecErrorJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=500
  if ! RecErrorJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"ERROR","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecErrorJSON_001"
    return 1
  fi
  echo "PASS: TestRecErrorJSON_001"
} && TestRecErrorJSON_001

TestRecErrorJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=501
  if [ "$(RecErrorJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecErrorJSON_002"
    return 1
  fi
  echo "PASS: TestRecErrorJSON_002"
} && TestRecErrorJSON_002

#
# RecCriticalJSON
#

TestRecCriticalJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=600
  if ! RecCriticalJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"CRITICAL","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecCriticalJSON_001"
    return 1
  fi
  echo "PASS: TestRecCriticalJSON_001"
} && TestRecCriticalJSON_001

TestRecCriticalJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=601
  if [ "$(RecCriticalJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecCriticalJSON_002"
    return 1
  fi
  echo "PASS: TestRecCriticalJSON_002"
} && TestRecCriticalJSON_002

#
# RecAlertJSON
#

TestRecAlertJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=700
  if ! RecAlertJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"ALERT","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecAlertJSON_001"
    return 1
  fi
  echo "PASS: TestRecAlertJSON_001"
} && TestRecAlertJSON_001

TestRecAlertJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=701
  if [ "$(RecAlertJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecAlertJSON_002"
    return 1
  fi
  echo "PASS: TestRecAlertJSON_002"
} && TestRecAlertJSON_002

#
# RecEmergencyJSON
#

TestRecEmergencyJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=800
  if ! RecEmergencyJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"EMERGENCY","caller":"./test.sh","message":"\\t\\nA\\t\\nB\\t\\nC\\t","test":"\\t\\nA\\t\\nB\\t\\nC\\t"}$'; then
    echo "FAIL: TestRecEmergencyJSON_001"
    return 1
  fi
  echo "PASS: TestRecEmergencyJSON_001"
} && TestRecEmergencyJSON_001

TestRecEmergencyJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=801
  if [ "$(RecEmergencyJSON "$(printf "\t\nA\t\nB\t\nC\t\n")" "test" "$(printf "\t\nA\t\nB\t\nC\t\n")" 2>&1)" ]; then
    echo "FAIL: TestRecEmergencyJSON_002"
    return 1
  fi
  echo "PASS: TestRecEmergencyJSON_002"
} && TestRecEmergencyJSON_002

#
# RecExecJSON
#

TestRecExecJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=100
  if ! RecExecJSON true 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"INFO","caller":"./test.sh","message":". true"}$'; then
    echo "FAIL: TestRecExecJSON_001"
    return 1
  fi
  echo "PASS: TestRecExecJSON_001"
} && TestRecExecJSON_001

TestRecExecJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=201
  if [ "$(RecExecJSON true 2>&1)" ]; then
    echo "FAIL: TestRecExecJSON_002"
    return 1
  fi
  echo "PASS: TestRecExecJSON_002"
} && TestRecExecJSON_002

#
# RecRunJSON
#

TestRecRunJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=100
  if ! RecRunJSON date +%Y-%m-%d 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"INFO","caller":"./test.sh","message":". date .%Y-%m-%d","command":"date .%Y-%m-%d","stdout":"[0-9]+-[0-9]+-[0-9]+","stderr":"","return":"0"}$'; then
    echo "FAIL: TestRecRunJSON_001"
    return 1
  fi
  echo "PASS: TestRecRunJSON_001"
} && TestRecRunJSON_001

TestRecRunJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=201
  if [ "$(RecRunJSON date +%Y-%m-%d 2>&1)" ]; then
    echo "FAIL: TestRecRunJSON_002"
    return 1
  fi
  echo "PASS: TestRecRunJSON_002"
} && TestRecRunJSON_002

#
# common
#

TestCommonRecJSON_001() {
  unset REC_SEVERITY
  export REC_SEVERITY=0
  if ! RecDefaultJSON 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEFAULT","caller":"./test.sh","message":""}$'; then
    echo "FAIL: TestCommonRecJSON_001"
    return 1
  fi
  echo "PASS: TestCommonRecJSON_001"
} && TestCommonRecJSON_001

TestCommonRecJSON_002() {
  unset REC_SEVERITY
  export REC_SEVERITY=0
  if ! RecDefaultJSON "" testKey 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEFAULT","caller":"./test.sh","message":"","testKey":""}$'; then
    echo "FAIL: TestCommonRecJSON_002"
    return 1
  fi
  echo "PASS: TestCommonRecJSON_002"
} && TestCommonRecJSON_002

TestCommonRecJSON_003() {
  unset REC_SEVERITY
  export REC_SEVERITY=0
  if ! RecDefaultJSON "" testKey testValue 2>&1 | grep -Eq '^{"timestamp":"[0-9]+-[0-9]+-[0-9]+T[0-9]+:[0-9]+:[0-9]+.00:00","severity":"DEFAULT","caller":"./test.sh","message":"","testKey":"testValue"}$'; then
    echo "FAIL: TestCommonRecJSON_003"
    return 1
  fi
  echo "PASS: TestCommonRecJSON_003"
} && TestCommonRecJSON_003
