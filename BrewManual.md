# HomeBrew Manual 
Using homebrew with a global `.Brewfile`

## Basic Usage
```
brew bundle --global
```

## Brewfile
*Edit brewfile to manage installed application in macos*
Its located in `~/.Brewfile`

## Dump a file if there isn't one
```
brew bundle dump
```

## Uninstall application base on comment out in brewfile
```
brew bundle cleanup --global
# or to run uninstall
brew bundle cleanup --global --force
```

## Others
### Search for installed fonts*
```
brew search font-
```
### Check any install or need upgrades
```
brew bundle check
```