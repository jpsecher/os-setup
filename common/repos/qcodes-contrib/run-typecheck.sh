#!/bin/bash -e

scriptdir=$(realpath `dirname $0`)
basedir=$(realpath $scriptdir/..)

options=""
if [ -n "$1" ]; then
	options="$options $1"
fi

source "$basedir/venv/bin/activate"

mypy $options qcodes_contrib_drivers/drivers/QDevil/*.py

