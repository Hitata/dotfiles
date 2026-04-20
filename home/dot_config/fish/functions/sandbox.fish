function sandbox
  set dir ~/Sites/sandbox
  set session sandbox
  tmux has -t $session
  if test $status = 0
    tmux attach -dt $session
  else
    tmux new -s $session -n sandbox -c $dir
  end
  echo $status
end
