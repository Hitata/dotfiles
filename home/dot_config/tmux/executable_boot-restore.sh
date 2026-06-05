#!/usr/bin/env bash
# Restore the saved tmux 'main' session ONCE THE BOOT STORM HAS PASSED.
#
# Root cause this guards against: tmux-resurrect's restore.sh fires ~30 rapid
# new-window/split-window/display-message calls. During the boot storm (GNOME,
# Ghostty, services all starting; load average > 2) those spawns fail and
# cascade ("server exited unexpectedly", restore.sh:155 unary error), aborting
# to a single empty window. The very same restore succeeds reliably once the
# system is calm. So: wait for calm, THEN restore, with patient retries.
#
# This is the ONLY restorer (continuum @continuum-restore is off). The tmux
# server itself is brought up separately by tmux.service; Ghostty only attaches.
set -u

TMUX_BIN=/home/linuxbrew/.linuxbrew/bin/tmux
RESTORE=/home/ze-tank/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
LOG=/home/ze-tank/.tmux/resurrect/boot-restore.log

log() { echo "$(date '+%F %T') $*" >>"$LOG" 2>/dev/null; }
win_count() { $TMUX_BIN list-windows -t main 2>/dev/null | wc -l; }
load1() { awk '{print $1}' /proc/loadavg; }            # 1-min load average
load_ok() { awk '{exit !($1 < 1.5)}' /proc/loadavg; }  # true when load < 1.5

log "=== boot-restore start (load=$(load1)) ==="

# 1. Wait (<=60s) until the server answers and 'main' exists.
for _ in $(seq 1 60); do
	$TMUX_BIN has-session -t main 2>/dev/null && break
	sleep 1
done
if ! $TMUX_BIN has-session -t main 2>/dev/null; then
	log "no 'main' session after 60s, abort"
	exit 0
fi

# 2. Don't clobber an already-populated session (>=2 windows).
if [ "$(win_count)" -gt 1 ]; then
	log "already populated ($(win_count) windows), nothing to do"
	exit 0
fi

# 3. Wait for the boot storm to pass: load average < 1.5, or a 150s hard cap.
for _ in $(seq 1 150); do
	load_ok && break
	sleep 1
done
log "storm settled (load=$(load1)), restoring"
sleep 2

# 4. Restore, retrying patiently (covers any residual churn). Stop as soon as
#    'main' has more than the lone empty window.
for attempt in $(seq 1 10); do
	log "restore attempt $attempt (load=$(load1))"
	bash "$RESTORE" >>"$LOG" 2>&1
	sleep 3
	wins=$(win_count)
	log "after attempt $attempt windows=$wins"
	if [ "${wins:-0}" -gt 1 ]; then
		log "restore OK ($wins windows)"
		exit 0
	fi
	sleep 5
done

log "restore FAILED after 10 attempts (load=$(load1))"
exit 0
