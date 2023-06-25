FROM docker.io/library/debian:bookworm

ENV DEBIAN_FRONTEND="noninteractive"
ENV DEBCONF_NOWARNINGS="yes"

# Configure APT
RUN sed -i 's/^Components: main$/Components: main contrib non-free non-free-firmware/g' /etc/apt/sources.list.d/debian.sources \
  && dpkg --add-architecture i386 \
  && apt-get -y update \
  && apt-get -y upgrade

# Prevent tzdata's interactive prompt from blocking
RUN DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get -y install tzdata

# Locales
RUN apt-get -y install locales \
  && echo "en_US.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen en_US.UTF-8 UTF-8 && update-locale en_US.UTF-8 UTF-8 \
  && echo "LANG=en_US.utf-8" >> /etc/environment \
  && echo "LC_ALL=en_US.utf-8" >> /etc/environment

# Packages
RUN echo steam steam/question select "I AGREE" | debconf-set-selections \
  && echo steam steam/license note '' | debconf-set-selections \
  && apt-get -y install expect curl steamcmd nodejs jq

COPY ./bin /app/bin
ENTRYPOINT [ "/app/bin/entrypoint.sh" ]
