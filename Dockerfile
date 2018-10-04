FROM alpine
USER root
RUN apk add --no-cache redis
WORKDIR /srv
ADD *.txt test.sh /srv/
