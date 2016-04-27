#
# vim: set ft=dockerfile.sh:
# Base Docker image for Development
# 

FROM debian:jessie 
MAINTAINER John R. Ray <john@johnray.io>

# Set the debconf front end to Noninteractive
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

# Install admin tools
RUN apt-get update && apt-get install -y \
  wget \
  vim \
  curl \
  build-essential \
  git \
  && apt-get clean

# Create user and add dotfiles
RUN useradd -m -s /bin/bash dev
COPY vimrc /home/dev/.vimrc
RUN chown dev:dev /home/dev/.vimrc
USER dev

# Add pathogen and vim modules
RUN git clone https://github.com/tpope/vim-pathogen.git ~/.vim
RUN mkdir -p ~/.vim/plugins && git init -q ~/.vim/plugins
WORKDIR /home/dev/.vim/plugins
RUN git submodule add -f https://github.com/tpope/vim-sensible.git ~/.vim/plugins/vim-sensible \
  && git submodule add -f https://github.com/godlygeek/tabular.git ~/.vim/plugins/tabular \
  && git submodule add -f https://github.com/scrooloose/syntastic.git ~/.vim/plugins/syntastic \
  && git submodule add -f https://github.com/kien/rainbow_parentheses.vim.git

# Sane Defaults for next image
USER root
WORKDIR /

