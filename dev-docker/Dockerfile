FROM parrotrueper/arm32_fw_tchain:1.0.0 AS base
USER root

# ARM toolchain dependencies for debugging
COPY libncurses5_6.4-4_amd64.deb /
COPY libtinfo5_6.4-4_amd64.deb /
COPY new-bashrc /etc/bash.bashrc
# Uncomment to add in PC-Lint license file
#COPY pclp-subscription.lic /opt/pclp/

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    locales \
    locales-all \
    openssh-client \
    tzdata  \
    # install debug dependencies for ARM toolchain
    && dpkg -i /libtinfo5_6.4-4_amd64.deb \
    && dpkg -i /libncurses5_6.4-4_amd64.deb \
    && /usr/sbin/locale-gen en_GB.UTF-8 \
    # clear out the cache
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/* /libtinfo5_6.4-4_amd64.deb \
    /libncurses5_6.4-4_amd64.deb \
    && DEBIAN_FRONTEND=noninteractive \
    PIP_BREAK_SYSTEM_PACKAGES=1 pip install --no-cache-dir --no-input pyocd


USER rabbit
WORKDIR /workspace
ENV NO_AT_BRIDGE=1
ENV GDK_DPI_SCALE=1.5
ENV CLICOLOR=1
ENV CLICOLOR_FORCE=1
ENV LANG=en_GB.UTF-8
ENV LANGUAGE=en_GB.UTF-8
ENV LC_ALL=en_GB.UTF-8
SHELL ["/usr/bin/bash", "-c"]
RUN source /etc/bash.bashrc
ENV PATH="$PATH"



