#!/bin/sh
if [ ! -e "$HOME/.gnupg/gpg-agent.conf" ]; then
    echo 'pinentry-program /opt/homebrew/bin/pinentry-mac' > "$HOME/.gnupg/gpg-agent.conf"
    gpgconf --kill gpg-agent
    gpgconf --launch gpg-agent
fi
