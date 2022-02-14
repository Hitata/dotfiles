function dotfile
  set session dotfile
  tmux has -t $session
  if test $status = 0
    tmux attach -dt $session
  else
    tmux new -s $session -n dotfile_dir -c $DOTFILE_DIR \; \
    neww -n fish_config fc \; \
    neww -n nvim_config vc \; \
    neww -n tmux_config tc
  end
end
