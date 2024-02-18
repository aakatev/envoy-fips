ARG BUILDER_IMAGE_NAME=envoyproxy/envoy-build-ubuntu:105fdc54acc55ff0ff0c5b784d8cfe8dc225aad4

FROM ${BUILDER_IMAGE_NAME} AS builder

ARG ENVOY_BRANCH=v1.27-fips
ARG ENVOY_REPO=https://github.com/ctera/envoy.git

RUN /usr/bin/git clone --depth 1 --branch ${ENVOY_BRANCH} ${ENVOY_REPO} /source
WORKDIR /source

RUN git pull

RUN mkdir /build

ENV BAZEL_BUILD_OPTIONS='--define boringssl=fips'
RUN ./ci/do_ci.sh bazel.release.contrib.server_only

FROM envoyproxy/envoy-alpine:v1.21-latest
WORKDIR /usr/local/bin

COPY --from=builder /source/linux/amd64/build_envoy-contrib_release_stripped/envoy /usr/local/bin/envoy
COPY --from=builder /source/linux/amd64/build_envoy-contrib_release/su-exec /usr/local/bin/su-exec
COPY docker-entrypoint.sh /

RUN mkdir -p /etc/envoy && \
  chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
