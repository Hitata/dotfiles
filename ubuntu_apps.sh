sudo apt update

## 1. setup dotfile
ssh-keygen -t ed25519 -C "email..."
cat ~/.ssh/id.pub
### go to github keys add sshkey
https://github.com/settings/keys

sudo apt install git
git clone git@github.com:Hitata/dotfiles.git

## 2. fix keyboard default
sudo vi /etc/default/keyboard
add
```
XKBOPTIONS="ctrl:nocaps"
```
sudo dpkg-reconfigure keyboard-configuration

## dotfile config
sudo apt install stow

## coding editor
sudo snap install --classic code

## install node and pnpm
sudo apt install curl -y
curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
sudo apt-get install -y nodejs
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.bashrc

## install other
sudo snap install telegram-desktop
sudo apt install steam
sudo apt install brave-browser

## work
sudo snap install slack


## miscellaneous
sudo apt install usb-creator-gtk 