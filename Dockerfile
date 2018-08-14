FROM python:3.6-slim
#FROM ethereum/vyper

# Specify label-schema specific arguments and labels.
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.name="Vyper" \
    org.label-schema.description="Vyper is an experimental programming language" \
    org.label-schema.url="https://vyper.readthedocs.io/en/latest/" \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.vcs-url="https://github.com/ethereum/vyper" \
    org.label-schema.vendor="Ethereum" \
    org.label-schema.schema-version="1.0"

# coincurve requires libgmp
RUN apt-get update && \
    apt-get install -y --no-install-recommends apt-utils gcc libc6-dev libc-dev libssl-dev libgmp-dev pkg-config autoconf automake apt-utils libtool-bin libsecp256k1-dev git  && \
    rm -rf /var/lib/apt/lists/*
RUN pip install populus
RUN pip install git+git://github.com/ethereum/vyper.git
#RUN  apt-get purge -y --auto-remove apt-utils gcc libc6-dev libc-dev libssl-dev pkg-config autoconf automake apt-utils libtool-bin libsecp256k1-dev

ADD . /code

WORKDIR /code


ENTRYPOINT ["/bin/bash"]
