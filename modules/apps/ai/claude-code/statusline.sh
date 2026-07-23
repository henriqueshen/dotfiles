#!/usr/bin/env bash
# Claude Code status line, two rows:
#   repo (branch) │ context gradient bar │ model + effort
#   5h/weekly rate-limit windows with reset times │ cost │ code velocity

input=$(cat)

# ── Colors ──
CYAN='\033[36m'
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
MAGENTA='\033[35m'
DIM='\033[2m'
BOLD='\033[1m'
RESET='\033[0m'
SEP=" ${DIM}│${RESET} "

# ── Truecolor helper ──
rgb() { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }

# ── Parse JSON (single jq call, unit-separator delimited) ──
IFS=$'\x1f' read -r model used cost lines_add lines_del cwd \
  five_pct five_reset week_pct week_reset effort < <(
  jq -r '[
    (.model.display_name // "?"),
    (.context_window.used_percentage // ""),
    (.cost.total_cost_usd // 0),
    (.cost.total_lines_added // 0),
    (.cost.total_lines_removed // 0),
    (.workspace.current_dir // .cwd // ""),
    (.rate_limits.five_hour.used_percentage // ""),
    (.rate_limits.five_hour.resets_at // ""),
    (.rate_limits.seven_day.used_percentage // ""),
    (.rate_limits.seven_day.resets_at // ""),
    (.effort.level // "")
  ] | map(tostring) | join("\u001f")' <<< "$input"
)

# ── Git info ──
branch=""
repo=""
if [ -n "$cwd" ]; then
  branch=$(git -C "$cwd" --no-optional-locks symbolic-ref --short HEAD 2>/dev/null)
  repo=$(basename "$(git -C "$cwd" --no-optional-locks rev-parse --show-toplevel 2>/dev/null)" 2>/dev/null)
fi

# ── Gradient bar: green → yellow → red, dim gray for the unfilled tail ──
gradient_bar() {
  local pct=$1 width=$2
  local filled=$(( (pct * width + 50) / 100 ))
  local bar="" i pos adj r g b
  for (( i = 0; i < width; i++ )); do
    pos=$(( i * 100 / (width - 1) ))
    if [ "$pos" -le 50 ]; then
      r=$(( 220 * pos / 50 )); g=200; b=$(( 80 - 80 * pos / 50 ))
    else
      adj=$(( pos - 50 ))
      r=220; g=$(( 200 - 160 * adj / 50 )); b=$(( 20 * adj / 50 ))
    fi
    if [ "$i" -lt "$filled" ]; then
      bar+="$(rgb "$r" "$g" "$b")█"
    else
      bar+='\033[38;2;60;60;60m░'
    fi
  done
  printf '%s%s' "$bar" "$RESET"
}

pct_color() {
  if [ "$1" -ge 90 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 70 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

# resets_at arrives as epoch seconds; tolerate ISO strings just in case
to_epoch() {
  case $1 in
    '' | null) return 1 ;;
    [0-9]*) printf '%.0f' "$1" ;;
    *) date -d "$1" +%s 2>/dev/null ;;
  esac
}

fmt_countdown() {
  local rem=$(( $1 - $(date +%s) ))
  (( rem < 0 )) && rem=0
  if (( rem >= 86400 )); then printf '%dd%dh' $(( rem / 86400 )) $(( rem % 86400 / 3600 ))
  elif (( rem >= 3600 )); then printf '%dh%02dm' $(( rem / 3600 )) $(( rem % 3600 / 60 ))
  else printf '%dm' $(( rem / 60 )); fi
}

# ── Context bar ──
BAR_WIDTH=20
if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  ctx_part="$(gradient_bar "$used_int" "$BAR_WIDTH") $(pct_color "$used_int")${used_int}%${RESET}"
else
  ctx_part="\033[38;2;60;60;60m░░░░░░░░░░░░░░░░░░░░${RESET} ${DIM}--%${RESET}"
fi

# ── Rate-limit windows (present for subscribers, after first response) ──
limit_part() {
  local label=$1 pct=$2 reset_ts=$3 p epoch out
  p=$(printf '%.0f' "$pct")
  out="${DIM}${label}${RESET} $(gradient_bar "$p" 8) $(pct_color "$p")${p}%${RESET}"
  if epoch=$(to_epoch "$reset_ts"); then
    if [ "$label" = "wk" ]; then
      out="${out} ${DIM}↻$(date -d "@$epoch" +%a)${RESET}"
    else
      out="${out} ${DIM}↻$(fmt_countdown "$epoch")${RESET}"
    fi
  fi
  printf '%s' "$out"
}

usage_parts=""
[ -n "$five_pct" ] && usage_parts="$(limit_part 5h "$five_pct" "$five_reset")"
[ -n "$week_pct" ] && usage_parts="${usage_parts:+$usage_parts$SEP}$(limit_part wk "$week_pct" "$week_reset")"

# ── Cost & code velocity ──
cost_part="${YELLOW}$(printf '$%.2f' "$cost")${RESET}"
velocity="${GREEN}+${lines_add}${RESET} ${RED}-${lines_del}${RESET}"

# ── Line 1: where am I, how full is the context, what model ──
line1=""
[ -n "$repo" ] && line1="${BOLD}${YELLOW}${repo}${RESET}"
[ -n "$branch" ] && line1="${line1:+$line1 }${BOLD}${CYAN}(${branch})${RESET}"
line1="${line1:+$line1$SEP}${ctx_part}"
line1="${line1}${SEP}${MAGENTA}${model}${RESET}"
[ -n "$effort" ] && line1="${line1} ${DIM}·${effort}${RESET}"

# ── Line 2: what am I burning ──
line2="${usage_parts:+$usage_parts$SEP}${cost_part}${SEP}${velocity}"

printf '%b\n%b' "$line1" "$line2"
