FROM alpine:3.20.3

RUN apk add --update --upgrade --no-cache \
  rsyslog \
  rsyslog-mmutf8fix \
  rsyslog-mmjsonparse \
  libcap && \
  setcap 'cap_net_bind_service=+ep' /usr/sbin/rsyslogd && \
  rm -rf /var/cache/apk/*

USER 65534:65534
# Kubernetes pod will require the following capabilities in it's security policy to run:
# - NET_BIND_SERVICE

ENTRYPOINT ["/usr/sbin/rsyslogd", "-i", "NONE", "-n"]
