FROM ubuntu:20.04
RUN \
apt-get update && \
apt-get install -y openssh-server && \
  apt-get update && apt-get -y install iproute2 iputils-ping inetutils-traceroute tcpdump openssh-server vim && \
  apt-get install -y --no-install-recommends apt-utils build-essential ca-certificates curl kmod expect zsh gettext-base jq&& \
  apt-get upgrade -y && \
  mkdir /run/sshd && \
  sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  echo "/usr/sbin/sshd" >/startup && \
  echo "/bin/sleep 3650d" >>/startup && \
  mkdir /root/creds && mkdir /root/.oh-my-zsh
RUN apt-get install -y less
RUN sed -i -e 's/root:x:0:0:root:\/root:\/bin\/bash/root:x:0:0:root:\/root:\/usr\/bin\/zsh/' /etc/passwd
COPY bin /usr/local/bin
COPY .oh-my-zsh /root/.oh-my-zsh
COPY .p10k.zsh /root
COPY .zshrc /root
COPY .bashrc /root
COPY .ssh/* /root/.ssh/
COPY nsx /root/nsx/
COPY shadow /etc
CMD ["/bin/bash", "/startup"]
