#!/bin/sh

TIME_START=`date "+%Y-%m-%dT%H:%M:%S"`
OUTPUT="$HOME/var/render/chemriver/"
LOG_FILE="${OUTPUT}/"`date "+%Y%m%dT%H%M%S.log"`

mkdir -p "${OUTPUT}" || exit 1

(
cat <<EOF
Rendering chemriver started ${TIME_START}
------------------------------------------------------------------------

EOF
) | tee -a "${LOG_FILE}"

time /usr/bin/blender \
  --background \
  chemriver.blend \
  --scene main \
  --render-output "${OUTPUT}" \
  --render-format PNG \
  --frame-start 0 \
  --frame-end 6300 \
  --frame-jump 1 \
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

ssh copperhead "notify-send -t 28800000 \"Rendering completed\" \"${MESSAGE}\""
