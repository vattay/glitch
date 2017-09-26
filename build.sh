#!/bin/bash

IMAGE='oxide/glitch'

source .glitch_aliases

docker build -t $IMAGE .
