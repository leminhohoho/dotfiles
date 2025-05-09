#!/bin/bash
## ~/.config/qutebrowser/userscripts/git_clone.sh ::

print_help() {
cat << 'HELPDOC'
NAME
    git_clone.sh

DESCRIPTION
    Userscript for qutebrowser to clone repo from the current repo url.

USAGE
    Copy git_clone.sh to qutebrowser userscript directory.

    Open url in git_clone:
        :spawn -u git_clone.sh
        :hint links userscript git_clone.sh

REQUIREMENTS
    git
HELPDOC
}

msg() {
    printf 'message-info "%s"\n' "$*" > "$QUTE_FIFO"
}

msg_error() {
    printf 'message-error "E: %s"\n' "$*" > "$QUTE_FIFO"
}

msg_warn() {
    printf 'message-warning "W: %s"\n' "$*" > "$QUTE_FIFO"
}

repos="$HOME/repos"

cd "$repos"

git clone "$QUTE_URL.git"
msg "$QUTE_URL is cloned to $repos"
