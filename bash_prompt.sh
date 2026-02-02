PROMPT_COMMAND=build_prompt

build_prompt() {
  # 15:white 25:blue 55:purple 163:pink 247:light-gray
  local color='\[\e[38;5;25m\]'
  local rev_color='\[\e[7;38;5;25m\]'
  local text_color='\[\e[48;5;25;38;5;15m\]'
  local text_color_fade='\[\e[38;5;247;48;5;25m\]'
  local triangle=$'\uE0B0'
  local reset='\[\e[0m\]'

  if [ -n "$TMUX" ]; then
    # Virtual env prompt
    [ -n "$VIRTUAL_ENV_PROMPT" ] && tmux set -p @TMUX_VENV " $VIRTUAL_ENV_PROMPT"
    [ -n "$PIXI_PROMPT" ] && tmux set -p @TMUX_VENV " $PIXI_PROMPT"
    [ -z "$VIRTUAL_ENV_PROMPT" ] && [ -z "$PIXI_PROMPT" ] && tmux set -p @TMUX_VENV ""
    prompt_text=""
    # Working directory (window-specific)
    tmux set -w @TMUX_WORKDIR "$PWD"
    # Refresh tmux status line
    tmux refresh-client -S
  else
    prompt_text=" $VIRTUAL_ENV_PROMPT$reset$text_color_fade\h$text_color:\w "
  fi

  PS1="$rev_color$triangle$prompt_text$reset$color$triangle$reset "
}
