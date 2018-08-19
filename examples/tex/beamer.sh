#!/usr/bin/bash
precommands() {
    return
}

postcommands() {
    cat "${CURRENT_TEMPLATE}/user-commands-beamer.tex" >> "${PROJECT}/configs/user-commands.tex"
}
