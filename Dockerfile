# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ghcr.io/ucsd-ets/sp26-cuda128:stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"
LABEL org.opencontainers.image.source="https://github.com/jimmywootton/new-mt3-dsmlp"

# 2) change to root to install packages
USER root

RUN apt-get update -y && \
    apt-get -y install git-lfs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# 3) install packages using notebook user
USER jovyan

# RUN conda install -y scikit-learn

RUN git lfs install && \
    git clone https://huggingface.co/spaces/mimbres/YourMT3

WORKDIR /home/jovyan/YourMT3

RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir spaces

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]
