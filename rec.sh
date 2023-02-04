#!/bin/sh
cat >/dev/null <<'#https://kunitsuinc.github.io/rec.sh/'
<style>body{font-size:0;margin:0}code,pre{font-size:1rem;font-family:'Ricty Diminished',Osaka-Mono,Menlo,Monaco,Consolas,'Courier New','Andale Mono','Ubuntu Mono',monospace}</style><pre><code>
#https://kunitsuinc.github.io/rec.sh/

# LISENCE: https://github.com/kunitsuinc/rec.sh/blob/HEAD/LICENSE
# Common
if [ -t 2 ]; then REC_COLOR=true; else REC_COLOR=''; fi
_recRFC3339() { date "+%Y-%m-%dT%H:%M:%S%z" | sed "s/\(..\)$/:\1/"; }
_recCmd() { for a in "$@"; do if echo "${a:-}" | grep -Eq "[[:blank:]]"; then printf "'%s' " "${a:-}"; else printf "%s " "${a:-}"; fi; done | sed "s/ $//"; }
# Color
RecDefault() { test "  ${REC_SEVERITY:-0}" -gt 000 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;35m}  DEFAULT${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecDebug() { test "    ${REC_SEVERITY:-0}" -gt 100 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;34m}    DEBUG${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecInfo() { test "     ${REC_SEVERITY:-0}" -gt 200 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;32m}     INFO${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecNotice() { test "   ${REC_SEVERITY:-0}" -gt 300 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;36m}   NOTICE${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecWarning() { test "  ${REC_SEVERITY:-0}" -gt 400 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;33m}  WARNING${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecError() { test "    ${REC_SEVERITY:-0}" -gt 500 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;31m}    ERROR${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecCritical() { test " ${REC_SEVERITY:-0}" -gt 600 2>/dev/null || echo "$*" | awk "{print \"$(_recRFC3339) [${REC_COLOR:+\\033[0;1;31m} CRITICAL${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecAlert() { test "    ${REC_SEVERITY:-0}" -gt 700 2>/dev/null || echo "$*" | awk "{print   \"$(_recRFC3339) [${REC_COLOR:+\\033[0;41m}    ALERT${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecEmergency() { test "${REC_SEVERITY:-0}" -gt 800 2>/dev/null || echo "$*" | awk "{print \"$(_recRFC3339) [${REC_COLOR:+\\033[0;1;41m}EMERGENCY${REC_COLOR:+\\033[0m}] \"\$0\"\"}" 1>&2; }
RecExec() { RecInfo "$ $(_recCmd "$@")" && "$@"; }
RecRun() { _dlm="####R#E#C#D#E#L#I#M#I#T#E#R####" _all=$({ _out=$("$@") && _rtn=$? || _rtn=$? && printf "\n%s" "${_dlm:?}${_out:-}" && return ${_rtn:-0}; } 2>&1) && _rtn=$? || _rtn=$? && _dlmno=$(echo "${_all:-}" | sed -n "/${_dlm:?}/=") && _cmd=$(_recCmd "$@") && _stdout=$(echo "${_all:-}" | tail -n +"${_dlmno:-1}" | sed "s/^${_dlm:?}//") && _stderr=$(echo "${_all:-}" | head -n "${_dlmno:-1}" | grep -v "^${_dlm:?}") && RecInfo "$ ${_cmd:-}" && { [ -z "${_stdout:-}" ] || RecInfo "${_stdout:?}"; } && { [ -z "${_stderr:-}" ] || RecWarning "${_stderr:?}"; } && return ${_rtn:-0}; }
# export functions for bash
# shellcheck disable=SC3045
echo "${SHELL-}" | grep -q bash$ && export -f _recRFC3339 _recCmd RecDefault RecDebug RecInfo RecWarning RecError RecCritical RecAlert RecEmergency RecExec RecRun

# LISENCE: https://github.com/kunitsuinc/rec.sh/blob/HEAD/LICENSE
# Common
_recRFC3339() { date "+%Y-%m-%dT%H:%M:%S%z" | sed "s/\(..\)$/:\1/"; }
_recCmd() { for a in "$@"; do if echo "${a:-}" | grep -Eq "[[:blank:]]"; then printf "'%s' " "${a:-}"; else printf "%s " "${a:-}"; fi; done | sed "s/ $//"; }
# JSON
_recEscape() { printf %s "${1:-}" | sed "s/\"/\\\"/g; s/\r/\\\r/g; s/\t/\\\t/g; s/$/\\\n/g" | tr -d "[:cntrl:]" | sed "s/\\\n$/\n/"; }
_recJSON() { _svr="${1:?}" _msg="$(_recEscape "${2:-}")" && unset _fld _val && shift 2 && for a in "$@"; do if [ "${_val:-}" ]; then _fld="${_fld:?}:\"$(_recEscape "${a:-}")\"" && unset _val && continue; fi && _fld="${_fld:-}${_fld:+,}\"${a:?"json key is not set"}\"" _val=1; done && test $(($# % 2)) = 1 && _fld="${_fld:?}:\"\"" || true && printf "{%s}\n" "\"${REC_TIMESTAMP_KEY:-timestamp}\":\"$(_recRFC3339)\",\"${REC_SEVERITY_KEY:-severity}\":\"${_svr:?}\",\"${REC_CALLER_KEY:-caller}\":\"$0\",\"${REC_MESSAGE_KEY:-message}\":\"${_msg:-}\"${_fld:+,}${_fld:-}"; }
RecDefaultJSON() { test "  ${REC_SEVERITY:-0}" -gt 000 2>/dev/null || _recJSON DEFAULT "$@" 1>&2; }
RecDebugJSON() { test "    ${REC_SEVERITY:-0}" -gt 100 2>/dev/null || _recJSON DEBUG "$@" 1>&2; }
RecInfoJSON() { test "     ${REC_SEVERITY:-0}" -gt 200 2>/dev/null || _recJSON INFO "$@" 1>&2; }
RecNoticeJSON() { test "   ${REC_SEVERITY:-0}" -gt 300 2>/dev/null || _recJSON NOTICE "$@" 1>&2; }
RecWarningJSON() { test "  ${REC_SEVERITY:-0}" -gt 400 2>/dev/null || _recJSON WARNING "$@" 1>&2; }
RecErrorJSON() { test "    ${REC_SEVERITY:-0}" -gt 500 2>/dev/null || _recJSON ERROR "$@" 1>&2; }
RecCriticalJSON() { test " ${REC_SEVERITY:-0}" -gt 600 2>/dev/null || _recJSON CRITICAL "$@" 1>&2; }
RecAlertJSON() { test "    ${REC_SEVERITY:-0}" -gt 700 2>/dev/null || _recJSON ALERT "$@" 1>&2; }
RecEmergencyJSON() { test "${REC_SEVERITY:-0}" -gt 800 2>/dev/null || _recJSON EMERGENCY "$@" 1>&2; }
RecExecJSON() { RecInfoJSON "$ $(_recCmd "$@")" && "$@"; }
RecRunJSON() { _dlm='####R#E#C#D#E#L#I#M#I#T#E#R####' _all=$({ _out=$("$@") && _rtn=$? || _rtn=$? && printf "\n%s" "${_dlm:?}${_out:-}" && return ${_rtn:-0}; } 2>&1) && _rtn=$? || _rtn=$? && _dlmno=$(echo "${_all:-}" | sed -n "/${_dlm:?}/=") && _cmd=$(_recCmd "$@") && _stdout=$(echo "${_all:-}" | tail -n +"${_dlmno:-1}" | sed "s/^${_dlm:?}//") && _stderr=$(echo "${_all:-}" | head -n "${_dlmno:-1}" | grep -v "^${_dlm:?}") && RecInfoJSON "$ ${_cmd:-}" command "${_cmd:-}" stdout "${_stdout:-}" stderr "${_stderr:-}" return "${_rtn:-0}" && return ${_rtn:-0}; }
# export functions for bash
# shellcheck disable=SC3045
echo "${SHELL-}" | grep -q bash$ && export -f _recRFC3339 _recCmd _recEscape _recJSON RecDefaultJSON RecDebugJSON RecInfoJSON RecNoticeJSON RecWarningJSON RecErrorJSON RecCriticalJSON RecAlertJSON RecEmergencyJSON RecExecJSON RecRunJSON

# (C) 2022 kunitsuinc </code></pre>
