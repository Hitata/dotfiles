#!/usr/bin/env bash
# Restore the saved tmux 'main' session at boot, once the server is up.
#
# The hard bug was NOT here: tmux.service used Type=forking, so systemd tracked
# the wrong PID and tore the whole server down the moment restore.sh juggled
# sessions ("server exited unexpectedly"). With tmux.service now Type=oneshot +
# RemainAfterExit, the server is stable and restore just works. This script
# only needs to wait for the server, then run restore (with a couple of retries
# for any transient boot churn). Single restorer — continuum @continuum-restore
# is off. Ghostty does not autostart; the user attaches manually.
set -u

TMUX_BIN=/home/linuxbrew/.linuxbrew/bin/tmux
RESTORE=/home/ze-tank/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
LOG=/home/ze-tank/.tmux/resurrect/boot-restore.log

log() { echo "$(date '+%F %T') $*" >>"$LOG" 2>/dev/null; }
win_count() { $TMUX_BIN list-windows -t main 2>/dev/null | wc -l; }

log "=== boot-restore start ==="

# Wait (<=60s) for the server to be up and 'main' to exist.
for _ in $(seq 1 60); do
	$TMUX_BIN has-session -t main 2>/dev/null && break
	sleep 1
done
if ! $TMUX_BIN has-session -t main 2>/dev/null; then
	log "no 'main' session after 60s, abort"
	exit 0
fi

# Don't clobber an already-populated session.
if [ "$(win_count)" -gt 1 ]; then
	log "already populated ($(win_count) windows), nothing to do"
	exit 0
fi

# Restore, with a few retries for transient boot churn.
for attempt in 1 2 3 4 5; do
	log "restore attempt $attempt"
	bash "$RESTORE" >>"$LOG" 2>&1
	sleep 3
	wins=$(win_count)
	log "after attempt $attempt windows=$wins"
	if [ "${wins:-0}" -gt 1 ]; then
		log "restore OK ($wins windows)"
		exit 0
	fi
	sleep 3
done

log "restore FAILED after 5 attempts"
exit 0
