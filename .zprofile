# Enviroment variables
export ZSH="$HOME/.oh-my-zsh"
export LC_ALL=pl_PL.UTF-8
export TERMINAL=terminator
export PAGER=less
export VISUAL=emacs
export TERM="xterm-256color"
export GPG_TTY=$(tty)
export PATH="${PATH}:${HOME}/.gem/ruby/2.5.0/bin/:${HOME}/.local/bin/:${HOME}/.scripts/"

export PATH="${HOME}/.cargo/bin:$PATH"
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
