#!/bin/bash
set -e
Xvfb :99 -screen 0 1024x768x16 -nolisten tcp -nolisten unix &
sleep 1
cd /server
exec wine system/ucc.exe server KF-bioticslab.rom?game=KFmod.KFGameType?VACSecured=true?MaxPlayers=6?AdminName=admin?AdminPassword=$ADMIN_PASSWORD