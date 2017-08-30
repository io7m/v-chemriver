#!/bin/sh

TIME_START=`date "+%Y-%m-%dT%H:%M:%S"`
OUTPUT="$HOME/var/render/chemriver/"
LOG_FILE="${OUTPUT}/"`date "+%Y%m%dT%H%M%S.log"`

(
cat <<EOF
Rendering chemriver started ${TIME_START}
------------------------------------------------------------------------

EOF
) | tee -a "${LOG_FILE}"

time /usr/bin/blender \
  --background \
  chemriver.blend \
  --render-output "${OUTPUT}" \
  --render-format PNG \
  --frame-start 0 \
  --frame-end 6300 \
  --frame-jump 30 \
  --render-anim 2>&1 | tee "${LOG_FILE}"

TIME_END=`date "+%Y-%m-%dT%H:%M:%S"`
DIFF=`datediff -f '%Hh %Mm %Ss' ${TIME_START} ${TIME_END}`

(
cat <<EOF

------------------------------------------------------------------------
Rendering chemriver finished ${TIME_END}
Rendering took ${DIFF}

EOF
) | tee -a "${LOG_FILE}"

MESSAGE="Time: ${DIFF}"

ssh copperhead "notify-send \"Rendering completed\" \"${MESSAGE}\""
