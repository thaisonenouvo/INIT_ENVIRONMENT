install_oh_my_zsh() {
  echo "Setting up zsh..." \
  && cd ~ \
  && git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
  && git clone https://github.com/zsh-users/zsh-completions#oh-my-zsh \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
  && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
  && echo "Finished dowload package plugin for zshrc."
}

install_github(){
  echo "Setting up github..." \
  && echo "Finished setting for github."
}


install_homebrew() {
  echo "Setting up homebrew..." \
  && /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" \
  && brew install yarn \
  && brew install watchman 
  && brew install tmux \
  && brew install heroku/brew/heroku \
  && brew install qt5  \
  && pip3 install qutebrowser \
  && brew install neovim \ 
  && brew install zsh-completions \
  && brew install zsh-syntax-highlighting \
  && brew uninstall --force postgresql \
  && brew cask install iterm2 \
  && rm -rf /usr/local/var/postgres \
  && brew install postgres \
  echo "Successing to setting homebrew..." 
}
install_npm() {
  echo "Setting up package npm global..." \
  && brew install nvm \ 
  && source ~/.zshrc \
  && mkdir ~/.nvm \ 
  && npm i -g eslint \
  && npm i -g react-native-cli \
  && npm i -g npm-check-updates \
  echo "Setting up package npm global..." 
}

install_neovim() {
  echo "Setting up neovim..." \
  && rm -rf ~/.config/nvim \
  && git clone https://github.com/tranthaison1231/Dotfiles ~/.config/nvim/ \
  && nvim -c 'PlugInstall' \
  echo "Successing to setting neovim..." 
}

setup_git() {
  read -r -p "Do you want to setup git? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
    git config --global user.email "thaison.coderstokyo@gmail.com" 
    git config --global user.name "tranthaison1231" 
    git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
    git config --global color.ui true
    git config --global color.diff-highlight.oldNormal "red bold"
    git config --global color.diff-highlight.oldHighlight "red bold 52"
    git config --global color.diff-highlight.newNormal "green bold"
    git config --global color.diff.meta "11"
    git config --global color.diff.frag "magenta bold"
    git config --global color.diff.commit "yellow bold"
    git config --global color.diff.old "red bold"
    git config --global color.diff.new "green bold"
    git config --global color.diff.whitespace "red reverse"

    success "Setup Git Successfully"
  fi
}


if [[ -z $1 ]]; then
  echo "This will delete all your previous homebrew, nvim, zsh settings. Proceed? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    echo "Installing dependencies..." \
    && install_homebrew \
    && install_oh_my_zsh \
    && install_npm \
    && install_neovim \
    && setup_git \
    && echo "Finished installation."
  fi
else
  "install_$1" $1
fi

