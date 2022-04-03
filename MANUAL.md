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
brew bundle
```
*Uninstall application base on comment out in brewfile
```
brew bundle cleanup
```
*Search for installed fonts*
```
brew search font-
```
