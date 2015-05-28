# Current command to start it: "sudo docker run -v $PWD:/home/aditya --rm -t -i donatello/hs-dev-env /bin/bash"
FROM ubuntu:14.04

MAINTAINER aditya.mmy@gmail.com
ENV DEBIAN_FRONTEND noninteractive

# Install basic needed packages
RUN apt-get update
RUN apt-get install -y software-properties-common wget zlib1g-dev

# Herbert's PPA, as recommended by https://www.stackage.org/install
RUN add-apt-repository -y ppa:hvr/ghc
RUN apt-get update
RUN apt-get install -y cabal-install-1.22 ghc-7.8.4

ENV PATH /root/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:$PATH

RUN mkdir /opt/shared-sandbox
RUN cabal sandbox init --sandbox /opt/shared-sandbox

# Select Stackage LTS 2.10
RUN wget -q -O /opt/shared-sandbox/cabal.config https://www.stackage.org/snapshot/lts-2.10/cabal.config

ENV CABAL_SANDBOX_CONFIG /opt/shared-sandbox/cabal.sandbox.config

WORKDIR /code
ENTRYPOINT ["/bin/bash"]
