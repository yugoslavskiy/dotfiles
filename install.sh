main() {
  # oh-my-zsh
  sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  
  # zsh-completions plugin
  git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
  
  # zsh-syntax-highlighting plugin
  git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
  
  ## vim
  git clone https://github.com/amix/vimrc.git ~/.vim_runtime
  sh ~/.vim_runtime/install_awesome_vimrc.sh
  
  ## dotfiles
  git clone https://github.com/yugoslavskiy/dotfiles ~/.dotfiles

  if [ `uname -s` = "Darwin" ]; then
    ln -sfhv "~/.dotfiles/Darwin/profile/.zshrc" ~
    ln -sfhv "~/.dotfiles/git/.gitconfig" ~
  	echo "OS X profile exported."
  elif [ `uname -s` = "Linux" ]; then
    ln -sfv "~/.dotfiles/Linux/profile/.zshrc" ~
    ln -sfv "~/.dotfiles/git/.gitconfig" ~
  	echo "Linux profile exported."
  else
  	echo "Cannot determine the system type."
  	echo "No system-specific features was exported."
  fi
}

main