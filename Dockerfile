FROM ubuntu:16.04

ENV DEV_USER dev

RUN apt-get update && apt-get install -y \
  git \
  vim \
  docker.io \
  zsh \
  sudo

RUN useradd $DEV_USER \
  && echo "$DEV_USER:$DEV_USER" | chpasswd \ 
  && adduser $DEV_USER sudo \
  && mkdir /home/$DEV_USER \
  && chown -R $DEV_USER: /home/$DEV_USER

RUN mkdir /var/shared/ \
  && touch /var/shared/placeholder \ 
  && chown -R $DEV_USER:$DEV_USER /var/shared
VOLUME /var/shared

WORKDIR /home/$DEV_USER
ENV HOME /home/$DEV_USER

RUN chown -R $DEV_USER: /home/$DEV_USER
USER $DEV_USER

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh 

COPY zshrc.template .zshrc
COPY .common_aliases .

CMD ["/bin/zsh"]
