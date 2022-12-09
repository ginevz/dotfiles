# MacOS Bootstrap

## Step by Step

1. Make sure you are logged into iCloud
2. Install Homebrew `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)”`
3. Install all software (this will take a while) `brew bundle --file=~/Library/Mobile Documents/com~apple`~CloudDocs/Mackup/.Brewfile
4. Restore dotfiles `mackup restore`
5. Set MacOS system settings `source ~/Library/Mobile Documents/com~apple~CloudDocs/Mackup/.macos`
6. Login to 1Password download id_rsa and id_rsa.pub and move them to ~/.ssh/~
7. Also download the GPG public and private keys and import them into the GPG keychain: `gpg --import private.key gpg --import public.key`
8. Test committing, if it fails follow this guide:
    1. `GIT_TRACE=1 git commit -am_`
    2. `echo dummy | gpg -bsau {KEY}`
    3. `enter passphrase`
9. Install all asdf bins
10. Import HC infra access keys (1P vault) to aws-vault keychain: `aws-vault login helecloud-zhu`
