function mkcd --description 'mkdir and cd into a folder' -a folder
  mkdir -p -- $folder && cd -- $folder
end
