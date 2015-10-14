FROM marclop/alpine-python:3.4

RUN mkdir /prometeus

COPY run.sh /run.sh

VOLUME ["/prometeus"]

ENTRYPOINT exec /run.sh
