# Define aliases.
alias tree='tree -a -I .git'

# Add flags to existing aliases.
# alias ls="${aliases[ls]:-ls} -A"
alias ls='lsd'
alias ll='ls -la'
alias lst='ls --tree'
alias cat='bat'
alias vim='nvim'
alias vi='nvim'
alias sgp='git-profile use'
alias ports='lsof -nPi -sTCP:LISTEN'
alias flushdns='sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder'

# Terraform
alias tf='terraform'
alias tfa='terraform apply'
alias tfd='terraform destroy'
alias tff='terraform fmt'
alias tfi='terraform init'
alias tfo='terraform output'
alias tfp='terraform plan'
alias tfv='terraform validate'
alias tfc='terraform console'

# Git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit -a -m'
alias gcb='git checkout -b'
alias gpristine='git reset --hard && git clean -dffx'
alias gco="git checkout"
alias gl='git pull'
alias gp='git push'
alias gm='git merge'
alias gr='git reset'
alias grh='git reset --hard'
alias gst='git status'
alias gsu='git submodule update --init --recursive --jobs 8'

# asdf
alias a='asdf'
alias apl='asdf plugin list'
alias apla='asdf plugin list all'
alias apa='asdf plugin add'
alias apr='asdf plugin remove'
alias al='asdf local'
alias ag='asdf global'
alias ar='asdf reshim'
alias ai='asdf install'
alias au='asdf uninstall'
alias au='asdf uninstall'
alias ac='asdf current'
