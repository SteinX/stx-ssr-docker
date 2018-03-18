FROM alpine:3.6

ENV SERVER_PORT		1080
ENV CONF_PATH		/etc/ssr

ARG BRANCH=3.1.2
ARG WORK=~

RUN apk --no-cache add python \
    libsodium \
    wget


RUN mkdir -p $WORK && \
    wget -qO- --no-check-certificate https://github.com/ssrbackup/shadowsocksr/archive/$BRANCH.tar.gz | tar -xzf - -C $WORK

WORKDIR $WORK/shadowsocksr-$BRANCH/shadowsocks

EXPOSE $SERVER_PORT
COPY dns.conf .
CMD python local.py -c $CONF_PATH/conf.json