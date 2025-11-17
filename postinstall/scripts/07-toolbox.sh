#!/bin/bash

podman build -t toolbox-base -f ../toolbox/Containerfile

toolbox create -i toolbox-base dev-toolbox
