FROM debian:stretch

RUN apt-get update && apt-get install -y \
  curl \
  git \
  psmisc \
  sudo \
  vim \
  zsh \ 
  docker.io
# Consider using full docker.io if docker client fails due to compatibility

# Get the docker client. 
#WORKDIR /tmp
#RUN curl -s https://master.dockerproject.org/linux/x86_64/docker.sha256 \ 
#  | sed "s/build\\/linux\\/docker\\/docker/-/g" > docker.sha256 \
#  && curl -s https://master.dockerproject.org/linux/x86_64/docker \ 
#  | tee docker \ 
#  | sha256sum -c docker.sha256 \ 
#  && mv docker /usr/bin/docker \
#  && chmod ugo+x /usr/bin/docker

# Set up shared volume
RUN mkdir /var/shared/ \
  && touch /var/shared/placeholder  
VOLUME /var/shared

# Setup development user
ENV DEV_USER dev
RUN useradd $DEV_USER \
  && echo "$DEV_USER:$DEV_USER" | chpasswd \ 
  && adduser $DEV_USER sudo \
  && mkdir /home/$DEV_USER \
  && mkdir /home/$DEV_USER/workspace \
  && touch /home/$DEV_USER/workspace/placeholder \
  && chown -R $DEV_USER:$DEV_USER /var/shared
WORKDIR /home/$DEV_USER

# Setup up zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git .oh-my-zsh 
COPY .glitch_aliases .zshrc ./

# Set permissions on dev home folder
RUN chown -R $DEV_USER: /home/$DEV_USER

USER $DEV_USER
CMD ["/bin/zsh"]
