function dev -a folder command
  # private variables
  set -l dir $SITE_DIR/$folder

  if not test -d $dir
    echo "folder not exist in ~/Sites"; return 1
  end

  tmux has -t $folder
  if test $status = 1
    tmux new -s $folder -n $folder -c $dir -d
    tmux neww -n editor -c "#{pane_current_path}" \; send "v" C-m

    if not test -z "$command"
      tmux neww -n runner -c "#{pane_current_path}" \; \
      send $command C-m
    end
  end

  tmux attach -dt $folder
end

