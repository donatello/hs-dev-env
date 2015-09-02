# Current command to start it: "sudo docker run -v $PWD:/home/aditya --rm -t -i donatello/hs-dev-env /bin/bash"
FROM haskell:7.10.2

MAINTAINER aditya.mmy@gmail.com
ENV DEBIAN_FRONTEND noninteractive

# Install needed packages for most basic development
RUN apt-get update && apt-get install -yq \
    build-essential \
    libpq-dev \
    libyajl-dev \
    nano \
    postgresql-client \
    wget \
    zlib1g-dev

RUN mkdir /opt/shared-sandbox
WORKDIR /opt/shared-sandbox
RUN cabal sandbox init --sandbox .

# Select Stackage LTS version
RUN wget -q -O /opt/shared-sandbox/cabal.config \
    https://www.stackage.org/snapshot/lts-3.3/cabal.config

# enable profiling in the sandbox
RUN echo "library-profiling: True" >> /opt/shared-sandbox/cabal.config

ENV CABAL_SANDBOX_CONFIG /opt/shared-sandbox/cabal.sandbox.config

# install a selection of common packages
RUN cabal update
RUN cabal install \
    alex \
    async \
    attoparsec \
    bytestring \
    cereal \
    conduit \
    conduit-combinators \
    conduit-extra \
    configurator \
    containers \
    csv-conduit \
    datetime \
    errors \
    happy \
    hasql \
    hasql-postgres \
    mtl \
    network \
    optparse-applicative \
    persistent \
    persistent-postgresql \
    persistent-template \
    postgresql-libpq \
    postgresql-simple \
    resourcet \
    split \
    strings \
    text \
    transformers \
    vector

RUN cabal install \
    c2hs

ENV PATH /opt/shared-sandbox/bin:$PATH

WORKDIR /code
ENTRYPOINT ["/bin/bash"]
