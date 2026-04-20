#!/usr/bin/env bash
set -uo pipefail

INPUT=$(cat)
j() { jq -r "$1 // empty" <<< "$INPUT"; }

c_model=$'\e[1;38;5;117m'
c_dir=$'\e[38;5;180m'
c_dim=$'\e[38;5;245m'
c_off=$'\e[38;5;238m'
c_good=$'\e[38;5;108m'
c_warn=$'\e[38;5;179m'
c_bad=$'\e[38;5;203m'
c_cost=$'\e[38;5;215m'
c_branch=$'\e[1;38;5;252m'
c_up=$'\e[38;5;117m'
c_down=$'\e[38;5;203m'
c_accent=$'\e[38;5;141m'
rst=$'\e[0m'

sym_l1="✦"
sym_l2="◇"
sym_l3="⎇"

pct_color() {
  local p=${1%.*}
  [[ -z "$p" ]] && { printf '%s' "$c_dim"; return; }
  if   (( p < 50 )); then printf '%s' "$c_good"
  elif (( p < 80 )); then printf '%s' "$c_warn"
  else                    printf '%s' "$c_bad"
  fi
}

bar() {
  local pct=${1%.*} color="$2" width=10
  [[ -z "$pct" ]] && pct=0
  (( pct > 100 )) && pct=100
  local ticks=$(( (pct * width * 8 + 50) / 100 ))
  local full=$(( ticks / 8 ))
  local frac=$(( ticks % 8 ))
  local eighths=('' '▏' '▎' '▍' '▌' '▋' '▊' '▉')
  local out="" emp=""
  local i
  for (( i=0; i<full; i++ )); do out+='█'; done
  (( frac > 0 )) && out+="${eighths[$frac]}"
  local used=$(( full + (frac > 0 ? 1 : 0) ))
  local empty=$(( width - used ))
  for (( i=0; i<empty; i++ )); do emp+='░'; done
  printf '%s%s%s%s%s' "$color" "$out" "$c_off" "$emp" "$rst"
}

# ── L1 ─────────────────────────────────────────────────────────────────────
model=$(j '.model.display_name')
cwd=$(j '.workspace.current_dir')
if [[ "$cwd" == "$HOME" ]]; then
  dir_disp="~"
else
  dir_disp=$(basename "$cwd")
fi

ctx_pct=$(j '.context_window.used_percentage')
ctx_in=$(j '.context_window.current_usage.input_tokens')
ctx_cc=$(j '.context_window.current_usage.cache_creation_input_tokens')
ctx_cr=$(j '.context_window.current_usage.cache_read_input_tokens')
style=$(j '.output_style.name')
agent_name=$(j '.agent.name')

line1="${c_dim}${sym_l1}${rst}  ${c_model}${model}${rst}   ${c_dir}${dir_disp}${rst}"
if [[ -n "$ctx_pct" ]]; then
  tokens=$(( ${ctx_in:-0} + ${ctx_cc:-0} + ${ctx_cr:-0} ))
  tok_k=$(( tokens / 1000 ))
  cc=$(pct_color "$ctx_pct")
  line1+="   $(bar "$ctx_pct" "$cc") ${cc}${ctx_pct%.*}%${rst} ${c_dim}(${tok_k}k)${rst}"
fi
[[ -n "$style" && "$style" != "default" ]] && line1+="   ${c_accent}[${style}]${rst}"
[[ -n "$agent_name" ]] && line1+="   ${c_accent}⟨${agent_name}⟩${rst}"

# ── L2 ─────────────────────────────────────────────────────────────────────
h5_pct=$(j '.rate_limits.five_hour.used_percentage')
h5_reset=$(j '.rate_limits.five_hour.resets_at')
w_pct=$(j '.rate_limits.seven_day.used_percentage')
cost=$(j '.cost.total_cost_usd')
dur_ms=$(j '.cost.total_duration_ms')

part2=""
if [[ -n "$h5_pct" ]]; then
  cc=$(pct_color "$h5_pct")
  part2+="${c_dim}5h${rst} $(bar "$h5_pct" "$cc") ${cc}${h5_pct%.*}%${rst}"
  if [[ -n "$h5_reset" ]]; then
    now=$(date +%s)
    if (( ${h5_reset%.*} > now )); then
      r=$(date -r "${h5_reset%.*}" +"%H:%M" 2>/dev/null)
      [[ -n "$r" ]] && part2+=" ${c_dim}↻${r}${rst}"
    fi
  fi
fi
if [[ -n "$w_pct" ]]; then
  cc=$(pct_color "$w_pct")
  [[ -n "$part2" ]] && part2+="   "
  part2+="${c_dim}wk${rst} ${cc}${w_pct%.*}%${rst}"
fi
if [[ -n "$cost" ]] && awk "BEGIN{exit !($cost > 0.005)}"; then
  [[ -n "$part2" ]] && part2+="   "
  part2+="${c_cost}\$$(printf '%.2f' "$cost")${rst}"
  if [[ -n "$dur_ms" ]] && (( ${dur_ms%.*} > 60000 )); then
    rate=$(awk "BEGIN{printf \"%.2f\", $cost * 3600000 / $dur_ms}")
    part2+=" ${c_dim}\$${rate}/h${rst}"
  fi
fi

if [[ -z "$part2" ]]; then
  line2="${c_dim}${sym_l2}  awaiting first response${rst}"
else
  line2="${c_dim}${sym_l2}${rst}  ${part2}"
fi

# ── L3 ─────────────────────────────────────────────────────────────────────
line3=""
if [[ -d "$cwd" ]] && git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" branch --show-current 2>/dev/null)
  [[ -z "$branch" ]] && branch=$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null || echo "?")
  dirty=$(git -C "$cwd" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  ahead=0; behind=0
  if upstream=$(git -C "$cwd" rev-parse --abbrev-ref '@{upstream}' 2>/dev/null); then
    read -r ahead behind < <(git -C "$cwd" rev-list --left-right --count "HEAD...$upstream" 2>/dev/null | awk '{print $1, $2}')
  fi
  worktree=$(j '.workspace.git_worktree')

  line3="${c_dim}${sym_l3}${rst}  ${c_branch}${branch}${rst}"
  [[ -n "$worktree" ]] && line3+=" ${c_accent}[wt]${rst}"
  if (( dirty > 0 )); then
    line3+="   ${c_warn}✎${dirty}${rst}"
  else
    line3+="   ${c_good}✓${rst}"
  fi
  (( ${ahead:-0} > 0 ))  && line3+="   ${c_up}↑${ahead}${rst}"
  (( ${behind:-0} > 0 )) && line3+=" ${c_down}↓${behind}${rst}"
else
  line3="${c_dim}${sym_l3}  —${rst}"
fi

printf '%s\n%s\n%s' "$line1" "$line2" "$line3"
