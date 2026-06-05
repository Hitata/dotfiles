function tmuxgo -d "Attach to the persistent 'main' tmux session; restore saved layout if it's empty"
  set -l tmux /home/linuxbrew/.linuxbrew/bin/tmux
  set -l restore ~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh

  # Make sure the server + 'main' exist (systemd normally already did this).
  $tmux has-session -t main 2>/dev/null; or $tmux new-session -d -s main

  # If 'main' is just the lone empty window, restore the saved layout first.
  # Runs at attach time (system is calm) — where resurrect restore is reliable.
  if test ($tmux list-windows -t main 2>/dev/null | count) -le 1
    test -e ~/.tmux/resurrect/last; and bash $restore
  end

  $tmux attach -t main
end
