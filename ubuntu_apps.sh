
## install essential
sudo apt update
sudo apt install curl -y
sudo apt install git
# ssh-keygen -t ed25519 -C "email..."

## dotfile config
sudo apt install stow

## coding editor
sudo snap install --classic code

## install node and pnpm
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