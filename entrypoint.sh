#!/bin/bash
set -e 
if [ "$DEBUG" = 1 ]; then
    exec tmux new-session
fi
cd /server
exec wine system/ucc.exe server KF-bioticslab.rom?game=KFmod.KFGameType?VACSecured=false?MaxPlayers=6?AdminName=admin?AdminPassword=$ADMIN_PASSWORD