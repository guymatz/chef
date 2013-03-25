alias a1='ssh iad-admin101.ihr'
if [[ ! $(hostname) =~ "chef" ]] ; then
    alias chef='ssh use1b-ss-chef002.ihr'
fi
if [[ ! $(hostname) =~ "iad-admin101.ihr" ]] ; then
    alias push-dns='ssh iad-admin101.ihr push-dns'
    alias consoleto='ssh iad-admin101.ihr -t sudo consoleto'
    alias rebooter='ssh iad-admin101.ihr -t sudo rebooter'
    alias poweron='ssh iad-admin101.ihr -t sudo poweron'
    alias poweroff='ssh iad-admin101.ihr -t sudo poweroff'
fi
