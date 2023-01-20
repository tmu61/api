FROM ubuntu:20.04
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
  mkdir /root/creds && mkdir /root/.oh-my-zsh
RUN mkdir /data
RUN sed -i -e 's/root:x:0:0:root:\/root:\/bin\/bash/root:x:0:0:root:\/root:\/usr\/bin\/zsh/' /etc/passwd
COPY oh-my-zsh.tgz /root
RUN cd /root && tar xvzf oh-my-zsh.tgz && chown -R root:root .oh-my-zsh
COPY bin /usr/local/bin
COPY .p10k.zsh /root
COPY .zshrc /root
COPY .bashrc /root
COPY nsx /root/nsx/
COPY shadow /etc
CMD ["/bin/bash", "/startup"]
