# rec.sh

rec.sh is a JSON logger for POSIX Shell.  

This logger has been minimized as much as possible for copy-and-paste portability, at the expense of readability.  

**NOTE:** rec.sh only supports JSON with string values. JSON such as `{"number":123}` cannot be output. In the case of rec.sh, it will be `{"number": "123"}`.  

## HOW TO USE

Copy the functions in `index.html` and use them as you like.  

## USE via HTTPS

If you prefer POSIX Shell:  

```console
$ eval "$(curl -fLSs https://newtstat.github.io/rec.sh/)"

$ RecINFO hello foo bar HOSTNAME ${HOSTNAME}
{"timestamp":"2021-11-26T08:02:08+09:00","severity":"INFO","caller":"/usr/local/bin/bash","message":"hello","foo":"bar","HOSTNAME":"localhost"}  # <- stderr

$ TZ=UTC RecExec date +%F
{"timestamp":"2021-11-25T23:02:57+00:00","severity":"DEBUG","caller":"/usr/local/bin/bash","message":"$ date +%F"}  # <- stderr
2021-11-25  # <- stdout

$ And so on...
```

If you prefer Bash:  

```console
$ source <(curl -fLSs https://newtstat.github.io/rec.sh/)

$ RecINFO hello foo bar HOSTNAME ${HOSTNAME}
{"timestamp":"2021-11-26T08:02:08+09:00","severity":"INFO","caller":"/usr/local/bin/bash","message":"hello","foo":"bar","HOSTNAME":"localhost"}  # <- stderr

$ TZ=UTC RecExec date +%F
{"timestamp":"2021-11-25T23:02:57+00:00","severity":"DEBUG","caller":"/usr/local/bin/bash","message":"$ date +%F"}  # <- stderr
2021-11-25  # <- stdout

$ And so on...
```

## Thanks

The following tools are used for development.  

- formatter ... https://github.com/mvdan/sh
- linter    ... https://github.com/koalaman/shellcheck
