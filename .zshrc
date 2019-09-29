# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
#source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#autoload -Uz compinit
# Path to your oh-my-zsh installation.

export ZSH="${HOME}/.oh-my-zsh"
export TERM="xterm-256color"
export PATH="${PATH}:${HOME}/.gem/ruby/2.5.0/bin/:${HOME}/.local/bin/:${HOME}/.scripts/:${HOME}/.cargo/bin:${HOME}/go/bin"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
export GO_PATH=${HOME}/go

alias ls="colorls"
alias rm="trash"
alias hexd="hexyl -n 256"
alias grep="rg"
alias cp="rsync -ah --progress"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# Font mode for powerlevel9k
POWERLEVEL9K_MODE="nerdfont-complete"

ZSH_THEME="powerlevel9k/powerlevel9k"
#ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  colorized-man-pages
  colorize
  command-not-found
  python
  mvn
  ripgrep
  cargo
  catimg
  cp
  docker
  encode64
  extract
  httpie
#  lol
  sudo
  zsh_reload
  zsh-autosuggestions
  zsh-syntax-highlighting
)

#source $(dirname $(gem which colorls))/tab_complete.sh

source $ZSH/oh-my-zsh.sh
# Show OS info when opening a new terminal

#neofetch
#bat ~/yurishort.txt | figlet -t -f ~/.config/figlet/stampatello

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Prompt settings
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%K{white}%k"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%K{green}%F{black} \uf155 %f%F{green}%k\ue0b0%f "

# Separators
POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR=$'\ue0b0'
POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR=$'\ue0b1'
POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR=$'\ue0b2'
POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR=$'\ue0b7'

# Dir colours
POWERLEVEL9K_DIR_HOME_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_FOREGROUND='white'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='black'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='white'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='yellow'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='black'
POWERLEVEL9K_SHORTEN_DIR_LENGTH=8
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"

# OS segment
POWERLEVEL9K_OS_ICON_BACKGROUND='black'
#POWERLEVEL9K_LINUX_ICON=''
#OS_ICON='\ufb27'

# VCS icons
POWERLEVEL9K_VCS_GIT_ICON=$'\uf1d2 '
POWERLEVEL9K_VCS_GIT_GITHUB_ICON=$'\uf113 '
POWERLEVEL9K_VCS_GIT_GITLAB_ICON=$'\uf296 '
POWERLEVEL9K_VCS_BRANCH_ICON=$''
POWERLEVEL9K_VCS_STAGED_ICON=$'\uf055'
POWERLEVEL9K_VCS_UNSTAGED_ICON=$'\uf421'
POWERLEVEL9K_VCS_UNTRACKED_ICON=$'\uf00d'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON=$'\uf0ab '
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON=$'\uf0aa '

# VCS colours
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='blue'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'

# VCS CONFIG
POWERLEVEL9K_SHOW_CHANGESET=false

# Status
POWERLEVEL9K_STATUS_CROSS=true
POWERLEVEL9K_OK_ICON=$'\uf164'
POWERLEVEL9K_FAIL_ICON=$'\uf165'
POWERLEVEL9K_CARRIAGE_RETURN_ICON=$'\uf165'

# Time
POWERLEVEL9K_TIME_FORMAT="%D{%H:%M %d.%m.%y}"
#POWERLEVEL9K_TIME_FORMAT="%F{black}%D{%I:%M}%f"
POWERLEVEL9K_TIME_BACKGROUND='blue'

# Command auto-correction.
ENABLE_CORRECTION="true"

# TTY
POWERLEVEL9K_CUSTOM_TTY="tty"
POWERLEVEL9K_CUSTOM_TTY_BACKGROUND="blue"
POWERLEVEL9K_CUSTOM_TTY_FOREGROUND="white"

#POWERLEVEL9K_DIR_BACKGROUND='white'
POWERLEVEL9K_DIR_HOME_FOREGROUND="red"
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="white"
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="white"

#POWERLEVEL9K_CONTEXT_REMOTE
POWERLEVEL9K_CONTEXT_REMOTE_BACKGROUND="white"
POWERLEVEL9K_CONTEXT_REMOTE_FOREGROUND="black"

# Prompt elements

# Prompts
if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon ssh context dir root_indicator vcs dir_writable)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon context dir root_indicator vcs dir_writable)
fi

POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time background_jobs time ram ip)

catimg ~/.wallpapers/TOUHOUAYAYA.png


source /home/forlos/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
