#!/usr/bin/env sh
# You probably don't want to modify this file
cd "${CODEPATH}" || exit 1
export PYTHONPATH="${CODEPATH}":"${PYTHONPATH}"

export X="${INPUT_DIRECTORY}/X${TRAINING_DATA_EXTENSION:-.csv}"
export weights="${INPUT_DIRECTORY}/weights.csv"

CMD="drum fit --target-type ${TARGET_TYPE} --input ${X} --num-rows ALL --output ${ARTIFACT_DIRECTORY} \
--code-dir ${CODEPATH} --verbose"

if [ -n "${UNSUPERVISED}" ]; then
  CMD="${CMD} --unsupervised "
else
  export y="${INPUT_DIRECTORY}/y.csv"
  CMD="${CMD} --target-csv ${y}"
fi


if [ -n "${POSITIVE_CLASS_LABEL}" ]; then
    CMD="${CMD} --negative-class-label ${NEGATIVE_CLASS_LABEL} \
    --positive-class-label ${POSITIVE_CLASS_LABEL}"
fi
if [ -n "${CLASS_LABELS_FILE}" ]; then
    CMD="${CMD} --class-labels-file ${CLASS_LABELS_FILE}"
fi
if [ -f "${weights}" ]; then
    CMD="${CMD} --row-weights-csv ${weights}"
fi

echo "${CMD}"
sh -c "${CMD}"
