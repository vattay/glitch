FROM ubuntu:16.04

ENV DEV_USER dev
ENV USER=$DEV_USER

RUN apt-get update && apt-get install -y \
  vim \
  docker.io \
  zsh \
  curl \
  sudo

RUN useradd $DEV_USER && echo "$DEV_USER:$DEV_USER" | chpasswd && adduser $DEV_USER sudo
RUN mkdir /home/$DEV_USER && chown -R $DEV_USER: /home/$DEV_USER

RUN mkdir /var/shared/
RUN touch /var/shared/placeholder
RUN chown -R $DEV_USER:$DEV_USER /var/shared
VOLUME /var/shared

WORKDIR /home/$DEV_USER
ENV HOME /home/$DEV_USER

RUN chown -R $DEV_USER: /home/$DEV_USER
USER $DEV_USER

RUN echo $HOME
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh 

COPY zshrc.template .zshrc
COPY common_aliases.template .common_aliases

CMD ["/bin/zsh"]
