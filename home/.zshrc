if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
fi

autoload -Uz compinit
autoload bashcompinit

compinit
bashcompinit

add_path() {
    export PATH="$PATH:$1"
}

add_path_before() {
    export PATH="$1:$PATH"
}

# renv
add_path_before "$HOME/.rbenv/shims"
add_path_before "$HOME/.rbenv/bin"
if which rbenv > /dev/null; then 
    eval "$(rbenv init -)"; 
fi

# pyenv
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then 
    eval "$(pyenv init -)"; 
fi

# my tools
add_path "$HOME/bin"

#vcs info
autoload -Uz vcs_info
autoload -Uz colors
colors

# PROMPT変数内で変数参照
setopt prompt_subst

zstyle ':vcs_info:git:*' check-for-changes true 
zstyle ':vcs_info:git:*' stagedstr "%F{green}!" 
zstyle ':vcs_info:git:*' unstagedstr "%F{magenta}+" 
zstyle ':vcs_info:*' formats " %F{cyan}%c%u(%b)%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]' 

precmd () { vcs_info }

PROMPT='%B%F{green}anatawa12%b%f:%B%F{blue}%~%B%F{red}${vcs_info_msg_0_}%b%f $ '
#PROMPT=$PROMPT'${vcs_info_msg_0_} %{${fg[red]}%}%}$%{${reset_color}%} '

java_up ()
{
    case "$1" in
        "-V" ) /usr/libexec/java_home -V ;;
        "default" ) java_up 1.8 ;;
        * ) export JAVA_HOME=$(/usr/libexec/java_home -v $1)
            java -version
            ;;
    esac
}

# Add .NET Core SDK tools
add_path "/Users/anatawa12/.dotnet/tools"

# go lang settings
export GOPATH=$HOME/go
add_path "$GOPATH/bin"

add_path "."

# use gnu tools
add_path_before "/usr/local/opt/grep/libexec/gnubin"
add_path_before "/usr/local/opt/coreutils/libexec/gnubin"

# utility to launch iterm new window
if type open > /dev/null ; then
  iterm() {
    open -a 'iterm' .
  }
fi

java_up 1.8
