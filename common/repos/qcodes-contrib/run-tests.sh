#!/bin/bash -e

scriptdir=$(realpath `dirname $0`)
basedir=$(realpath $scriptdir/..)

options="-p no:warnings"
if [ -n "$1" ]; then
	options="$options -v -m $1"
fi

source "$basedir/venv/bin/activate"

pushd "${basedir}/qcodes_contrib_drivers/tests/QDevil" > /dev/null
pytest $options
popd > /dev/null
