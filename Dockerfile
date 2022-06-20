FROM ubuntu:20.04
COPY oh-my-zsh.tgz /root
RUN \
apt-get update && \
apt-get install -y openssh-server && \
  apt-get update && apt-get -y install iproute2 iputils-ping inetutils-traceroute tcpdump openssh-server vim && \
  apt-get install -y --no-install-recommends apt-utils build-essential ca-certificates curl kmod expect zsh gettext-base jq less&& \
  apt-get upgrade -y && \
  mkdir /run/sshd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  echo "/usr/sbin/sshd" >/startup && \
  echo "/bin/sleep 3650d" >>/startup && \
  mkdir /root/creds && mkdir /root/.oh-my-zsh && \
  cd /root && tar xvzpf oh-my-zsh.tgz && chown -R root .oh-my-zsh && \
  chmod -x /etc/update-motd.d/* && rm /etc/legal
COPY bin /usr/local/bin
COPY .p10k.zsh /root
COPY .zshrc /root
COPY .bashrc /root
COPY .ssh/* /root/.ssh/
COPY nsx /root/nsx/
COPY shadow /etc
COPY passwd /etc
CMD ["/bin/bash", "/startup"]
