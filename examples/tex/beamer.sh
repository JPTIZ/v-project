#!/usr/bin/bash
pre-commands() {
    return
}

post-commands() {
    kind-log "Adding beamer-specific LaTeX commands"
    cat "${CURRENT_TEMPLATE}/user-commands-beamer.tex" \
        >> "${PROJECT}/configs/user-commands.tex"

    kind-log "Changing documentclass"
    sed -i 's/^\\documentclass{.*}$/\\documentclass{beamer}/' "${PROJECT}/main.tex"
}
