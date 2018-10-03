FROM alpine
USER root
WORKDIR /srv
ADD *.txt test.sh /srv/
