install_oh_my_zsh() {
  echo "Setting up zsh..." \
  && rm -rf ~/.oh-my-zsh \
  && rm -rf .zsh_history \
  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && echo "Finished dowload package plugin for zshrc."
}

install_homebrew() {
  echo "Setting up homebrew..." \
  && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  && brew install yarn \
  && brew install tmux \
  && brew install watchman \
  && brew install heroku/brew/heroku \
  && brew install qt5  \
  && pip3 install qutebrowser \
  && brew install zsh-completions \
  && brew install neovim \
  && brew install zsh-syntax-highlighting \
  && brew uninstall --force postgresql \
  && brew cask install iterm2 \
  && rm -rf /usr/local/var/postgres \
  && brew install postgres \
  && brew install nvm \
  && brew install exa \
  && echo "Successing to setting homebrew..." 
}
install_npm() {
  echo "Setting up package npm global..." \
  && source ~/.zshrc \
  && mkdir ~/.nvm \
  && npm i -g eslint \
  && npm i -g react-native-cli \
  && npm i -g npm-check-updates \
  && echo "Setting up package npm global..." 
}

install_neovim() {
  echo "Setting up neovim..." \
  && nvim -c 'PlugInstall' \
  && echo "Successing to setting neovim..." 
}

if [[ -z $1 ]]; then
  echo "This will delete all your previous homebrew, nvim, zsh settings. Proceed? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    echo "Installing dependencies..." \
    && install_homebrew \
    && install_oh_my_zsh \
    && echo "Finished installation."
  fi
else
  "install_$1" $1
fi

