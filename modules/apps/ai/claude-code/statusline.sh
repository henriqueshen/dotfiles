#!/usr/bin/env bash
# Claude Code status line, two rows:
#   repo (branch) │ model + effort │ cost │ code velocity │ session duration
#   ctx / 5h / weekly gradient meters, equal width, with reset times

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
GRAY='\033[38;2;60;60;60m'
SEP=" ${DIM}│${RESET} "

# ── Truecolor helper ──
rgb() { printf '\033[38;2;%d;%d;%dm' "$1" "$2" "$3"; }

# ── Parse JSON (single jq call, unit-separator delimited) ──
IFS=$'\x1f' read -r model used cost lines_add lines_del cwd \
  five_pct five_reset week_pct week_reset effort dur_ms < <(
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
    (.effort.level // ""),
    (.cost.total_duration_ms // 0)
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
BAR_WIDTH=12

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
      bar+="${GRAY}░"
    fi
  done
  printf '%s%s' "$bar" "$RESET"
}

pct_color() {
  if [ "$1" -ge 90 ]; then printf '%s' "$RED"
  elif [ "$1" -ge 70 ]; then printf '%s' "$YELLOW"
  else printf '%s' "$GREEN"; fi
}

# One meter: dim label, gradient bar, right-aligned %, optional dim suffix
meter() {
  local label=$1 pct=$2 suffix=$3 p
  p=$(printf '%.0f' "$pct")
  printf '%s' "${DIM}${label}${RESET} $(gradient_bar "$p" "$BAR_WIDTH") $(pct_color "$p")$(printf '%3d' "$p")%${RESET}${suffix:+ ${DIM}${suffix}${RESET}}"
}

empty_meter() {
  local label=$1 bar="" i
  for (( i = 0; i < BAR_WIDTH; i++ )); do bar+="${GRAY}░"; done
  printf '%s' "${DIM}${label}${RESET} ${bar}${RESET} ${DIM} --%${RESET}"
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

fmt_duration() {
  local mins=$(( $1 / 60000 ))
  if (( mins >= 60 )); then printf '%dh%02dm' $(( mins / 60 )) $(( mins % 60 ))
  else printf '%dm' "$mins"; fi
}

reset_hint() {  # label reset_ts
  local epoch
  if epoch=$(to_epoch "$2"); then
    if [ "$1" = "wk" ]; then printf '↻%s' "$(date -d "@$epoch" +%a)"
    else printf '↻%s' "$(fmt_countdown "$epoch")"; fi
  fi
}

# ── Line 1: where, what model, what it cost ──
line1=""
[ -n "$repo" ] && line1="${BOLD}${YELLOW}${repo}${RESET}"
[ -n "$branch" ] && line1="${line1:+$line1 }${BOLD}${CYAN}(${branch})${RESET}"
line1="${line1:+$line1$SEP}${MAGENTA}${model}${RESET}"
[ -n "$effort" ] && line1="${line1} ${DIM}·${effort}${RESET}"
line1="${line1}${SEP}${YELLOW}$(printf '$%.2f' "$cost")${RESET}"
line1="${line1}${SEP}${GREEN}+${lines_add}${RESET} ${RED}-${lines_del}${RESET}"
line1="${line1}${SEP}${DIM}$(fmt_duration "$dur_ms")${RESET}"

# ── Line 2: the meters — context, 5h window, weekly window ──
if [ -n "$used" ]; then
  line2="$(meter ctx "$used" "")"
else
  line2="$(empty_meter ctx)"
fi

[ -n "$five_pct" ] && line2="${line2}${SEP}$(meter " 5h" "$five_pct" "$(reset_hint 5h "$five_reset")")"
[ -n "$week_pct" ] && line2="${line2}${SEP}$(meter " wk" "$week_pct" "$(reset_hint wk "$week_reset")")"

printf '%b\n%b' "$line1" "$line2"
