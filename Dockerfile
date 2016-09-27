FROM phusion/baseimage
ENV DEBIAN_FRONTEND noninteractive

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*
RUN apt-get update && apt-get clean && apt-get update && apt-get upgrade -y && apt-get dist-upgrade -y

RUN apt-get install -y python-software-properties software-properties-common vim telnet language-pack-de-base dos2unix git socat acl ssmtp wget mysql-client watchdog update-manager-core mc nano
RUN yes|do-release-upgrade -d -f DistUpgradeViewNonInteractive

RUN echo "export TERM=linux" | tee -a /root/.bashrc /etc/bash.bashrc
RUN echo "Host *\nStrictHostKeyChecking no\nUserKnownHostsFile=/dev/null">>/root/.ssh/config

RUN rm -f /etc/localtime && ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN locale-gen de_DE.UTF-8
RUN export LANG=de_DE.UTF-8
RUN export TERM=xterm

RUN rm -rf /var/lib/apt/lists/* /var/cache/apt/*
CMD ["/sbin/my_init"]

VOLUME /mnt
VOLUME /var/www/html
