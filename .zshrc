# If not running interactively, don't do anything
[[ -o interactive ]] || return

# There configs should be set before p10k instant prompt
stty stop undef
export GPG_TTY=$(tty)

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
# Homebrew [[[2
if [[ -d /opt/homebrew ]]; then
  export HOMEBREW_PREFIX="/opt/homebrew";
  export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
  export HOMEBREW_REPOSITORY="/opt/homebrew";
  export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
  export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
  export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
fi

#
# zinit
#

# zsh-history-substring-search
function __zshrc_zsh_history_substring_search_bindkey {
    # lazily config bindkey
    # https://github.com/zsh-users/zsh-syntax-highlighting/issues/411#issuecomment-317077561
    bindkey '^[[A' history-substring-search-up
    bindkey '^[[B' history-substring-search-down
    bindkey '^[OA' history-substring-search-up
    bindkey '^[OB' history-substring-search-down
    bindkey -M vicmd 'k' history-substring-search-up
    bindkey -M vicmd 'j' history-substring-search-down
}

autoload -U is-at-least
if is-at-least 5.1 && [[ -d ~/.zinit ]]; then
  source ~/.zinit/bin/zinit.zsh

  zplugin ice depth=1
  zplugin light romkatv/powerlevel10k

  function __zshrc_cgitc_patch {
    sed 's/master/$(git_main_branch)/g' abbreviations > abbreviations.mod
    sed 's/master/$(git_main_branch)/g' abbreviations.zsh > abbreviations.mod.zsh
    sed 's/abbreviations/abbreviations.mod/' init.zsh > init.mod.zsh
  }

  # Show autosuggestions
  ZSH_AUTOSUGGEST_USE_ASYNC=1
  if is-at-least 5.3; then
    zinit ice silent wait'1' atload'_zsh_autosuggest_start'
  fi
  zinit light zsh-users/zsh-autosuggestions

  # Easily access the directories you visit most often.
  #
  # Usage:
  #   $ z work
  #   $ <CTRL-G>work
  zinit light agkozak/zsh-z
  zinit light andrewferrier/fzf-z
  export FZFZ_SUBDIR_LIMIT=0

  # Automatically expand all aliases
  ZSH_EXPAND_ALL_DISABLE=word
  zinit light simnalamburt/zsh-expand-all

  # Others
  zinit light simnalamburt/cgitc
  zinit light simnalamburt/ctrlf
  zinit light zdharma-continuum/fast-syntax-highlighting
#   zinit light zsh-users/zsh-history-substring-search

  # sbin ice from git
  zinit for \
    light-mode zdharma-continuum/zinit-annex-bin-gem-node

  # fzf
  zinit for \
    from'gh-r' sbin'fzf' junegunn/fzf \
    https://github.com/junegunn/fzf/raw/master/shell/{'completion','key-bindings'}.zsh

  # kubectx, kubens
  zinit for \
    sbin'kubectx;kubens' light-mode ahmetb/kubectx

  zinit load tirr-c/zsh-env-setup

  # https://github.com/zdharma-continuum/zinit#calling-compinit-with-turbo-mode
  # bindkey after loading plugins.
  # Reference: https://github.com/ryul99/.dotfiles/blob/master/home/.zshrc
  autoload -Uz compinit bashcompinit
  compinit
  bashcompinit
  zinit cdreplay
  zinit wait lucid for \
      as'program' pick'git-select-branch' autoload'git-select-branch' \
        tirr-c/git-select-branch \
      light-mode blockf zsh-users/zsh-completions \
      atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" zdharma-continuum/fast-syntax-highlighting
#       atload"__zshrc_zsh_history_substring_search_bindkey" zsh-users/zsh-history-substring-search
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # powerlevel10k [[[2
  # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
  # Initialization code that may require console input (password prompts, [y/n]
  # confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  zinit for \
    atload'! [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' \
    romkatv/powerlevel10k
  # ]]]2

else
  # Default terminal
  case "$TERM" in
    xterm-color|*-256color)
      PS1=$'\e[1;32m%n@%m\e[0m:\e[1;34m%~\e[0m%(!.#.$) ';;
    *)
      PS1='%n@%m:%~%(!.#.$) ';;
  esac

  autoload -Uz compinit bashcompinit
  compinit
  bashcompinit
fi


#
# powerlevel10k. To customize prompt, run `p10k configure` or edit ~/.p10k.zsh
#
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Show me exit codes
typeset -g POWERLEVEL9K_STATUS_ERROR=true
# Less distractive colorscheme
typeset -g POWERLEVEL9K_TIME_FOREGROUND=238
typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=242
typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS,VIOWR}_FOREGROUND=226


#
# zsh-sensible
#
if (( $+commands[lsd] )); then
  alias ls='lsd'
  alias l='lsd -Al --date=relative --group-dirs=first --blocks=permission,user,size,date,name'
  alias ll='lsd -l --date=relative --group-dirs=first --blocks=permission,user,size,date,name'
  alias lt='lsd --tree --depth=2 --date=relative --group-dirs=first'
else
  alias l='ls -alh'
  alias ll='ls -lh'
fi
alias rm='rm -I'
alias mv='mv -i'
alias cp='cp -i'

HISTSIZE=90000
SAVEHIST=90000
HISTFILE=~/.zsh_history

setopt auto_cd histignorealldups sharehistory
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
# Substring completion
zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Clear screen
clear_screen() { tput clear }
zle -N clear_screen
bindkey '^s' clear_screen


#
# lscolors
#
export LS_COLORS="di=1;36:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=0;41:sg=30;46:tw=0;42:ow=30;43"
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

export LSCOLORS="Gxfxcxdxbxegedxbagxcad"
export TIME_STYLE='long-iso'
autoload -U colors && colors


#
# zsh-substring-completion
#
setopt complete_in_word
setopt always_to_end
WORDCHARS=''
zmodload -i zsh/complist

# Find current user in Windows
export WINDOWS_CURRENT_USER=$(cmd.exe /c "echo %USERNAME%" 2>/dev/null | tr -d '\r')
export windowsUserProfile=/mnt/c/Users/${WINDOWS_CURRENT_USER}

#
# WSL support
#
if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]]; then
  umask 022
  alias open=explorer.exe
  alias pbcopy=clip.exe
  alias pbpaste='powershell.exe Get-Clipboard | sed "s/\r$//" | head -c -1'
  alias code='${windowsUserProfile}/AppData/Local/Programs/Microsoft\ VS\ Code/code.exe'
  alias wslexit='cmd.exe /c "wsl --shutdown"'
fi


#
# zshrc
#
export DOCKER_BUILDKIT=1
export AWS_SDK_LOAD_CONFIG=true

# EDITOR이나 VISUAL 환경변수 안에 'vi' 라는 글자가 들어있으면 자동으로
# emacs-like 키바인딩들이 해제되어서, ^A ^E 등을 모조리 쓸 수 없어진다.
# 무슨짓이냐...
#
# References:
#   https://stackoverflow.com/a/43087047
#   https://github.com/zsh-users/zsh/blob/96a79938010073d14bd9db31924f7646968d2f4a/Src/Zle/zle_keymap.c#L1437-L1439
#   https://github.com/yous/dotfiles/commit/c29bf215f5a8edc6123819944e1bf3336a4a6648
if (( $+commands[vim] )); then
  export EDITOR=vim
  bindkey -e
elif (( $+commands[nvim] )); then
  export EDITOR=nvim
  bindkey -e
fi

# Terraform
if (( $+commands[terraform] )); then
  alias tf='terraform'
  export TF_PLUGIN_CACHE_DIR="$HOME/.terraform.d/plugin-cache"
fi

# Golang
if (( $+commands[go] )); then
  export GOPATH="$HOME/.go"
  export PATH="$PATH:$GOPATH/bin"
fi

# Golang (debian)
export PATH="$PATH:/usr/local/go/bin"

#
# add custom binaries
#
export PATH="$PATH:~/bin"

# Set internal field separator to newline
# IFS=$'\n'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ $- == *i* ]] && nvm use node

#
# Load local configs
#
if [[ -f ~/.zshrc.local ]]; then
  source ~/.zshrc.local
fi

# Created by `pipx` on 2021-12-30 13:31:04
export PATH="$PATH:/home/$HOME/.local/bin"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# github cli shortcuts
# gh copilot suggest => ghcs, gh copilot explain => ghce
eval "$(gh copilot alias -- zsh)"

#
# cuda (if /usr/local/cuda exists)
#

if [[ -d /usr/local/cuda ]]; then
  export PATH="/usr/local/cuda/bin:$PATH"
  export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
  export CUDA_HOME="/usr/local/cuda"
fi
