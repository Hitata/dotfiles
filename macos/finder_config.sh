#!/usr/bin/env fish

function ok
  set_color green; echo [ok]
end

function running -a text
  set_color yellow; echo -n "[action] "
  set_color normal; echo -n "$text... "
end

# Set search scope.
# This Mac       : `SCev`
# Current Folder : `SCcf`
# Previous Scope : `SCsp`
running "Set Default search scope to Current Folder"
defaults write com.apple.finder FXDefaultSearchScope SCcf;ok

# Set preferred view style.
# Icon View   : `icnv`
# List View   : `Nlsv`
# Column View : `clmv`
# Cover Flow  : `Flwv`
running "Set Preferred view style to Column View"
defaults write com.apple.finder FXPreferredViewStyle clmv;ok
rm -rf ~/.DS_Store

# Set default path for new windows.
# Computer     : `PfCm`
# Volume       : `PfVo`
# $HOME        : `PfHm`
# Desktop      : `PfDe`
# Documents    : `PfDo`
# All My Files : `PfAF`
# Other…       : `PfLo`
running "Set Desktop as the default location for new Finder windows"
# For other paths, use 'PfLo' and 'file://localhost/Users/hit/Sites/'
defaults write com.apple.finder NewWindowTarget -string "PfDe";ok
# defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/";ok

running "Show hidden files by default"
defaults write com.apple.finder AppleShowAllFiles -bool true;ok

running "Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true;ok

running "Show path bar"
defaults write com.apple.finder ShowPathbar -bool true;ok

killall Finder

