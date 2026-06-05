function tmuxgo -d "Attach to the persistent 'main' tmux session (create if missing)"
  tmux new-session -A -s main
end
