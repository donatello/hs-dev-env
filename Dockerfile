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
RUN apt-get install -y cabal-install-1.20 ghc-7.8.4

RUN echo 'export PATH=~/.cabal/bin:/opt/cabal/1.20/bin:/opt/ghc/7.8.4/bin:$PATH' >> ~/.bashrc
RUN /opt/cabal/1.20/bin/cabal update
RUN /opt/cabal/1.20/bin/cabal install alex happy
