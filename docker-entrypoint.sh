#!/bin/bash
PFLOTRAN_UID=$(stat -c '%u' ./)
getent passwd $PFLOTRAN_UID
if [ $? -ne 0 ]
then
  useradd e4d_$PFLOTRAN_UID -u $PFLOTRAN_UID
fi
sudo -u \#$PFLOTRAN_UID env PATH="$PATH" $@
