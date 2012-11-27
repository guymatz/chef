usage ()
{
    echo "Usage:"
    echo "$THIS_SCRIPT"
    echo
}

cleanup()
{
    # TODO: clean something: lock file?
    rm -f $WORKDIR/*.{xml,zone,fake}
    rm -f $STAGING/*.fake
    exit 1;
}
trap cleanup 1 2 3 9

failure_fatal()
{
    echo "$@"
    RETVAL=1
    exit $RETVAL
}

# TODO: i'm not getting $4 here.
failure_nonfatal()
{
    echo "$@"
}

preflight_check()
{
    CURRENTIP=$(/sbin/ip addr show dev eth0 | grep secondary | awk '{print $2}' | awk -F\/ '{print $1}')

    if [ ! $CURRENTIP == $HOSTAUTOGENIP ]; then
        echo "It appears you're not running this from the"
        echo "appropriate host. Do not run this on a host"
        echo "other than CFE ns_bindauto_stage, which is - ${HOSTAUTOGENIP}."
        echo "preflight_check: Exiting!"
        failure_fatal "wrong_host"
    fi

    # test all binaries?
    [ -x $XSLTPROC ] || failure_fatal "missing_command $XSLTPROC"
    [ -x $GIT ] || failure_fatal "missing_command $GIT"
    [ -x $RSYNC ] || failure_fatal "missing_command $RSYNC"
    [ -x $NC ] || failure_fatal "missing_command $NC"
    [ -x $SUDO ] || failure_fatal "missing_command $SUDO"
    [ -x $STAT ] || failure_fatal "missing_command $STAT"
    [ -x $NAMEDCHKZONE ] || failure_fatal "missing command $NAMEDCHKZONE"
    RETVAL=0
}

xsltforwardzone()
{
    ALL_FWD_ZONES=$(find "$WORKDIR" -name "zone_*.xml")
    for ZONE in $ALL_FWD_ZONES; do
	XMLFILE="$ZONE"
	ZONE=$(echo $XMLFILE | cut -f2 -d '_')
	[ "$DEBUG" = 2 ] && echo "DEBUG2: $XSLTPROC $SS_BIND9_FWD $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone"

        $XSLTPROC $SS_BIND9_FWD $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone
        RETVAL=$?
        if [ $RETVAL -ne 0 ]; then
	    [ "$DEBUG" ] && echo "ERROR: xsltproc error in xsltforwardzone func"
	    [ "$DEBUG" = 2 ] && XSLTPROCMSG=$($XSLTPROC $SS_BIND9_FWD $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone 2>&1)
	    failure_fatal "xsltforwardzone_error"
        fi
	echo >> $WORKDIR/$ZONE.$FILETAG.zone
	echo >> $WORKDIR/$ZONE.$FILETAG.zone

	if [ -e $STAGING/$ZONE.$FILETAG.zone ]; then
            PATCHF="/var/tmp/xsltforwardzone-patch.$$"
            [ "$DEBUG" = 2 ] && echo "DEBUG2: $DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone > $PATCHF 2>/dev/null"
            $DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone > $PATCHF 2>/dev/null
            RETVAL=$?
            if [ $RETVAL = 2 ]; then  # diff had errors
		[ "$DEBUG" -gt 0 ] && echo "ERROR: diff error in xsltforwardzone func"
		[ "$DEBUG" = 2 ] && DIFFMSG=$($DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone 2>&1)
		failure_fatal "xsltforwardzone_error"
            elif [ $RETVAL = 1 ]; then  # diff found differences
		[ "$DEBUG" = 2 ] && echo "DEBUG2: $PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>/dev/null"
		$PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>/dev/null
		RETVAL=$?
		if [ $RETVAL -ne 0 ]; then
                    [ "$DEBUG" -gt 0 ] && echo "ERROR: patch error in xsltforwardzone func"
                    [ "$DEBUG" = 2 ] && PATCHMSG=$($PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>&1 )
                    failure_fatal "xsltforwardzone_error"
		fi
            fi
            rm -f $PATCHF
	else
            cp -f $WORKDIR/$ZONE.$FILETAG.zone $STAGING/$ZONE.$FILETAG.zone
	fi

	cp -f $STAGING/$ZONE.$FILETAG.zone $STAGING/$ZONE.$FILETAG.zone.fake
        # remember, bind complains if zone file doesn't end with a newline
	echo >> $STAGING/$ZONE.$FILETAG.zone

        # copy new zone to $ROOTDIR (/var/named/chroot-stage/var/named/internal)
	[ $DEBUG = 2 ] && echo "DEBUG2: cp -f $STAGING/$ZONE.$FILETAG.zone $ROOTDIR/$ZONE.$FILETAG.zone"
	cp -f $STAGING/$ZONE.$FILETAG.zone $ROOTDIR/$ZONE.$FILETAG.zone

	echo >> $WORKDIR/$ZONE.$FILETAG.zone.fake
	[ $DEBUG = 2 ] && echo "DEBUG2: cp -f $STAGING/$ZONE.$FILETAG.zone.fake $ROOTDIR/$ZONE.$FILETAG.zone.fake"
	cp -f $STAGING/$ZONE.$FILETAG.zone.fake $ROOTDIR/$ZONE.$FILETAG.zone.fake
    done
    RETVAL=0
}

xsltreversezone()
{
    ALL_REV_ZONES=$(find "$WORKDIR" -name "revzone_*.xml")
    for ZONE in $ALL_REV_ZONES; do
	XMLFILE=$ZONE
	ZONE=$(echo $XMLFILE | cut -f2 -d '_')
	[ $DEBUG = 2 ] && echo "DEBUG2: $XSLTPROC $SS_BIND9_REV $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone"
	$XSLTPROC $SS_BIND9_REV $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone 2>/dev/null
	RETVAL=$?
	if [ $RETVAL -ne 0 ]; then
            [ "$DEBUG" -gt 0 ] && echo "ERROR: xsltproc error in xsltreversezone func"
            [ "$DEBUG" = 2 ] && XSLTPROCMSG=$($XSLTPROC $SS_BIND9_REV $XMLFILE > $WORKDIR/$ZONE.$FILETAG.zone 2>&1)
            failure_fatal "xsltreversezone_error"
	fi

        # bind complains if zone file doesn't end with a newline
	echo >> $WORKDIR/$ZONE.$FILETAG.zone

	if [ -e $STAGING/$ZONE.$FILETAG.zone ]; then
            PATCHF="/var/tmp/xsltreversezone-patch.$$"
            [ "$DEBUG" = 2 ] && echo "DEBUG2: $DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone > $PATCHF 2>/dev/null"
            $DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone > $PATCHF 2>/dev/null
            RETVAL=$?
            if [ $RETVAL = 2 ]; then  # diff had errors
		[ "$DEBUG" -gt 0 ] && echo "ERROR: diff error in xsltreversezone func"
		[ "$DEBUG" = 2 ] && DIFFMSG=$($DIFF -u $STAGING/$ZONE.$FILETAG.zone $WORKDIR/$ZONE.$FILETAG.zone 2>&1 )
		failure_fatal "xsltreversezone_error"           
            elif [ $RETVAL = 1 ]; then  # diff found differences                        
		[ $DEBUG = 2 ] && echo "DEBUG2: $PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>/dev/null"
		$PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>/dev/null
		RETVAL=$?                 
		if [ $RETVAL -ne 0 ]; then                                              
                    [ "$DEBUG" -gt 0 ] && echo "ERROR: patch error in xsltreversezone func"
                    [ "$DEBUG" = 2 ] && PATCHMSG=$($PATCH -s $STAGING/$ZONE.$FILETAG.zone $PATCHF 2>&1 )
                    failure_fatal "xsltreversezone_error"
		fi
            fi                                     
            rm -f $PATCHF                          
	else
            cp -f $WORKDIR/$ZONE.$FILETAG.zone $STAGING/$ZONE.$FILETAG.zone
	fi
	
    # copy new zone to $ROOTDIR (/var/named/chroot-stage/var/named/internal)
	[ $DEBUG = 2 ] && echo "DEBUG2: cp -f $STAGING/$ZONE.$FILETAG.zone $ROOTDIR/$ZONE.$FILETAG.zone"
	cp -f $STAGING/$ZONE.$FILETAG.zone $ROOTDIR/$ZONE.$FILETAG.zone
    done
    RETVAL=0
}

#   named-checkzone -d add $ROOTDIR/var/named/internal/add.autogen.zone
#   if this check succeeds, proceed with git commit
bindcheckfwd()
{
    # if named-checkzone succeeds against the "fake" file, move into git repo 

    [ $DEBUG = 2 ] && echo "DEBUG2: $NAMEDCHKZONE -q $ZONE $ROOTDIR/$ZONE.$FILETAG.zone.fake"
    $NAMEDCHKZONE -q $ZONE $ROOTDIR/$ZONE.$FILETAG.zone.fake
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        [ "$DEBUG" ] && echo "ERROR: named-checkzone error in bindcheckfwd func"
        [ $DEBUG = 2 ] && NAMEDCHKZONEMSG=$($NAMEDCHKZONE -d $ZONE $ROOTDIR/$ZONE.$FILETAG.zone.fake 2>&1 )
        touch $FWDERRTOUCHFILE
        failure_fatal "bindcheckfwd_error: $NAMEDCHKZONEMSG"
    fi
    rm -f $FWDERRTOUCHFILE
    RETVAL=0
}
bindcheckrev()
{
    # if named-checkzone succeeds, git commit it.
    [ $DEBUG = 2 ] && echo "DEBUG2: $NAMEDCHKZONE -q $ZONE $ROOTDIR/$ZONE.$FILETAG.zone"
    $NAMEDCHKZONE -q $ZONE $ROOTDIR/$ZONE.$FILETAG.zone
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        [ "$DEBUG" ] && echo "ERROR: named-checkzone error in bindcheckrev func"
        [ $DEBUG = 2 ] && NAMEDCHKZONEMSG=$($NAMEDCHKZONE -d $ZONE $ROOTDIR/$ZONE.$FILETAG.zone 2>&1 )
        touch $REVERRTOUCHFILE
        failure_fatal "bindcheckrev_error"
    fi
    rm -f $REVERRTOUCHFILE
    RETVAL=0
}

commit_changes()
{
    if [ -e $FWDERRTOUCHFILE ] || [ -e $REVERRTOUCHFILE ]; then
        failure_fatal "detected an error with last export. aborting commit process."
    fi

    mkdir $WORKDIR/$WORKDIRGIT
    cd $WORKDIR/$WORKDIRGIT
    git clone root@lax-ss-admin001b:/data/git-repos/ipplan-autogen.git .

    WORKDIR_ABS_PATH="$WORKDIR/$WORKDIRGIT/named/internal"
    [ "$DEBUG" -gt 0 ] && echo "DEBUG: WORKDIR_GIT:\t $WORKDIR_ABS_PATH"
    sudo -u apache mkdir -p $WORKDIR_ABS_PATH
    # pull our new files in
    [ $DEBUG = 2 ] && echo "DEBUG2: cp -f $STAGING/*.zone $WORKDIR_ABS_PATH"
    cp -f $STAGING/*.zone $WORKDIR_ABS_PATH
    [ $DEBUG = 2 ] && git status 2>&1
    [ $DEBUG = 2 ] && git diff 2>&1

    # add all files
    [ $DEBUG = 2 ] && echo "DEBUG2: $PWD; git add -A"
    git add -A
    # checkin
    [ $DEBUG = 2 ] && echo "DEBUG2: $PWD; git commit -a -m '$COMMITTAG'"
    git commit -a -m "$COMMITTAG" >/dev/null 2>&1

    git pull -q --rebase >/dev/null
    git push
    RETVAL=$?
    if [ $RETVAL -ne 0 ]; then
        [ "$DEBUG" ] && echo "ERROR: git push error in gitoper func"
        [ $DEBUG = 2 ] && GITPUSHMSG=$(git push)
        failure_fatal "gitpush_error"
    fi

    [ "$DEBUG" ] && git diff

    # Grab the revision now, we'll need it later
    GITREV=$(git rev-parse HEAD);
    if [ "${GITREV}x" == "x" ]; then
        failure_fatal "gitrevision_check"
    fi

    cd $WORKDIR
    rm -rf $WORKDIR/$WORKDIRGIT
    rm -f $WORKDIR/*.{zone,xml,fake}
    rm -f $STAGING/*
}
