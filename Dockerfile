# 1) choose base container
# generally use the most recent tag

# base notebook, contains Jupyter and relevant tools
# See https://github.com/ucsd-ets/datahub-docker-stack/wiki/Stable-Tag 
# for a list of the most current containers we maintain
ARG BASE_CONTAINER=ghcr.io/ucsd-ets/sp26-cuda128:main

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"
LABEL org.opencontainers.image.source="https://github.com/jimmywootton/new-mt3-dsmlp"

# 2) change to root to install packages
USER root

RUN apt-get update -y && \
    apt-get -y install git-lfs

# 3) install packages using notebook user
USER jovyan

WORKDIR /opt/conda

RUN git lfs install && \
    git clone https://huggingface.co/spaces/mimbres/YourMT3

WORKDIR /opt/conda/YourMT3

COPY --chown=jovyan:jovyan app.py model_helper.py ./

RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --no-cache-dir spaces && \
    chmod -R o+w .

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]
