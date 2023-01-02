# Things to do after a fresh install of Tumbleweed
To shape a pleasant dev environment on OpenSUSE Tumbleweed. What I need are
- Fonts displayed correctly and nicely. My eyes are picky.
- Virtual machine and container. They make me capable of experimenting different things, as well as keeping my OS installation clean over time.
- Development tools are in place. I do mostly Python, .NET Core, and C++. However, Golang, Rust, and even C have good shares of my time.
- All of these needs should be addressed with as little changes as possible on root filesystem. I admire the mindset behind Fedora Kinoite and Opensuse MicroOS.

## Installation
To enable LUKS2 support, press `e` on boot screen, add the following boot option
```
    YAST_LUKS2_AVAILABE=1
```
As LUKS2 support on GRUB is at its early phase (), to encrypt `/boot` with LUKS2 is not a reliable option.
To ease my paranoid brain, I use the following setup
```
    /dev/xx1    /boot/efi   512MiB  FAT     unencrypted
    /dev/xx2    /boot       2GiB    BTRFS   LUKS1 (password decryption)
    /dev/xx3                        LVM2    LUKS2 (FIDO2 decryption)
```
After installation, I add Yubikey as the FIDO2 to LUKS2 keyslot following [these steps](https://en.opensuse.org/SDB:LUKS2,_TPM2_and_FIDO2)

## Fonts
As a Vietnamese, I find Google's Noto satisfying enough as a desktop font. Occasionally I read Japanese, but even so I want full coverage on CJK.
Finally, the little square boxes just upset me as a bowl of noodle without spring onion. So, full set of Noto as desktop font. Story ends.
```
    sudo zypper in noto-fonts google-noto-{sans,serif}-{tc,sc,hk,jp,kr}-fonts-full
```
It takes less than 2GiB to make my eyes happy, why not?

## Input method
Again as a Vietnamese, I couldn't live without Unikey. Sometimes I type Japanese, and once in a bluemoon Chinese, to joke with my buddies. `fcitx` is my weapon of choice, so
```
    sudo zypper in fcitx-unikey fcitx-mozc fcitx-rime
```
Some would prefer Google Pinyin, but for the handful of Chinese characters I know, Rime is more than enough :)

## Virtualization and containerization
First, KVM, no doubt
```
    sudo zypper in -t pattern kvm_server kvm_tools
    sudo systemctl enable libvirtd
```
Then, `podman` as a replacement to `docker`, and `toolbox` as a nice development environment isolation.
```
    sudo zypper in podman podman-compose toolbox
```

## 4. Shell
Get `zsh`. I find it better than `bash`
```
    sudo zypper in zsh
```
Get the `starship`. I used to have `oh-my-zsh` installed, but then I find it way more sophisticated than what I need. So
```
    curl -sS https://starship.rs/install.sh | sh
```
my `.zshrc` looks like
```
# antigen
source $HOME/.local/bin/antigen.zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-history-substring-search

antigen apply

# history
export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=1000000
export SAVEHIST=1000000

setopt    extended_history      # Record timestamp of command in HISTFILE
setopt    appendhistory         # Append history to the history file (no overwriting)
setopt    sharehistory          # Share history across terminals
setopt    incappendhistory      # Immediately append to the history file, not just when a term is killed

# starship prompt
eval "$(starship init zsh)"
```

## Python Development
`pyenv`, no doubt. First, get the dependencies to build Python
```
    sudo zypper install gcc automake bzip2 libbz2-devel xz xz-devel openssl-devel ncurses-devel \
        readline-devel zlib-devel tk-devel libffi-devel sqlite3-devel libgdbm-devel make
```
Then, get the `pyenv`
```
    curl https://pyenv.run | bash
```
do what they said when `zsh` is my shell
```
    echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
    echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(pyenv init -)"' >> ~/.zshrc
```

## .NET Development
I use .NET Core only for backend development. I don't find it necessary to install it on root filesystem.
```
    wget https://dot.net/v1/dotnet-install.sh
    chmod +x dotnet-install.sh
    ./dotnet-install.sh 
```
Add dotnet to `PATH` on `.zshenv`
```
export PATH="$PATH:$HOME/.dotnet"
```
test
```
~ 
❯ dotnet

Usage: dotnet [options]
Usage: dotnet [path-to-application]

Options:
  -h|--help         Display help.
  --info            Display .NET information.
  --list-sdks       Display the installed SDKs.
  --list-runtimes   Display the installed runtimes.

path-to-application:
  The path to an application .dll file to execute.
```

