FROM continuumio/miniconda3:4.7.12

ARG NB_USER="jovyan"
# We assume only one user per container, so make it unique
# UID matches GID
ARG NB_UID="1000"

# Install apt packages
COPY apt.txt /opt/apt.txt

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
    $(grep -vE "^\s*#" /opt/apt.txt  | tr "\n" " ") \
    > /dev/null && \
    rm -rf /var/lib/apt/lists/* && \
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen

ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    SHELL=/bin/bash \
    CONDA_DIR=/opt/conda \
    DEFAULT_ENV=default

# Activate default environment
ENV PATH=${CONDA_DIR}/envs/${DEFAULT_ENV}/bin:${CONDA_DIR}/bin:${PATH}

# Enable prompt color in the skeleton .bashrc before creating the default NB_USER
RUN sed -i 's/^#force_color_prompt=yes/force_color_prompt=yes/' /etc/skel/.bashrc && \
    # Create user & group jovyan
    groupadd --gid ${NB_UID} ${NB_USER} && \
    useradd \
    --comment 'Jupyter container user' \
    --create-home \
    --no-log-init \
    --shell /bin/bash \
    --gid ${NB_UID} \
    --uid ${NB_UID} \
    ${NB_USER}

# Install our conda environment, make sure it's writeable by our container user
COPY environment.yaml /opt/environment.yaml

# Allow users to keep custom environments in $HOME/envs
RUN conda config --system --set channel_priority strict && \
    conda env create --file /opt/environment.yaml -q && \
    conda clean --all -f -y && \
    chown -R ${NB_UID}:${NB_UID} /opt/conda/ && \
    conda list -n ${DEFAULT_ENV}

USER ${NB_UID}

COPY ipython_config.py /etc/ipython/ipython_config.py
COPY postBuild /tmp/postBuild
RUN /tmp/postBuild

EXPOSE 8888

WORKDIR /home/${NB_USER}
