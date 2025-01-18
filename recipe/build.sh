#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export DISABLE_AUTOBREW=1

if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
    sed -i "s?\$(R_HOME)?${BUILD_PREFIX}?g" src/Makevars
    sed -i "s?'cat(\"-I\", R.home(\"include\"), sep=\"\")'?'cat(\"-I\", R.home(\"include\"), sep=\"\")' | sed -e 's|${BUILD_PREFIX}|${PREFIX}|g' | sed -e 's|WARNING: ignoring environment value of R_HOME||g'?" src/Makevars
fi

${R} CMD INSTALL --build . ${R_ARGS:-}
