convert_json () {
	if [[ -f $1 ]] && [[ "${1: -5}" == ".json" ]]
	then
		local name=${1%.*};
		cat $1 | jq -c > $name.spine-json;
		echo $1 "=>" $name".spine-json";
	else
		echo "not a json";
	fi
}

if [[ $# -eq  0 ]]
then
 for f in *.json; do convert_json "$f"; done
else
	for f in "$@"; do convert_json "$f"; done
fi

exit 1;

