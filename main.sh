WORDS=./words
JSONPATH_CMD="node ./jsonpath/jsonpath.js"

droplet_create() {
# listing keys: https://api.digitalocean.com/v2/account/keys
# eg. droplet_create \"ubuntu-16-04-x64\" sfo1 # note the quotes on first parameter
# eg. droplet_create 12345678 sfo1
params=$(printf '{"name":"%s","region":"%s","size":"512mb","image":%s,"ssh_keys":[]}' $(slug) "$2" "$1")
echo "$params"
curl -X POST "https://api.digitalocean.com/v2/droplets" \
	-d "$params" \
	-H "Authorization: Bearer $DROPLET_TOKEN" \
	-H "Content-Type: application/json" | tee out \
&& droplet_id=$($JSONPATH_CMD '$.droplet.id' <out)
}

droplet_list() {
curl -X GET "https://api.digitalocean.com/v2/droplets" \
	-H "Authorization: Bearer $DROPLET_TOKEN"
}

droplet_get_ip() {
curl -X GET "https://api.digitalocean.com/v2/droplets/$1" \
	-H "Authorization: Bearer $DROPLET_TOKEN" | tee out \
&& droplet_ip=$($JSONPATH_CMD '$.droplet.networks.v4[0].ip_address' <out)
}

droplet_delete() {
curl -X DELETE "https://api.digitalocean.com/v2/droplets/$1" \
	-H "Authorization: Bearer $DROPLET_TOKEN" \
	-H "Content-Type: application/x-www-form-urlencoded" \
	-v
}

slug_prefix() {
	## for 2 words
	#<$WORDS shuf -n 2 \
	#| tr '[:upper:]' '[:lower:]' \
	#| sed 's/[^a-zA-Z]//g' \
	#| paste -d- -s

	<$WORDS shuf -n 1 \
	| tr '[:upper:]' '[:lower:]' \
	| sed 's/[^a-zA-Z]//g'
}

slug_suffix() {
	# -An: "none" address to be shown as 1st column
	od -An -x /dev/urandom \
	| awk '{print $1; exit}'
}

slug() {
	printf "%s-%s\n" "$(slug_prefix)" "$(slug_suffix)"
}
