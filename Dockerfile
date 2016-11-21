FROM centos:centos7
MAINTAINER Chase Gilliam <chase.gilliam@gmail.com>
ENV ERLANG_VERSION 19.1.5
ENV ELIXIR_VERSION 1.3.4
ENV PHOENIX_VERSION 1.2.1

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN yum -y install --setopt=tsflags=nodocs epel-release wget unzip uuid less bzip2 git-core inotify-tools && \
    yum -y install https://packages.erlang-solutions.com/erlang/esl-erlang/FLAVOUR_1_general/esl-erlang_${ERLANG_VERSION}~centos~7_amd64.rpm && \
    yum -y install esl-erlang-${ERLANG_VERSION} && \
    yum -y update && \
    yum -y reinstall glibc-common glibc && \
    yum clean all

RUN cd /tmp && \
    wget https://github.com/elixir-lang/elixir/releases/download/v${ELIXIR_VERSION}/Precompiled.zip && \
    unzip -d /usr/local/elixir -x Precompiled.zip && \
    rm -f /tmp/Precompiled.zip

ENV PATH $PATH:/usr/local/elixir/bin
RUN yes | mix local.hex
RUN yes | mix archive.install https://github.com/phoenixframework/archives/raw/master/phoenix_new-$PHOENIX_VERSION.ez
