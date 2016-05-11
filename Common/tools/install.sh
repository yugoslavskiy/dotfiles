main() {
  # Use colors, but only if connected to a terminal, and that terminal
  # supports them.
  if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
  fi
  if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
    RED="$(tput setaf 1)"
    GREEN="$(tput setaf 2)"
    YELLOW="$(tput setaf 3)"
    BLUE="$(tput setaf 4)"
    BOLD="$(tput bold)"
    NORMAL="$(tput sgr0)"
  else
    RED=""
    GREEN=""
    YELLOW=""
    BLUE=""
    BOLD=""
    NORMAL=""
  fi

  # Only enable exit-on-error after the non-critical colorization stuff,
  # which may fail on systems lacking tput or terminfo
  set -e

  # Check common tools
  declare -a SYSTEMS=( 'Darwin:brew' 'Linux:sudo apt-get -y' )
  declare -a TOOLS=( 'zsh' 'git' 'wget' 'vim' )

  for pair in "${SYSTEMS[@]}"; do
    os=$( echo $pair | cut -d ':' -f 1 )
    pm=$( echo $pair | cut -d ':' -f 2 )
    for tool in "${TOOLS[@]}"; do
      if [[ $( uname -s ) = "${os}" ]]; then
        hash ${tool} >& /dev/null || {
          printf "${RED}[!]${NORMAL} ${BOLD}${tool}${NORMAL} is not installed!\n"
          printf "${YELLOW}[*]${NORMAL} Trying to install ${BOLD}${tool}${NORMAL} via '${pm}'...\n"
          bash -c "${pm} install ${tool}" >& /dev/null || { 
            printf "${RED}[-] Error: ${tool} installation failed.${NORMAL} Quitting...\n"
            exit 1
          }
          printf "${GREEN}[+] ${tool} ${NORMAL}was successfully installed.\n"
        }
      fi
    done
  done

  if [ ! -n "$ZSH" ]; then
    ZSH=~/.oh-my-zsh
  fi

  printf "${BLUE}[*] Looking for an existing Oh My Zsh installation...${NORMAL}\n"
  if [ -d "$ZSH" ]; then
    printf "${YELLOW}[!] Found $ZSH.${NORMAL} ${GREEN}Backing up to $ZSH.old.pre-dotfiles-install${NORMAL}\n";
    mv $ZSH $ZSH.old.pre-dotfiles-install;
  fi

  # Prevent the cloned repository from having insecure permissions. Failing to do
  # so causes compinit() calls to fail with "command not found: compdef" errors
  # for users with insecure umasks (e.g., "002", allowing group writability). Note
  # that this will be ignored under Cygwin by default, as Windows ACLs take
  # precedence over umasks except for filesystems mounted with option "noacl".
  umask g-w,o-w

  printf "${GREEN}[+]${NORMAL} Cloning ${GREEN}Oh My Zsh${NORMAL}...\n"
  env git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $ZSH &>/dev/null || {
    printf "${RED}[!] Error: git clone of oh-my-zsh repo failed.${NORMAL} Quitting...\n"
    exit 1
  }

  printf "${GREEN}"
  echo '         __                                     __   '
  echo '  ____  / /_     ____ ___  __  __   ____  _____/ /_  '
  echo ' / __ \/ __ \   / __ `__ \/ / / /  /_  / / ___/ __ \ '
  echo '/ /_/ / / / /  / / / / / / /_/ /    / /_(__  ) / / / '
  echo '\____/_/ /_/  /_/ /_/ /_/\__, /    /___/____/_/ /_/  '
  echo '                        /____/                       ...is now installed!'
  echo ''
  echo 'p.s. Follow us at https://twitter.com/ohmyzsh.'
  echo ''
  echo 'p.p.s. Get stickers and t-shirts at http://shop.planetargon.com.'
  echo ''
  printf "${NORMAL}"

  printf "${GREEN}[+]${NORMAL} Cloning ${GREEN}zsh completions${NORMAL} plugin...\n"
  env git clone https://github.com/zsh-users/zsh-completions.git ~/.oh-my-zsh/custom/plugins/zsh-completions &>/dev/null || {
    printf "${RED}[!] Error: git clone of zsh completions plugin repo failed.${NORMAL} Quitting...\n"
    exit 1
  }

  printf "${GREEN}[+]${NORMAL} Installing ${GREEN}zsh syntax highlighting${NORMAL} plugin...\n"
  if [ $( uname -s ) = "Darwin" ]; then
    brew install zsh-syntax-highlighting || {
      printf "${RED}[!] Error: brew install of zsh-syntax-highlighting failed.${NORMAL} Quitting...\n"
      exit 1
    }
  else
    env git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting &>/dev/null || {
      printf "${RED}[!] Error: git clone of zsh syntax highlighting repo failed.${NORMAL} Quitting...\n"
      exit 1
    }
  fi

  printf "${BLUE}[*] Looking for an existing .dotfiles directory...${NORMAL}\n"
  if [ -d ~/.dotfiles ]; then
    printf "${YELLOW}[!] Found ~/.dotfiles.${NORMAL} ${GREEN}Backing up to ~/.dotfiles.old.pre-dotfiles-install${NORMAL}\n";
    mv ~/.dotfiles ~/.dotfiles.old.pre-dotfiles-install;
  fi
  
  printf "${GREEN}[+]${NORMAL} Cloning ${GREEN}dotfiles${NORMAL}...\n"
  env git clone https://github.com/yugoslavskiy/dotfiles.git ~/.dotfiles >& /dev/null || {
    printf "${RED}[!] Error: git clone of dotfiles repo failed.${NORMAL} Quitting...\n"
    exit 1
  }

  printf "${BLUE}[*] Looking for an existing zsh config...${NORMAL}\n"
  if [ -f ~/.zshrc ] || [ -h ~/.zshrc ]; then
    printf "${YELLOW}[!] Found ~/.zshrc.${NORMAL} ${GREEN}Backing up to ~/.zshrc.old.pre-dotfiles-install${NORMAL}\n";
    mv ~/.zshrc ~/.zshrc.old.pre-dotfiles-install;
  fi

  printf "${GREEN}[+]${NORMAL} Adding ${GREEN}zsh profile${NORMAL} to ~/.zshrc\n"
  cp ~/.dotfiles/"$(uname -s)"/profile/.zshrc ~/.zshrc

  printf "${BLUE}[*] Looking for an existing git config...${NORMAL}\n"
  if [ -f ~/.gitconfig ] || [ -h ~/.gitconfig ]; then
    printf "${YELLOW}[!] Found ~/.gitconfig.${NORMAL} ${GREEN}Backing up to ~/.gitconfig.old.pre-dotfiles-install${NORMAL}\n";
    mv ~/.gitconfig ~/.gitconfig.old.pre-dotfiles-install;
  fi

  printf "${GREEN}[+]${NORMAL} Adding ${GREEN}git config${NORMAL} to ~/.gitconfig\n"
  cp ~/.dotfiles/Common/git/.gitconfig ~/.gitconfig

  printf "${BLUE}[*] Looking for an existing vim_runtime...${NORMAL}\n"
  if [ -d ~/.vim_runtime ]; then
    printf "${YELLOW}[!] Found ~/.vim_runtime.${NORMAL} ${GREEN}Backing up to ~/.vim_runtime.old.pre-dotfiles-install${NORMAL}\n";
    mv ~/.vim_runtime ~/.vim_runtime.old.pre-dotfiles-install;
  fi

  printf "${BLUE}[*] Looking for an existing .vimrc...${NORMAL}\n"
  if [ -f ~/.vimrc ] || [ -h ~/.vimrc ]; then
    printf "${YELLOW}[!] Found ~/.vimrc.${NORMAL} ${GREEN}Backing up to ~/.vimrc.old.pre-dotfiles-install${NORMAL}\n";
    mv ~/.vimrc ~/.vimrc.old.pre-dotfiles-install;
  fi

  printf "${GREEN}[+]${NORMAL} Cloning ${GREEN}amix vimrc${NORMAL}...\n"
  env git clone https://github.com/amix/vimrc.git ~/.vim_runtime >& /dev/null || {
    printf "${RED}[!] Error: git clone of amix vimrc repo failed.${NORMAL} Quitting...\n"
    exit 1
  }

  printf "${GREEN}[+]${NORMAL} Installing ${GREEN}amix vimrc${NORMAL}...\n"
  sh ~/.vim_runtime/install_awesome_vimrc.sh >& /dev/null

  # If this user's login shell is not already "zsh", attempt to switch.
  TEST_CURRENT_SHELL=$(expr "$SHELL" : '.*/\(.*\)')
  if [ "$TEST_CURRENT_SHELL" != "zsh" ]; then
    # If this platform provides a "chsh" command (not Cygwin), do it, man!
    if hash chsh >/dev/null 2>&1; then
      printf "${BLUE}[!] Time to change your default shell to zsh!${NORMAL}\n"
      chsh -s $(grep /zsh$ /etc/shells | tail -1)
    # Else, suggest the user do so manually.
    else
      printf "I can't change your shell automatically because this system does not have chsh.\n"
      printf "${BLUE}Please manually change your default shell to zsh!${NORMAL}\n"
    fi
  fi

  printf "\n${GREEN}[+] Dotfiles successfully installed.${NORMAL}\n"

  exit 0
}

main