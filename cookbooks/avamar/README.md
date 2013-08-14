avamar Cookbook
===============
Installs, configures and registers a new Avamar backup client 

avamar bin tools:
===============

executable: avscc
---------------
Usage: /usr/local/avamar/bin/avscc [OPTION...]


--acaddr=ipaddr           Client agent address               ACADDR 
--allowqueuedworkorders   Submit workorders even when workorder are currently running 
--command=name            Client agent command {snapup|restore|status|stop|logfilelist|init|forceupdate|uninit|wo_snapup|wo_restore} 
--dpnacl=user@domain      ACLs for machine in DPN accounting system 
--dpnpath=name            Path identifying machine  DPNPATH        
--flagfile=FILE           Specify file containing a list of flags  
--help, --he, --hel       Print this message                       
--informationals          Set informational level                  
--interfacelanguage=name  On Windows platforms specifies the requested user interface language (typically the LANGID) for the GUI 
--logfile=FILE, --log     Specify logfile pathname                 [/root/avscc.log]
--mcsaddr=name            MCS address               MCSADDR        
--noinformationals        Turn off info messages                   
--nostdout                Turn off output to the console           
--nowarnings              Turn off warnings                        
--operation=name, --op    Command-line operation to perform        
--quiet                   Suppress informational and warning messages 
--restore-destination=name, --restore-option What kind of restore to do               none
--server=IPADDR, --hfsaddr Avamar server address             HFSADDR 
--snapset=name            Snapset file                             
--snapupremindhours=n     Number of hours without a backup before a backup reminder messagebox will be displayed [72]
--tryagain                Wait when server says to try again later [True]
--usage                   Print a list of available flags          
--verbose, -v             Set verboseness level                    
--version                 Display build version     


executable: avtar
---------------
Usage:  avtar <Task> [Options...]

Tasks:

-c, --create    Create a new backup
-x, --extract   Extract files from a backup
-t, --list      Show contents of a backup
    --backups   List available client backups
    --delete    Delete one backup from the server
    --showlog   Show session log of a backup
    --validate  Verify integrity of a backup

Options:

--account=DEST, --path, --acnt Avamar server account path               
--after=DATE              Date YYYY-MM-DD HH:MM:SS.FF              
--backup-type=type        Backup Type                              
--before=DATE             Date YYYY-MM-DD HH:MM:SS.FF              
--cacheitmsize            Store item size into f_cache.dat, primary used by Web Service plugin 
--cachepaxstream          Enable the caching for PAX stream format, primary used by Web Service plugin 
--checkisalreadyrestored  Check if a mapi item already restored once 
--count=NUM               Maximum number of records to display with backups command 
--ddr-exempt=PATTERN      Block files that match the PATTERN sending to DDR 
--ddr-exempt-from=FILE, --ddrblock_from Block files that match patterns listed in FILE sending to DDR 
--ddr-filesystem          Enable file system backup to DDR and the paging cache 
--dereference, -h         Dump instead the files symlinks point to 
--directory=PATH, -C      Change to directory "DIR"                
--exclude=PATTERN         Exclude files that match the PATTERN     
--exclude-from=FILE, -X, --exclude_from Exclude patterns listed in FILE          
--exclude-pluginid-list=string, --excludepluginids Avamar Excluded Plug-in Id List          
--exclude_cachefile       Exclude cache files from backup          [True]
--existing-dir-aclrestore, --aclrestore During restore replace security on pre-existing directories 
--existing-file-overwrite-option=WHEN, --overwrite Specifies when to overwrite existing files on restore [never]
--expires=DAYS or Timestamp Backup expiration time                   
--flagfile=FILE           Specify file containing a list of flags  
--force                   Force traversal of NFS and LOFS file systems 
--forcefs=FSLIST          Force traversal of specified file system types 
--from-stdin              Get backup stream from standard input only 
--help, --he, --hel       Print this message                       
--id=user@domain/homeacnt Authentication Id                        
--ignorefs=FSLIST         Do NOT traverse the specified file system types 
--include=PATTERN         Include files that match the PATTERN     
--include-from=FILE, --include_from Include patterns listed in FILE          
--informationals          Set informational level                  
--label=TAG, -f           Specify backup label                     
--libavctl_path=PATH, --libavctl-path Load libavctl shared library from the given path (complete path including extension) 
--logfile=FILE, --log     Specify logfile pathname                 
--max-entries=n, --maxentries The maximum entries to display in a listing 
--no-recursion            Avoid descending automatically in directories on backup/restore 
--noinformationals        Turn off info messages                   
--nostdout                Turn off output to the console           
--nowarnings              Turn off warnings                        
--one-file-system, -l     Stay in local file system when creating backup 
--onlinefsrestore         Flag to indicate online file system restore, targeted for Homebase use 
--open-file-restore-option=HOW WINDOWS: Specifies how to restore open files [never]
--operation=name, --op    Command-line operation to perform        
--paging-cache            Use to enable paging cache for large filesystems or databases. 
--password=PSWD, --ap, --pswd Authentication password                  
--pathmap=string          Defines mapped paths                     
--pausetimeout=SECS       Number of seconds to pause before resuming automatically [1800]
--pluginid-list=string, --pluginids Avamar Plug-in Id List                   
--preservepaths           On restore, keep original directory structure intact 
--quiet                   Suppress informational and warning messages 
--repaircache             Check that client side hashes are on server and remove invalid ones 
--reparse-limit=n, --reparse_limit Traverse NTFS reparse points at most this many levels [1]
--restore-acls-only       On restore, only restore ACLs to existing file on disk 
--restore-destination=name, --restore-option What kind of restore to do               none
--restore-sparse-threshold=KB Threshold during restore to create sparse regions [128]
--restoreatreboot         Enable restore at reboot processing for windows protected files 
--restorehidden           Restore files that have the hidden attribute set [True]
--restoreshortnames       WINDOWS: Attempt to set short (8.3) names during restore 
--restoresystem           Restore files that have the system attribute set 
--restorewfp              Attempt to restore files under Windows File Protection 
--retention-type=type, --retentiontype Retention Type: none, daily, weekly, monthly, yearly 
--run-after-freeze=string, --run_after_freeze Backup only: Run this script after FREEZE is frozen 
--run-after-freeze-clauses=string, --run_after_freeze_clauses Use these clauses for the run after freeze script [desc=run-after-freeze]
--run-at-end=string, --run_at_end Run this script when avtar is done       
--run-at-end-clauses=string, --run_at_end_clauses Use these clauses for the run at end script [desc=run-at-end]
--run-at-start=string, --run_at_start Run this script at start of avtar        
--run-at-start-clauses=string, --run_at_start_clauses Use these clauses for the run at start script [desc=run-at-start]
--sequencenumber=n, --labelnumber Specify backup sequence number           
--server=IPADDR, --hfsaddr Avamar server address             HFSADDR 
--showlog, --showcomment  Show session log for the selected backup 
--skip-high-latency       During backup skip high-latency (offline) files 
--streamformat=n          Backup/Restore data from/to a stream of this format [none]
--target=PATH             Restore backup to specified PATH         
--testwfp                 Test Windows File Protection             
--to-stdout, -O           Extract files to standard output only    
--totals                  Show total size of backup at end of listing (list command only) 
--tryagain                Wait when server says to try again later [True]
--usage                   Print a list of available flags          
--verbose, -v             Set verboseness level                    
--version                 Display build version   


executable: avupdate
---------------
Usage: /usr/local/avamar/bin/avupdate [OPTION...]


--account=DEST, --path, --acnt Avamar server account path               
--appname=name            Name of app to run                       [/usr/local/avamar/bin/avupdate]
--avtarflags=name         avtarflags                               
--backup, -B              backup                                   
--backup-type=type        Backup Type                              
--browse                  browse                                   
--brtype=level            Select type of backup                    
--ctltest                 ctltest from command line                
--exclude-pluginid-list=string, --excludepluginids Avamar Excluded Plug-in Id List          
--execfailback            Executes the failback procedure in case of failure 
--expires=DAYS or Timestamp Backup expiration time                   
--failbackcomplete        run both failbackinstall and failbackcopy procedures 
--failbackcopy            failback copy the files from the local store directory 
--failbackinstall         run the installations from failback_directives.xml 
--failedavagentcheck      Behaves as failed avagent check procedure 
--flagfile=FILE           Specify file containing a list of flags  
--forcefull               forcefull                                [True]
--help, --he, --hel       Print this message                       
--id=user@domain/homeacnt Authentication Id                        
--informationals          Set informational level                  
--installer=name          Installer for test                       
--installersearchdir=name Search directory for old installers      
--installpacket=name      Install installation package msi,rpm...  
--installxml=name         Install xml file fullpath                
--labelnum=name           Snapup label                             
--logfile=FILE, --log     Specify logfile pathname                 
--noinformationals        Turn off info messages                   
--nostdout                Turn off output to the console           
--nowarnings              Turn off warnings                        
--ntauthentication        Use NT authentication with SQL server    [True]
--operation=name, --op    Command-line operation to perform        
--password=PSWD, --ap, --pswd Authentication password                  
--pipe                    Pipe all input/output from/to avtar      [True]
--plugin_names_xml=name   Path to xml file containing plugin installer names 
--pluginid-list=string, --pluginids Avamar Plug-in Id List                   
--pluginport=port         Port number to connect to agent on       [28002]
--plugintmpdir=name       Temporary directory for the plugin       
--postupgrade             perform the procedure post upgrade       
--quiet                   Suppress informational and warning messages 
--readhintsize=n          Read Hint Size                           [1048576]
--restore, -R             restore                                  
--restore-destination=name, --restore-option What kind of restore to do               none
--restoresystem           Attempt to restore database that have the system attribute set 
--retention-type=type, --retentiontype Retention Type: none, daily, weekly, monthly, yearly 
--retryavagentcheck=n     Retry the check of avagent connectivity to mcs [3]
--run-after-database=string, --run_after_database Run this script after a database snapup/restore/validate ends 
--run-after-database-clauses=string, --run_after_database_clauses Use these clauses for the run after db snapup/restore/validate (--run-after-database) script [desc=run-after-database]
--run-after-instance=string, --run_after_instance Run this script after any server instance processing ends 
--run-after-instance-clauses=string, --run_after_instance_clauses Use these clauses for the run after instance (--run-after-instance) script [desc=run-after-instance]
--run-at-end=string, --run_at_end Run this script at end of plugin run     
--run-at-end-clauses=string, --run_at_end_clauses Use these clauses for the run at end (--run-at-end) script [desc=run-at-end]
--run-at-end-for-each-database=string, --run_at_end_for_each_database Run this script once for each database at end of plugin run 
--run-at-end-for-each-database-clauses=string, --run_at_end_for_each_database_clauses Use these clauses for the run for each database at end (--run-at-end-for-each-database) script [desc=run-at-end-for-each-database]
--run-at-start=string, --run_at_start Run this script at start of plugin run   
--run-at-start-clauses=string, --run_at_start_clauses Use these clauses for the run at start (--run-at-start) script [desc=run-at-start]
--run-before-database=string, --run_before_database Run this script before a database snapup/restore/validate starts (skip-on-error clause can be used) 
--run-before-database-clauses=string, --run_before_database_clauses Use these clauses for the run before database snapup/restore/validate (--run-before-database) script [desc=run-before-database]
--run-before-instance=string, --run_before_instance Run this script before any server instance processing starts (skip-on-error clause can be used) 
--run-before-instance-clauses=string, --run_before_instance_clauses Use these clauses for the run before instance snapup/restore/validate (--run-before-instance) script [desc=run-before-instance]
--server=IPADDR, --hfsaddr Avamar server address             HFSADDR 
--skipstorefiles          skip storing the files during initial hase of update 
--storage=string          Storage                                  
--storageapp=name         Storage application for virtual device data (will use process) 
--storagedir=name         Storage directory for virtual device data (won't use process) 
--storagetype=name        Storage type                             [virtualdevice]
--storefiles              store the files from avamar home to failback location 
--target=name             Restore target (always in directed restore workorders) 
--testpostupdate          tests the post update procedure          
--testpreupdate           tests the pre update procedure           
--timing                  Print millisecond timing information     
--truncatelog             Truncate database log after successful backup 
--tryagain                Wait when server says to try again later [True]
--updatepassword=name     Update User Password                     [4vma3..]
--updateserver=name       Update Server Name                       [clients/supermint06.hermes.si]
--updatespawned           Set to true for copy avupdate spawned from avupdate 
--updateuser=name         Update User Name                         [root]
--usage                   Print a list of available flags          
--use-sql-replace-option, --usesqlreplaceoption Use SQL replace option during restore    
--verbose, -v             Set verboseness level                    
--version                 Display build version                    
--wait, --fWait           wait for completion                      [True]
