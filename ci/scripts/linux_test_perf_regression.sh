#!/bin/bash

JMETER_PATH='/opt/apache-jmeter-5.3/bin/jmeter'

cd tests/performance

# Only on a python 2 environment -
PY_MAJOR_VER=$(python -c 'import sys; major = sys.version_info.major; print(major);')
if [ $PY_MAJOR_VER -eq 2 ]; then
  # Hack to use python 3.6.5 for bzt installation and execution
  # While MMS continues to use system python which is at 2.7.x
  export PATH="/root/.pyenv/bin:/root/.pyenv/shims:$PATH"
  pyenv local 3.6.5 system
fi

# Install dependencies
pip install -r requirements.txt
pip install bzt

# Execute performance test suite and store exit code
./run_performance_suite.py -j $JMETER_PATH -e xlarge -x example* --no-compare-local --no-monit
EXIT_CODE=$?

# Exit with the same error code as that of test execution
exit $EXIT_CODE