# rec.sh - JSON logger

rec.sh is a lightweight and no dependencies JSON logger for POSIX Shell Script.  

This logger has been minimized as much as possible for copy-and-paste portability, at the expense of readability.  

**NOTE:** rec.sh only supports JSON with string values. JSON such as `{"number":123}` cannot be output. In the case of rec.sh, it will be `{"number":"123"}`.  

**NOTE:** rec.sh cannot output any control characters other than `\n` `\r` `\t`.  

## HOW TO USE

There are two ways.  

### 1. Vendoring (Recommended)

Copy the rec.sh functions in the shell script file ([`index.html`](/index.html)) and paste them where you want to use them.  
(file name `index.html` may seem strange, but it's necessary for me to serve Shell Script file in GitHub Pages with as short URL *https://rec-logger.github.io/rec.sh/* as possible)  

### 2. Use via HTTP

You can load a shell script function via the Internet as follows:  

```console
$ eval "$(curl -fLSs --tlsv1.2 https://rec-logger.github.io/rec.sh/)"

$ RecInfoJSON hello foo bar HOSTNAME ${HOSTNAME}
{"timestamp":"2021-11-26T08:02:08+09:00","severity":"INFO","caller":"-bash","message":"hello","foo":"bar","HOSTNAME":"localhost"}  # <- NOTE: stderr

$ # And so on...
```

## Examples of usage

```console
$ # RecDefaultJSON, RecDebugJSON, RecInfoJSON, RecNoticeJSON, RecWarningJSON, RecErrorJSON, RecCriticalJSON, RecAlertJSON and RecEmergencyJSON
$ RecInfoJSON hello foo bar HOSTNAME ${HOSTNAME} ctrl "$(printf "\n\t\r")" cannot-tail-lf "$(printf "\t\r\n")" cannot-other-ctrl-chars "$(printf "\x01\x7F")"
{"timestamp":"2021-11-26T08:02:08+09:00","severity":"INFO","caller":"-bash","message":"hello","foo":"bar","HOSTNAME":"localhost","ctrl":"\n\t\r","cannot-tail-lf":"\t\r","cannot-other-ctrl-chars":""}  # <- NOTE: stderr

$ RecInfoJSON hello foo bar HOSTNAME ${HOSTNAME} ctrl "$(printf "\n\t\r")" cannot-tail-lf "$(printf "\t\r\n")" cannot-other-ctrl-chars "$(printf "\x01\x7F")" 2>&1 | jq .
{
  "timestamp": "2021-11-26T08:02:34+09:00",
  "severity": "INFO",
  "caller": "-bash",
  "message": "hello",
  "foo": "bar",
  "HOSTNAME": "localhost",
  "ctrl": "\n\t\r",
  "cannot-tail-lf": "\t\r"       # <- NOTE: rec.sh can't output field value tail '\n'
  "cannot-other-ctrl-chars": ""  # <- NOTE: rec.sh can't output other control characters
}
```

```console
$ # Severity threshold
$ export REC_SEVERITY=0; RecDefaultJSON "output"; RecDebugJSON "output"; RecInfoJSON "output"
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"DEFAULT","caller":"-bash","message":"output"}
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"DEBUG","caller":"-bash","message":"output"}
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"INFO","caller":"-bash","message":"output"}

$ export REC_SEVERITY=1; RecDefaultJSON "NO OUTPUT"; RecDebugJSON "output"; RecInfoJSON "output"
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"DEBUG","caller":"-bash","message":"output"}
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"INFO","caller":"-bash","message":"output"}

$ export REC_SEVERITY=101; RecDefaultJSON "NO OUTPUT"; RecDebugJSON "NO OUTPUT"; RecInfoJSON "output"
{"timestamp":"2021-11-28T10:28:24+09:00","severity":"INFO","caller":"-bash","message":"output"}

$ # +------------------+------------------------+
$ # | Function         | REC_SEVERITY threshold |
$ # +------------------+------------------------+
$ # | RecDefaultJSON   |                      0 |
$ # | RecDebugJSON     |                    100 |
$ # | RecInfoJSON      |                    200 |
$ # | RecNoticeJSON    |                    300 |
$ # | RecWarningJSON   |                    400 |
$ # | RecErrorJSON     |                    500 |
$ # | RecCriticalJSON  |                    600 |
$ # | RecAlertJSON     |                    700 |
$ # | RecEmergencyJSON |                    800 |
$ # +------------------+------------------------+
```

```console
$ # Change timestamp timezone
$ TZ=UTC RecInfoJSON hello foo bar 2>&1 | jq .
{
  "timestamp": "2021-11-27T11:19:15+00:00",  # <- NOTE: TZ=UTC
  "severity": "INFO",
  "caller": "-bash",
  "message": "hello",
  "foo": "bar"
}
```

```console
$ # Change field key name
$ export REC_TIMESTAMP_KEY=ts REC_SEVERITY_KEY=lv REC_CALLER_KEY=file REC_MESSAGE_KEY=msg
$ RecInfoJSON hello foo bar 2>&1 | jq .
{
  "ts": "2021-11-27T20:21:55+09:00",  # <- NOTE: REC_TIMESTAMP_KEY
  "lv": "INFO",                       # <- NOTE: REC_SEVERITY_KEY
  "file": "-bash",                    # <- NOTE: REC_CALLER_KEY
  "msg": "hello",                     # <- NOTE: REC_MESSAGE_KEY
  "foo": "bar"
}
```

```console
$ # RecExec
$ RecExec date +%F
{"timestamp":"2021-11-27T20:25:03+09:00","severity":"INFO","caller":"-bash","message":"$ date +%F"}  # <- NOTE: stderr
2021-11-25
```

```console
$ # RecRun
$ RecRun sh -c "echo out; echo err 1>&2; exit 1"
{"timestamp":"2021-11-27T20:25:27+09:00","severity":"INFO","caller":"-bash","message":"$ date +%F","command":"date +%F","stdout":"2021-11-27","stderr":"","return":"1"}  # <- NOTE: stderr

$ RecRun sh -c "echo out; echo err 1>&2; exit 1" 2>&1 | jq .
{
  "timestamp": "2021-11-27T20:26:46+09:00",
  "severity": "INFO",
  "caller": "-bash",
  "message": "$ sh -c 'echo out; echo err 1>&2'",
  "command": "sh -c 'echo out; echo err 1>&2'",
  "stdout": "out",
  "stderr": "err",
  "return": "1"
}
```

## Thanks

The following tools are used for development.  

- formatter ... https://github.com/mvdan/sh
- linter    ... https://github.com/koalaman/shellcheck
