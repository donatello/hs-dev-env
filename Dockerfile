# Current command to start it: "sudo docker run -v $PWD:/home/aditya --rm -t -i donatello/hs-dev-env /bin/bash"
FROM ubuntu:14.04

MAINTAINER aditya.mmy@gmail.com
ENV DEBIAN_FRONTEND noninteractive

# Install basic needed packages
RUN apt-get update
RUN apt-get install -y software-properties-common

# Herbert's PPA, as recommended by https://www.stackage.org/install
RUN add-apt-repository -y ppa:hvr/ghc
RUN apt-get update
RUN apt-get install -y cabal-install-1.22 ghc-7.8.4
RUN apt-get install -y wget

ENV PATH /root/.cabal/bin:/opt/cabal/1.22/bin:/opt/ghc/7.8.4/bin:$PATH

RUN cabal update
RUN mkdir /opt/sandbox-for-stackage

WORKDIR /opt/sandbox-for-stackage
RUN wget -q -O cabal.config http://stackage.org/lts/cabal.config
RUN cabal sandbox init
RUN cabal update
RUN cabal install stackage-cli

# stk binary at: /opt/sandbox-for-stackage/.cabal-sandbox/bin/stackage

# Add stackage binary to path
ENV PATH /opt/sandbox-for-stackage/.cabal-sandbox/bin:$PATH

WORKDIR /root
ENTRYPOINT ["/bin/bash"]
