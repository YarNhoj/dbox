#
# vim: set ft=dockerfile.sh:
# Base Docker image for Development
# 

FROM debian:jessie 
MAINTAINER John R. Ray <jray@shadow-soft.com>

# Set the debconf front end to Noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install admin tools
RUN apt-get update && apt-get install -y \
  wget \
  vim \
  curl \
  build-essential \
  ruby \
  git \
  && apt-get clean

# Create user and add dotfiles
RUN useradd -m -s /bin/bash jray
COPY vimrc /home/jray/.vimrc
RUN chown jray:jray /home/jray/.vimrc
USER jray

# Add pathogen and vim modules
RUN git clone https://github.com/tpope/vim-pathogen.git ~/.vim
RUN mkdir -p ~/.vim/plugins && git init -q ~/.vim/plugins
WORKDIR /home/jray/.vim/plugins
RUN git submodule add -f https://github.com/tpope/vim-sensible.git ~/.vim/plugins/vim-sensible \
  && git submodule add -f https://github.com/rodjek/vim-puppet.git ~/.vim/plugins/vim-puppet \
  && git submodule add -f https://github.com/godlygeek/tabular.git ~/.vim/plugins/tabular \
  && git submodule add -f https://github.com/scrooloose/syntastic.git ~/.vim/plugins/syntastic

# Sane Defaults for next image
USER root
WORKDIR /

