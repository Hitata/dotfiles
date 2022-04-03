# How to use this dotfile

## Brewfile
*Edit brewfile to manage installed application in macos*
```
nvim Brewfile
```

*Install application base on what is written in Brewfile*
```
bmake # this is a fish alias
# or
brew bundle --global
```
*Uninstall application base on comment out in brewfile
```
brew bundle cleanup --global
# or to run uninstall
brew bundle cleanup --global --force
```
*Search for installed fonts*
```
brew search font-
```
