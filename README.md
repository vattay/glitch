# glitch
Infinitely nestable docker Zsh workspaces. Bind mounts the current directory.

## usage
    DOCKER_GID=$(ls -nl /var/run/docker.sock | cut -d ' ' -f4)
    docker run -it --rm \
      --mount source=glitch-volume,target=/var/shared \
      -v /var/run/docker.sock:/var/run/docker.sock \
      --mount type=bind,source="$(pwd)",target=/home/dev/workspace \
      --group-add $DOCKER_GID \
      oxide/glitch    

## build
    ./build.sh
    glitch
    



