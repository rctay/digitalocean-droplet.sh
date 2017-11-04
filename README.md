A quick and dirty way to interact with DigitalOcean's Droplet REST API.

# Requirements

- node
- Unix-y shell (Windows: msys/cygwin)
- (obviously) DigitalOcean API token

# Usage

    # dependencies to allow us to extract from the JSON response, eg. '$.droplet.networks.v4[0].ip_address'
    $ (cd jsonpath && npm install)

    # setup wordlist to generate slugs
    # if you don't have access to a wordlist, set it up:
    # $ curl "http://app.aspell.net/create?max_size=60&spelling=GBs&max_variant=1&diacritic=strip&download=wordlist&encoding=utf-8&format=inline" \
    # | sed '1,/^---$/d' >words
    $ ln -s /usr/share/dict/words words

    $ source main.sh
    $ export DROPLET_TOKEN=...
    $ droplet_create \"ubuntu-16-04-x64\" sgp1    # or specify the numeric image/snapshot id
    ...
    $ echo $droplet_id
    12345678
    $ droplet_get_ip $droplet_id
    ...
    $ echo $droplet_ip
    159.11.222.34
    $ ssh yourusername@$droplet_ip
    ...
    ^D
    $ droplet_delete $droplet_id
    ...
    $ droplet_list
    {"droplets":[],"links":{},"meta":{"total":0}}
