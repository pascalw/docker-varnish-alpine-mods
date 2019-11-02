FROM alpine:3.10 as modules

ARG BUILD_TOOLS=" \
    varnish-dev \
    automake \
    autoconf \
    libtool \
    python3 \
    py-docutils \
    make \
    git \
  "

RUN apk --update --no-cache add \
  varnish \
  $BUILD_TOOLS

RUN cd /tmp \
  && git clone --depth=1 https://github.com/varnish/varnish-modules.git \
  && cd varnish-modules \
  && ./bootstrap \
  && ./configure \
  && make -j $(nproc) \
  && make install

FROM alpine:3.10

RUN apk --no-cache add varnish

COPY --from=modules /usr/lib/varnish/vmods/* /usr/lib/varnish/vmods/

COPY docker-varnish-entrypoint /usr/bin/
ENTRYPOINT ["docker-varnish-entrypoint"]

WORKDIR /etc/varnish
EXPOSE 80
CMD ["varnishd", "-F", "-f", "/etc/varnish/default.vcl"]
