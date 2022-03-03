#!/usr/bin/env fish

function bot
  set_color green; echo -n "\[._.]/ - "
  set_color normal; echo $argv[1]
end

bot "Setting up prefered finder config"
source macos/finder_config.sh
