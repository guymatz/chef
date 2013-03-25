if [[ $(hostname) =~ "chef" ]] ; then

    # Basic Knife Comnmands
    alias kss='knife cookbook site search'
    alias ksv='knife cookbook site vendor'
    alias ku='knife cookbook upload'
    alias nedit='knife node edit -a'
    alias nlist='knife node list'
    alias nshow='knife node show'
    alias redit='knife role edit -a'
    alias rlist='knife role list'
    alias rshow='knife role show'
    alias rcreate='knife role create'
    alias elist='knife environment list'
    alias eshow='knife environment show'
    alias eedit='knife environment edit -a'
    alias ecreate='knife environment create'
    alias ncook='knife cookbook create'

    # Advanced Knife Commands

    # example > kniferun "hostname:[* TO *]" df -h
    alias kniferun='knife ssh "\|:1" "\|:2"'

fi
