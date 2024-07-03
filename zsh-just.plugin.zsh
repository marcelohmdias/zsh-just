
#!/usr/bin/env zsh
# shellcheck disable=SC1090

# Exit if the 'just' command can not be found
if ! (( $+commands[just] )); then
    echo "WARNING: 'just' command not found"
    return
fi

# Completions directory for `just` command
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `just`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_just" ]]; then
    typeset -g -A _comps
    autoload -Uz _just
    _comps[just]=_just
fi

# Generate and load completion in the background
just --completions zsh >| "$COMPLETIONS_DIR/_just" &|
