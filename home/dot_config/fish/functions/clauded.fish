function clauded --description 'Clear, launch Claude (dangerous perms) with Remote Control session prefix "assist"'
    clear
    claude --dangerously-skip-permissions --remote-control-session-name-prefix assist $argv
end
