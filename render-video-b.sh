#!/bin/sh

TIME_START=`date "+%Y-%m-%dT%H:%M:%S"`
OUTPUT="out/"
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
  chemriver_video.blend \
  --scene chemriver_b \
  --render-output "${OUTPUT}" \
  --render-anim 2>&1 | tee "${LOG_FILE}"
