# Copyright The OpenTelemetry Authors
# SPDX-License-Identifier: Apache-2.0



FROM quay.io/splunko11ytest/network-explorer-debug/rhcos:latest AS copier
FROM bitnami/minideb:bullseye


LABEL org.label-schema.name="opentelemetry-ebpf-kernel-collector"
LABEL org.label-schema.description="OpenTelemetry eBPF kernel information collector"
LABEL org.label-schema.vcs-url="https://github.com/open-telemetry/opentelemetry-ebpf"
LABEL org.label-schema.schema-version="1.0"

# ca-certificates are required by libcurl
RUN install_packages ca-certificates
ENV SSL_CERT_DIR=/etc/ssl/certs

ENV EBPF_NET_INSTALL_DIR=/srv
ENV EBPF_NET_HOST_DIR=/hostfs
ENV EBPF_NET_DATA_DIR=/var/run/ebpf_net

ENTRYPOINT [ "/srv/entrypoint.sh" ]

# required by kernel_headers.sh script
RUN install_packages coreutils curl sed tar dnf rpm

ARG BUILD_TYPE
RUN if [ "$BUILD_TYPE" = "Debug" ]; then \
      install_packages bc cgdb gawk gdb gzip iputils-ping jq netcat-openbsd procps ripgrep vim valgrind; \
    fi

COPY --from=copier /usr/src/kernels/4.18.0-372.49.1.el8_6.x86_64/ /usr/src/4.18.0-372.49.1.el8_6.x86_64
COPY --from=copier /lib/modules/4.18.0-372.49.1.el8_6.x86_64/ /lib/modules/4.18.0-372.49.1.el8_6.x86_64


COPY srv /srv
WORKDIR /srv


RUN if [ ! -e /srv/kernel-collector ]; then \
      ln /srv/kernel-collector-stripped /srv/kernel-collector; \
    fi
