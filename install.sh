#!/bin/bash

DOTFILE="$HOME/mvdotfiles"

# Create symbolic link
echo -ne "\t+ Installing OH MY ZSH...\n"
if [ ! -e "$HOME/.oh-my-zsh"  ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [[ $(uname) == 'Darwin' ]]; then
  echo -ne "\t+ Install MAC Functions...\n"
  source "./installation/mv_mac_install.sh"
else
  echo -ne "\t+ Install Linux Functions...\n"
  source "./installation/linux_install.sh"
fi

# Installing VIM
echo -ne "\t+ Installing VIM ...\n"
if [ ! -e "$HOME/.vim"  ]; then
  mkdir -p ~/.vim ~/.vim/autoload ~/.vim/backup ~/.vim/colors ~/.vim/plugged
fi


echo -ne "\t+ Linking vim file...\n"
if [ -e "$HOME/.vimrc" ]; then
  unlink "$HOME/.vimrc"
fi

if [ ! -e "$HOME/.vimrc"  ]; then
  ln -s "$DOTFILE/vimrc" "$HOME/.vimrc"
fi

echo -ne "\t+ Install Plug ...\n"
if [ ! -e "$HOME/.vim/autoload/plug.vim" ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

echo -ne "\t+ Install VIMColorSchema ...\n"
if [  -e "$HOME/.vim/colors" ]; then
  if [ ! -e "$HOME/.vim/colors/molokai.vim" ]; then
    cd ~/.vim/colors && curl -o molokai.vim https://raw.githubusercontent.com/tomasr/molokai/master/colors/molokai.vim
  fi
fi

echo -ne "\t+ Install FZF ...\n"
if [ ! -e "$HOME/.fzf" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
fi

echo -ne "\t+ Install AutoSuggestions ...\n"
if [ ! -e "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

echo -ne "\t+ Install SyntaxHighLighting ...\n"
if [ ! -e "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi
