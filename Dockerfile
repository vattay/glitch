FROM ubuntu:16.04

ENV DEV_USER dev

RUN apt-get update && apt-get install -y \
  curl \
  git \
  sudo \
  vim \
  zsh \
  sudo \
  curl \
  psmisc \
  docker.io
# Consider using docker.io if docker client fails due to compatibility

# Get the docker client only. This could break as it is the master branch build of the client. Use the docker.io package in that case.
#WORKDIR /tmp
#RUN curl -s https://master.dockerproject.org/linux/x86_64/docker.sha256 \ 
#  | sed "s/build\\/linux\\/docker\\/docker/-/g" > docker.sha256 \
#  && curl -s https://master.dockerproject.org/linux/x86_64/docker \ 
#  | tee docker \ 
#  | sha256sum -c docker.sha256 \ 
#  && mv docker /usr/bin/docker \
#  && chmod ugo+x /usr/bin/docker

RUN useradd $DEV_USER \
  && echo "$DEV_USER:$DEV_USER" | chpasswd \ 
  && adduser $DEV_USER sudo \
  && mkdir /home/$DEV_USER \
  && mkdir /home/$DEV_USER/workspace \
  && touch /home/$DEV_USER/workspace/placeholder \
  && chown -R $DEV_USER: /home/$DEV_USER

RUN mkdir /var/shared/ \
  && touch /var/shared/placeholder \ 
  && chown -R $DEV_USER:$DEV_USER /var/shared
VOLUME /var/shared

WORKDIR /home/$DEV_USER

USER $DEV_USER

RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh 

COPY zshrc.template .zshrc
COPY .glitch_aliases .

WORKDIR /home/$DEV_USER/workspace/bound

CMD ["/bin/zsh"]
