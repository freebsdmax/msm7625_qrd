### created by junj@qualcomm.com , 2011-02-20 ###

$cfgfile="mv2proprietary.cfg";
$movelog="mv2os.log";




sub usage()
{
	print "Usage: perl $0\n";
	print "\nCopy files in $movelog back, from qrd-proprietary to opensource \n";
	exit 1;
}

	
usage if (@ARGV != 0);

##get script dir##
$script=$0;
@scripts=split /\//,$script;
pop @scripts;
$scriptdir=join '/',@scripts;
$cfgfile=$scriptdir."/".$cfgfile;
$movelog=$scriptdir."/".$movelog;

$propbase="vendor/qcom/qrd-proprietary/";




##check pwd
system "ls frameworks packages hardware vendor> /dev/null";
$ckpwd=$?;

if ($ckpwd != 0)
{
	print "\033[31mMust run this script in code root directory,aborting\033[m\n";
	exit 1;
}

##git diff for each directory##
open (FILE,"${cfgfile}") || die "can't open $cfgfile: $!\n";

while (<FILE>)
{
	chomp;
	s/^\s+//;
	s/\s+$//;
	next if (/^#/ || !/\S+/) ;
	
	$mvtype="$'",next if /MVTYPE=/ ;
	$mvdir=$',next if /MVDIR=/ ;
	$exception=$',next if /EXCEPTION=/ ;
}
close FILE;

@dirs=split /\s+/,$mvdir;

open (LOGFILE,">$movelog") || die "can't create $movelog:$!\n";
print LOGFILE "### $datetime ###\n";
			
			
			
#### mv to opensource ####
$num=0;
foreach $mv2osdir (@dirs)
{
				chomp $mv2osdir;
				
				$from=$propbase.$mv2osdir;
				system "ls -d $from >/dev/null 2>/dev/null";
				next if $?;
				
				system "mkdir -p $mv2osdir;cp -rf ${from}/* $mv2osdir";
				if ($?)
				{
					print "\n******Fatal error when copy from $from to $to , exit*******\n";
					exit 1;
				}
				
				print "copy from ${from}/* to $mv2osdir .. done\n";
				system"rm -rf ${from}";
				print LOGFILE $from."\n" ;
								
}
close LOGFILE;
		
print "\n****** DONE *******\n";
	
