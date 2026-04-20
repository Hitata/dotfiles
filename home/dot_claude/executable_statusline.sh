#!/usr/bin/env bash
set -uo pipefail

INPUT=$(cat)
j() { jq -r "$1 // empty" <<< "$INPUT"; }

dim=$'\e[2m'; bold=$'\e[1m'; reset=$'\e[0m'
cyan=$'\e[36m'; yellow=$'\e[33m'; red=$'\e[31m'
green=$'\e[32m'; magenta=$'\e[35m'; blue=$'\e[34m'

pct_color() {
  local p=${1%.*}
  [[ -z "$p" ]] && { printf '%s' "$dim"; return; }
  if   (( p < 50 )); then printf '%s' "$green"
  elif (( p < 80 )); then printf '%s' "$yellow"
  else                    printf '%s' "$red"
  fi
}

sep="${dim}·${reset}"

# ── L1: model · dir · ctx · [style] ⟨agent⟩ ────────────────────────────────
model=$(j '.model.display_name')
cwd=$(j '.workspace.current_dir')
if [[ "$cwd" == "$HOME" ]]; then
  cwd_short="~"
else
  cwd_short=$(basename "$cwd")
fi

ctx_pct=$(j '.context_window.used_percentage')
ctx_in=$(j '.context_window.current_usage.input_tokens')
ctx_cc=$(j '.context_window.current_usage.cache_creation_input_tokens')
ctx_cr=$(j '.context_window.current_usage.cache_read_input_tokens')
style=$(j '.output_style.name')
agent_name=$(j '.agent.name')

line1="${bold}${model}${reset} ${sep} ${cyan}${cwd_short}${reset}"
if [[ -n "$ctx_pct" ]]; then
  tokens=$(( ${ctx_in:-0} + ${ctx_cc:-0} + ${ctx_cr:-0} ))
  tok_k=$(( tokens / 1000 ))
  cc=$(pct_color "$ctx_pct")
  line1+=" ${sep} ctx ${cc}${ctx_pct%.*}%${reset} ${dim}(${tok_k}k)${reset}"
fi
[[ -n "$style" && "$style" != "default" ]] && line1+=" ${sep} ${magenta}[${style}]${reset}"
[[ -n "$agent_name" ]] && line1+=" ${sep} ${magenta}⟨${agent_name}⟩${reset}"

# ── L2: 5h % ↻reset · wk % · $cost ($/h) ───────────────────────────────────
h5_pct=$(j '.rate_limits.five_hour.used_percentage')
h5_reset=$(j '.rate_limits.five_hour.resets_at')
w_pct=$(j '.rate_limits.seven_day.used_percentage')
cost=$(j '.cost.total_cost_usd')
dur_ms=$(j '.cost.total_duration_ms')

line2=""
if [[ -n "$h5_pct" ]]; then
  cc=$(pct_color "$h5_pct")
  line2+="5h ${cc}${h5_pct%.*}%${reset}"
  if [[ -n "$h5_reset" ]]; then
    now=$(date +%s)
    if (( ${h5_reset%.*} > now )); then
      r=$(date -r "${h5_reset%.*}" +"%H:%M" 2>/dev/null)
      [[ -n "$r" ]] && line2+=" ${dim}↻${r}${reset}"
    fi
  fi
fi
if [[ -n "$w_pct" ]]; then
  cc=$(pct_color "$w_pct")
  [[ -n "$line2" ]] && line2+=" ${sep} "
  line2+="wk ${cc}${w_pct%.*}%${reset}"
fi
if [[ -n "$cost" ]] && awk "BEGIN{exit !($cost > 0.005)}"; then
  [[ -n "$line2" ]] && line2+=" ${sep} "
  line2+="\$$(printf '%.2f' "$cost")"
  if [[ -n "$dur_ms" ]] && (( ${dur_ms%.*} > 60000 )); then
    rate=$(awk "BEGIN{printf \"%.2f\", $cost * 3600000 / $dur_ms}")
    line2+=" ${dim}(\$${rate}/h)${reset}"
  fi
fi
[[ -z "$line2" ]] && line2="${dim}(limits populate after first response)${reset}"

# ── L3: ⎇ branch [wt] ✎dirty ↑ahead ↓behind ─────────────────────────────────
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

  line3="${blue}⎇${reset} ${bold}${branch}${reset}"
  [[ -n "$worktree" ]] && line3+=" ${magenta}[wt]${reset}"
  if (( dirty > 0 )); then
    line3+=" ${yellow}✎${dirty}${reset}"
  else
    line3+=" ${green}✓${reset}"
  fi
  (( ${ahead:-0} > 0 ))  && line3+=" ${cyan}↑${ahead}${reset}"
  (( ${behind:-0} > 0 )) && line3+=" ${red}↓${behind}${reset}"
else
  line3="${dim}—${reset}"
fi

printf '%s\n%s\n%s' "$line1" "$line2" "$line3"
