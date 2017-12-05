# wppier\confd

see [https://github.com/kelseyhightower/confd](https://github.com/kelseyhightower/confd)

Don't use this image directly. Copy `/usr/local/bin/confd` to your own base image.

Example:
```
From wppier\confd as confd
FROM alpine:latest
COPY --from=confd /usr/local/bin/confd /usr/local/bin/confd
```
