## This is the Dockerfile for the dbt devcontainer image

# Base image
FROM python:3.11-slim

# Create a non-root user
ARG USERNAME=user
ARG USER_UID=1000
ARG USER_GID=$USER_UID


RUN groupadd --gid $USER_GID $USERNAME \
  && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
  # Add sudo support for the non-root user
  && apt-get update \
  && apt-get install -y sudo \
  && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
  && chmod 0440 /etc/sudoers.d/$USERNAME \
  && rm -rf /var/lib/apt/lists/*

# Give new user rights to its own home dir
RUN chown $USER_UID:$USER_GID /home/$USERNAME

# Use default bashrc for user + add bin
RUN cp /etc/skel/.bashrc /home/$USERNAME
RUN echo 'export PATH="$HOME/.local/bin:$PATH"' >> /home/user/.bashrc

# Install other dependencies
RUN apt-get update && apt-get install -y \
    lsof \
    git \
    build-essential libpq-dev \
    curl gpg

# Use non-root user for rest of the setup
USER $USERNAME

# Install dbt and dbt-postgres extension through pip
RUN pip install dbt-core dbt-postgres \
    pandas psycopg2 sqlalchemy

