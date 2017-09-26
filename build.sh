#!/bin/bash

source .glitch_env
source .glitch_aliases

docker build -t $IMAGE .
