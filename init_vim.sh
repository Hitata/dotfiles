#!/bin/bash

CWD=$(pwd)

nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
nvim +PlugInstall +qall

cd $CWD
