FROM alpine:3.2

ENV ETCD_VERSION v3.1.4

ENV ETCD_NAME default
ENV ETCD_LISTEN_PEER_URLS http://0.0.0.0:2380
ENV ETCD_LISTEN_CLIENT_URLS http://0.0.0.0:2379
ENV ETCD_DISCOVERY "" 

RUN apk add --update ca-certificates openssl tar && \
    wget https://github.com/coreos/etcd/releases/download/${ETCD_VERSION}/etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    tar xzvf etcd-${ETCD_VERSION}-linux-amd64.tar.gz && \
    mv etcd-${ETCD_VERSION}-linux-amd64/etcd* /bin/ && \
    apk del --purge tar openssl && \
    rm -Rf etcd-${ETCD_VERSION}-linux-amd64* /var/cache/apk/*

VOLUME /data

EXPOSE 2379 2380 4001 7001

ENTRYPOINT /bin/etcd -data-dir=/data
