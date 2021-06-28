FROM ubuntu:20.04

WORKDIR /app
COPY . .
RUN script/setup

ENTRYPOINT ["/bin/bash"]
