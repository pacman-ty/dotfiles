#!/bin/bash

if [ -f "/etc/arch-release" ]; then
  echo -e "Arch-based system detected, proceeding with script. \n"
else
  echo "Script only works for Arch-based distributions."
  echo "Aborting..."
  exit 0
fi

echo "Installing packages"

# Putting everything on a new line for readablity
sudo pacman -S cachyos-extra-v3/git
sudo pacman -S cachyos/paru
sudo pacman -S cachyos/zen-browser-bin
sudo pacman -S cachyos-extra-v3/spotify-launcher
sudo pacman -S cachyos-extra-v3/alacritty
sudo pacman -S cachyos-extra-v3/btop
sudo pacman -S cachyos-extra-v3/fastfetch
sudo pacman -S extra/discord

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
