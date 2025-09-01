#!/bin/bash

# Source os-release to check for cachyos
source /etc/os-release

if [[ "$ID" == "cachyos" ]]; then
  echo -e "Cachy system detected, proceeding with script. \n"
elif [ -f "/etc/arch-release" ]; then

  echo -e "Arch-based system detected, adding Cachy repos before proceeding with script. \n"

  # Import the repository key
  sudo pacman-key --recv-keys F3B607488DB35A47 --keyserver keyserver.ubuntu.com
  # Sign the repository key
  sudo pacman-key --lsign-key F3B607488DB35A47
  # Install the necessary packages
  sudo pacman -U 'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-keyring-20240331-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v3-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/cachyos-v4-mirrorlist-22-1-any.pkg.tar.zst' \
    'https://mirror.cachyos.org/repo/x86_64/cachyos/pacman-7.0.0.r7.g1f38429-1-x86_64.pkg.tar.zst'

  # Add the CachyOS repositories to the pacman config file
  cat $HOME/.local/share/chezmoi/cachy_repos.txt >>/etc/pacman.conf

  # Update your system with CachyOS packages
  sudo pacman -Syu

else
  echo "Script only works for Arch-based distributions."
  echo "Aborting..."
  exit 0
fi

echo "Installing packages"

# Putting everything on a new line for readablity
sudo pacman -S cachyos-extra-v3/git
sudo pacman -S cachyos/zen-browser-bin
sudo pacman -S cachyos-extra-v3/spotify-launcher
sudo pacman -S cachyos-extra-v3/alacritty
sudo pacman -S cachyos-extra-v3/btop
sudo pacman -S cachyos-extra-v3/fastfetch
sudo pacman -S extra/discord
sudo pacman -S extra/signal-desktop
sudo pacman -S cachyos-extra-v3/zed
sudo pacman -S cachyos-extra-v3/code
sudo pacman -S cachyos-extra-v3/thunar

echo -e "Installing Paru now. Process takes some extra steps \n"

sudo pacman -S cachyos/paru

mkdir ~/.config/paru

echo -e "Installing Vim now. Process takes some extra steps \n"

sudo pacman -S cachyos-extra-v3/vim

mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
touch ~/.vimrc
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -o ~/.vim/colors/molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
vim +PlugInstall +qall

echo -e "Installing Neovim now. Process takes some extra steps"

sudo pacman -S cachyos-extra-v3/neovim

mkdir ~/.config/nvim
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
