FROM alpine

# enable test repo
RUN echo "@testing http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

# install package
RUN apk upgrade && \
    apk add --no-cache \
        curl \
        xz \
        bzip2 \
        gnupg1 \
        debian-archive-keyring \
        libc6-compat \
        createrepo_c@testing && \
    rm -rf /var/cache/apk/*

# install aptly
ARG APTLY_VERSION=1.4.0
ARG APTLT_URL=https://github.com/aptly-dev/aptly/releases/download/v${APTLY_VERSION}/aptly_${APTLY_VERSION}_linux_amd64.tar.gz
RUN curl -L $APTLT_URL | tar -zx -C /usr/bin --strip-components=1 aptly_${APTLY_VERSION}_linux_amd64/aptly
