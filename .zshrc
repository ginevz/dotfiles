# Personal Zsh configuration file. It is strongly recommended to keep all
# shell customization and configuration (including exported environment
# variables such as PATH) in this file or in files sourced from it.
#
# Documentation: https://github.com/romkatv/zsh4humans/blob/v5/README.md.

# Periodic auto-update on Zsh startup: 'ask' or 'no'.
# You can manually run `z4h update` to update everything.
zstyle ':z4h:' auto-update      'ask'
# Ask whether to auto-update this often; has no effect if auto-update is 'no'.
zstyle ':z4h:' auto-update-days '28'

# Zsh to use the same colors as ls
# export LS_COLORS="di=34;40:ln=36;40:so=35;40:pi=33;40:ex=32;40:bd=1;33;40:cd=1;33;40:su=0;41:sg=0;43:tw=0;42:ow=34;40:"
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Keyboard type: 'mac' or 'pc'.
zstyle ':z4h:bindkey' keyboard  'mac'

# Don't start tmux.
zstyle ':z4h:' start-tmux       no

# Mark up shell's output with semantic information.
zstyle ':z4h:' term-shell-integration 'yes'

# Right-arrow key accepts one character ('partial-accept') from
# command autosuggestions or the whole thing ('accept')?
zstyle ':z4h:autosuggestions' forward-char 'accept'

# Recursively traverse directories when TAB-completing files.
zstyle ':z4h:fzf-complete' recurse-dirs 'no'

# Enable direnv to automatically source .envrc files.
zstyle ':z4h:direnv'         enable 'yes'
# Show "loading" and "unloading" notifications from direnv.
zstyle ':z4h:direnv:success' notify 'yes'

# Enable ('yes') or disable ('no') automatic teleportation of z4h over
# SSH when connecting to these hosts.
zstyle ':z4h:ssh:example-hostname1'   enable 'yes'
zstyle ':z4h:ssh:*.example-hostname2' enable 'no'
# The default value if none of the overrides above match the hostname.
zstyle ':z4h:ssh:*'                   enable 'no'

# Send these files over to the remote host when connecting over SSH to the
# enabled hosts.
zstyle ':z4h:ssh:*' send-extra-files '~/.nanorc' '~/.env.zsh'

# Clone additional Git repositories from GitHub.
#
# This doesn't do anything apart from cloning the repository and keeping it
# up-to-date. Cloned files can be used after `z4h init`. This is just an
# example. If you don't plan to use Oh My Zsh, delete this line.
z4h install ohmyzsh/ohmyzsh || return

# Install or update core components (fzf, zsh-autosuggestions, etc.) and
# initialize Zsh. After this point console I/O is unavailable until Zsh
# is fully initialized. Everything that requires user interaction or can
# perform network I/O must be done above. Everything else is best done below.
z4h init || return

# Extend PATH.
path=(~/bin $path)

# Export environment variables.

# Source additional local files if they exist.
z4h source ~/.env.zsh
z4h source ~/.alias.zsh

# Use additional Git repositories pulled in with `z4h install`.
#
# This is just an example that you should delete. It does nothing useful.
# z4h load ohmyzsh/ohmyzsh/plugins/aws  # load a plugin

# Define key bindings.
z4h bindkey undo Ctrl+/   Shift+Tab  # undo the last command line change
z4h bindkey redo Option+/            # redo the last undone command line change

z4h bindkey z4h-cd-back    Shift+Left   # cd into the previous directory
z4h bindkey z4h-cd-forward Shift+Right  # cd into the next directory
z4h bindkey z4h-cd-up      Shift+Up     # cd into the parent directory
z4h bindkey z4h-cd-down    Shift+Down   # cd into a child directory

# Autoload functions.
autoload -Uz zmv

# Define functions and completions.
function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

# Define named directories: ~w <=> Windows home directory on WSL.
# [[ -z $z4h_win_home ]] || hash -d w=$z4h_win_home

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu

# Vi mode settings
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

source <(kubectl completion zsh)

# ASDF Required config
source $(brew --prefix asdf)/libexec/asdf.sh

# Enable fuzzy search for loading AWS Profiles
source ~/.aws/fzf_zsh_aws_profile

# asdf all in package installation
aai() {
  echo "Adding $1 plugin..."
  asdf plugin add $1 2>/dev/null
  if [[ "$#" -eq 1 ]]
  then
      read "continue?Only one argument passed. Press y to continue with LATEST version, n to select a new version, or exit to exit. "
      case $continue in
      y)
          echo -n "Continuing with LATEST version.\n"
          asdf install $1 latest
          asdf global $1 latest
          echo "$1 $2 configured on the system successfully."
          ;;
      n)
          echo -n "Printing all $1 versions..."
          asdf list all $1
          read "version?Select a version from the printed list: "
          asdf install $1 $version
          asdf global $1 $version
          echo "$1 $2 configured on the system successfully."
          ;;
      *)
          echo -n "Exiting script.."
      esac
  elif [[ "$#" -eq 2 ]]
  then
      read "continue?The requested $1 version is $2. Press y to confirm, n to select a new version, or exit to exit. "
      case $continue in
      y)
          echo -n "Continuing with $2 version...\n"
          asdf install $1 $2
          asdf global $1 $2
          echo "$1 $2 configured on the system successfully."
          ;;
      n)
          echo -n "Printing all $1 versions..."
          asdf list all $1
          read "version?Select a version from the printed list: "
          asdf install $1 $version
          asdf global $1 $version
          echo "$1 $2 configured on the system successfully."
          ;;
      *)
          echo -n "Exiting script.."
      esac
  else
    echo "usage: aai <name> <version>. Version defaults to latest. Type apla to see all plugins."
  fi
}
