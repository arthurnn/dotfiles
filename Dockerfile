FROM ubuntu:20.04

WORKDIR /app
COPY . .
RUN script/setup

CMD "/bin/bash"
