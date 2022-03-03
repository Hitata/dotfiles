function bot
  set_color green; echo -n "\[._.]/ - "
  set_color normal; echo $argv[1]
end

function ok
  set_color green; echo [ok]
end

function running -a text
  set_color yellow; echo -n "[action] "
  set_color normal; echo -n "$text... "
end


