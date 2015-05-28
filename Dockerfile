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

WORKDIR /code
ENTRYPOINT ["/bin/bash"]
