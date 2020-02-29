install_oh_my_zsh() {
  echo "Setting up zsh..." \
  && rm -rf ~/.oh-my-zsh \
  && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
  && cd ~ && rm -rf ~/config/nvim && git clone https://github.com/tranthaison1231/Dotfiles.git ~/.config/nvim/ \
  && source ~/.config/nvim/.zshrc \
  && git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
  && git clone https://github.com/zsh-users/zsh-completions#oh-my-zsh \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
  && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
  && echo "Finished dowload package plugin for zshrc."
}

install_golang(){
  echo "Setting up golang..." \
  && cd ~ \
  && go get golang.org/dl/go1.14 \
  && go1.14 download \
  && echo "Finished setting for golang."
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

install_app() {
  read -r -p "Do you want to setup some app? [y|N] " response
  if [[ $response =~ (y|yes|Y) ]];then
   echo "Setting up VSCODE..." \
   && brew update \                           # Fetch latest version of homebrew and formula.
   && brew tap caskroom/cask \                # Tap the Caskroom/Cask repository from Github using HTTPS.
   && brew search visual-studio-code \        # Searches all known Casks for a partial or exact match.
   && brew cask info visual-studio-code \     # Displays information about the given Cask
   && brew cask install visual-studio-code \  # Install the given cask.
   && brew cleanup \    
   echo "Setup vscode Successfully" \
   success "Setup App Successfully"
  fi
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
    && install_golang \
    && echo "Finished installation."
  fi
else
  "install_$1" $1
fi

