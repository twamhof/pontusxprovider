##
## Copyright 2023 Ocean Protocol Foundation
## SPDX-License-Identifier: Apache-2.0
##
FROM python:3.8-slim-buster
LABEL maintainer="Ocean Protocol <devops@oceanprotocol.com>"

ARG PROVIDER_PRIVATE_KEY
ARG PROVIDER_ADDRESS

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential \
    gcc \
    gettext-base && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY . /ocean-provider
WORKDIR /ocean-provider

# Install dependencies in a virtual environment
RUN python3.8 -m pip install --no-cache-dir setuptools wheel && \
    python3.8 -m pip install --no-cache-dir .

ENV NETWORK_URL='https://rpc.test.pontus-x.eu'

ENV PROVIDER_PRIVATE_KEY=${PROVIDER_PRIVATE_KEY}
ENV PROVIDER_ADDRESS=${PROVIDER_ADDRESS}

ENV PROVIDER_FEE_TOKEN='0x5B190F9E2E721f8c811E4d584383E3d57b865C69'

ENV AQUARIUS_URL='https://aquarius.pontus-x.eu'

ENV AZURE_ACCOUNT_NAME=''
ENV AZURE_ACCOUNT_KEY=''
ENV AZURE_RESOURCE_GROUP=''
ENV AZURE_LOCATION=''
ENV AZURE_CLIENT_ID=''
ENV AZURE_CLIENT_SECRET=''
ENV AZURE_TENANT_ID=''
ENV AZURE_SUBSCRIPTION_ID=''

ENV neu=''
# do checksums only if file size < 5 Mb
ENV MAX_CHECKSUM_LENGTH='5242880'

# Note: AZURE_SHARE_INPUT and AZURE_SHARE_OUTPUT are only used
# for Azure Compute data assets (not for Azure Storage data assets).
# If you're not supporting Azure Compute, just leave their values
# as 'compute' and 'output', respectively.
ENV AZURE_SHARE_INPUT='compute'
ENV AZURE_SHARE_OUTPUT='output'

ENV OCEAN_PROVIDER_URL='http://0.0.0.0:8030'

ENV OCEAN_PROVIDER_WORKERS='1'
ENV OCEAN_PROVIDER_TIMEOUT='9000'
ENV ALLOW_NON_PUBLIC_IP=False
ENV ARWEAVE_GATEWAY=https://arweave.net/
ENV IPFS_GATEWAY=https://ipfs.io


ENTRYPOINT ["/ocean-provider/docker-entrypoint.sh"]

EXPOSE 8030
