#!/usr/bin/env bash
# Claude Code status line: displays every field from the stdin JSON payload.
set -euo pipefail

input=$(cat)

get() {
  jq -r "$1 // empty" <<<"$input"
}

# Colors (dimmed to match the terminal's status line rendering).
DIM='\033[2m'
RESET='\033[0m'
CYAN='\033[2;36m'
YELLOW='\033[2;33m'
GREEN='\033[2;32m'
MAGENTA='\033[2;35m'
BLUE='\033[2;34m'
RED='\033[2;31m'
GRAY='\033[2;37m'

session_id=$(get '.session_id')
session_name=$(get '.session_name')
prompt_id=$(get '.prompt_id')
transcript_path=$(get '.transcript_path')
cwd=$(get '.cwd')
version=$(get '.version')
output_style=$(get '.output_style.name')

model_id=$(get '.model.id')
model_display=$(get '.model.display_name')

ws_current_dir=$(get '.workspace.current_dir')
ws_project_dir=$(get '.workspace.project_dir')
ws_added_dirs=$(jq -r '.workspace.added_dirs // [] | join(", ")' <<<"$input")
ws_worktree=$(get '.workspace.git_worktree')
repo_host=$(get '.workspace.repo.host')
repo_owner=$(get '.workspace.repo.owner')
repo_name=$(get '.workspace.repo.name')

cw_total_input=$(get '.context_window.total_input_tokens')
cw_total_output=$(get '.context_window.total_output_tokens')
cw_size=$(get '.context_window.context_window_size')
cw_used_pct=$(get '.context_window.used_percentage')
cw_remaining_pct=$(get '.context_window.remaining_percentage')
cu_input=$(get '.context_window.current_usage.input_tokens')
cu_output=$(get '.context_window.current_usage.output_tokens')
cu_cache_create=$(get '.context_window.current_usage.cache_creation_input_tokens')
cu_cache_read=$(get '.context_window.current_usage.cache_read_input_tokens')

effort_level=$(get '.effort.level')
thinking_enabled=$(get '.thinking.enabled')

rl_5h_pct=$(get '.rate_limits.five_hour.used_percentage')
rl_5h_resets=$(get '.rate_limits.five_hour.resets_at')
rl_7d_pct=$(get '.rate_limits.seven_day.used_percentage')
rl_7d_resets=$(get '.rate_limits.seven_day.resets_at')

vim_mode=$(get '.vim.mode')

agent_name=$(get '.agent.name')
agent_type=$(get '.agent.type')

pr_number=$(get '.pr.number')
pr_url=$(get '.pr.url')
pr_state=$(get '.pr.review_state')

wt_name=$(get '.worktree.name')
wt_path=$(get '.worktree.path')
wt_branch=$(get '.worktree.branch')
wt_original_cwd=$(get '.worktree.original_cwd')
wt_original_branch=$(get '.worktree.original_branch')

fmt_epoch() {
  [ -n "$1" ] && date -d "@$1" "+%Y-%m-%d %H:%M:%S" 2>/dev/null || echo "$1"
}

line1="${CYAN}${model_display:-$model_id}${RESET}"
[ -n "$model_id" ] && [ "$model_id" != "$model_display" ] && line1+=" ${GRAY}(${model_id})${RESET}"
[ -n "$version" ] && line1+=" ${GRAY}v${version}${RESET}"
[ -n "$output_style" ] && line1+=" ${GRAY}[${output_style}]${RESET}"
[ -n "$effort_level" ] && line1+=" ${GRAY}effort:${effort_level}${RESET}"
[ "$thinking_enabled" = "true" ] && line1+=" ${GRAY}thinking:on${RESET}"
[ -n "$vim_mode" ] && line1+=" ${YELLOW}[${vim_mode}]${RESET}"
[ -n "$agent_name" ] && line1+=" ${MAGENTA}agent:${agent_name}${RESET}"
[ -n "$agent_type" ] && line1+=" ${GRAY}(${agent_type})${RESET}"

line2="${GREEN}${cwd}${RESET}"
[ -n "$ws_worktree" ] && line2+=" ${GRAY}worktree:${ws_worktree}${RESET}"
[ -n "$ws_added_dirs" ] && line2+=" ${GRAY}+[${ws_added_dirs}]${RESET}"

line3=""
if [ -n "$repo_owner" ] && [ -n "$repo_name" ]; then
  line3="${BLUE}${repo_owner}/${repo_name}${RESET}"
  [ -n "$repo_host" ] && line3+=" ${GRAY}(${repo_host})${RESET}"
fi
if [ -n "$pr_number" ]; then
  [ -n "$line3" ] && line3+="  "
  line3+="${MAGENTA}PR #${pr_number}${RESET}"
  [ -n "$pr_state" ] && line3+=" ${GRAY}(${pr_state})${RESET}"
fi
if [ -n "$wt_name" ]; then
  [ -n "$line3" ] && line3+="  "
  line3+="${YELLOW}worktree:${wt_name}${RESET}"
  [ -n "$wt_branch" ] && line3+=" ${GRAY}[${wt_branch}]${RESET}"
fi

line4=""
if [ -n "$cw_used_pct" ]; then
  line4="${CYAN}context: ${cw_used_pct}%% used / ${cw_remaining_pct}%% left${RESET}"
  line4+=" ${GRAY}(${cw_total_input:-0}in+${cw_total_output:-0}out / ${cw_size} window)${RESET}"
fi

line5=""
if [ -n "$rl_5h_pct" ] || [ -n "$rl_7d_pct" ]; then
  line5="${RED}limits:${RESET}"
  [ -n "$rl_5h_pct" ] && line5+=" ${RED}5h $(printf '%.0f' "$rl_5h_pct")%% (resets $(fmt_epoch "$rl_5h_resets"))${RESET}"
  [ -n "$rl_7d_pct" ] && line5+=" ${RED}7d $(printf '%.0f' "$rl_7d_pct")%% (resets $(fmt_epoch "$rl_7d_resets"))${RESET}"
fi

line6="${GRAY}session:${session_id}${RESET}"
[ -n "$session_name" ] && line6+=" ${GRAY}name:${session_name}${RESET}"
[ -n "$prompt_id" ] && line6+=" ${GRAY}prompt:${prompt_id}${RESET}"

line7="${GRAY}transcript:${transcript_path}${RESET}"

line8="${GRAY}project_dir:${ws_project_dir}${RESET}"

line9=""
if [ -n "$cu_input" ]; then
  line9="${GRAY}usage(last call): in=${cu_input} out=${cu_output} cache_write=${cu_cache_create} cache_read=${cu_cache_read}${RESET}"
fi

line10=""
if [ -n "$wt_original_cwd" ]; then
  line10="${GRAY}worktree_from:${wt_original_cwd}"
  [ -n "$wt_original_branch" ] && line10+=" (${wt_original_branch})"
  line10+="${RESET}"
fi

printf '%b\n' "$line1"
printf '%b\n' "$line2"
[ -n "$line3" ] && printf '%b\n' "$line3"
[ -n "$line4" ] && printf '%b\n' "$line4"
[ -n "$line5" ] && printf '%b\n' "$line5"
printf '%b\n' "$line6"
printf '%b\n' "$line7"
printf '%b\n' "$line8"
[ -n "$line9" ] && printf '%b\n' "$line9"
[ -n "$line10" ] && printf '%b\n' "$line10"
