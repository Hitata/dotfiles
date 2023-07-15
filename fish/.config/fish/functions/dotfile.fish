function dotfile
  set session dotfile
  tmux has -t $session
  if test $status = 0
    tmux attach -dt $session
  else
    tmux new -s $session -n dotfile_dir -c $DOTFILE_DIR -d
    tmux new-window -n nvim
    tmux send-key -t nvim "cd $NEOVIM_DIR" Enter
    tmux send-key -t nvim vc Enter

    # neww -n fish_config fc \; \
    tmux new-window -n tmux
    tmux send-key -t tmux "cd $TMUX_DIR" Enter
    tmux send-key -t tmux tc Enter

    tmux a
  end
end