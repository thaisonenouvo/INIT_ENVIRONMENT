install_oh_my_zsh() {
  git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM:=~/.oh-my-zsh/custom}/plugins/zsh-completions \
  && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
  && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
  && git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
  && ln -fs "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" \
  && cd ~ && rm -rf ~/config/nvim && git clone https://github.com/tranthaison1231/Dotfiles.git ~/.config/nvim/ \
  && source ~/.zshrc \
  echo "Finished dowload package plugin for zshrc."
}


install_flutter(){
  echo "Setting up golang..." \
  && cd ~ \
  && git clone https://github.com/flutter/flutter.git -b stable \
  && flutter precache \
  && echo 6526393son | sudo -S gem install cocoapods
}


install_golang(){
  echo "Setting up golang..." \
  && cd ~ \
  && go get golang.org/dl/go1.14 \
  && go1.14 download \
  && echo "Finished setting for golang."
}


install_npm() {
  echo "Setting up package npm global..." \
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
  fi
  echo "Setup Git Successfully"
}


if [[ -z $1 ]]; then
  echo "This will delete all your previous homebrew, nvim, zsh settings. Proceed? (y/n)? "
  read answer
  if echo "$answer" | grep -iq "^y" ;then
    echo "Installing dependencies..." \
    install_oh_my_zsh \
    && install_npm \
    && install_neovim \
    && setup_git \
    && install_golang \
    && install_flutter \
    && rm -rf INIT_ENVIROMENT \
    && echo "Finished installation."
  fi
else
  "install_$1" $1
fi
