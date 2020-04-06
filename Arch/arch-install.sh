#!/usr/bin/env bash
# Make sure we are up to date -- this is Arch after all!
pacman -Syu
# now get some fresh
# shell tools
pacman -S --noconfirm --needed zsh
pacman -S --noconfirm --needed tmux
pacman -S --noconfirm --needed tree
# developer basics
pacman -S --noconfirm --needed base-devel
pacman -S --noconfirm --needed git
pacman -S --noconfirm --needed emacs-nox
# basic compilers and interpreters
pacman -S --noconfirm --needed clang
pacman -S --noconfirm --needed gcc
pacman -S --noconfirm --needed gcc-fortran
pacman -S --noconfirm --needed r
# other tools
pacman -S --noconfirm --needed man-db
pacman -S --noconfirm --needed man-pages
pacman -S --noconfirm --needed w3m

# Haskell TODO: pre-reqs
# install the installer tool script
curl --silent https://gitlab.haskell.org/haskell/ghcup/raw/master/ghcup > /usr/local/bin/ghcup
chmod u+x /usr/local/bin/ghcup

