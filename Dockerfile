FROM ubuntu:18.04

RUN apt-get update && \
    apt-get install -y socat nasm make binutils && \
    rm -rf /var/lib/apt/lists/*

COPY challenge /challenge
WORKDIR /challenge
RUN chmod 644 flag.txt && make && make wipe

COPY run.sh /
RUN chmod 500 /run.sh

EXPOSE 1337

ENTRYPOINT ["/run.sh"]
