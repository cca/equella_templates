#!/usr/bin/env perl

## if the script isn't working make sure to set permissions
## for the file to be executable
## chmod 755 ProcessFiles.pl

## A couple of settings that make the warnings more verbose
## Also makes the programming a little less forgiving
use warnings;
use strict;
# turn off some warnings -EJP
no warnings 'uninitialized';

## Declaring the variables - good programming
my $name;
my $id;
my $username;
my $admitStatus;
my $program;
my $startTerm;
my $currentStatus;
###### THE PROBLEM WAS THAT YOU DIDN'T DECLARE THE VARIABLE HERE FIRST
###### IT WOULDN'T ORDINARILY BE A PROBLEM, BUT I TOLD IT TO USE STRICT ABOVE
###### I ADDED BOTH TERM AND YEAR AS YEAR WOULD HAVE GIVEN THE SAME ERROR
my $term;
my $year;
my @linearray;

## if there are no arguments print the usage block
## if there are more than one argument barf and make
## a suggestion

if ($#ARGV < 0) {
    print q{
=============================================================
|                                                           |
|                  Coded by Cian Phillips - 2014            |
|              For California College of the Arts           |
|                                                           |
|-----------------------------------------------------------|
|             Syntax - ProcessFiles.pl ARG1                 |
|                                                           |
=============================================================
};
    exit;
} elsif ($#ARGV > 0) {
    print "
    You have provided too many arguments, I'm confused.
    Check to make sure you have escaped or used single quotes
    if your filename has spaces in it.\n\n";
    exit;
}


## Sets the variable $filename to the first argument after ProcessFiles.pl
	my $filename = $ARGV[0];
## Opens the file and readies it for reading
open(my $filehandle, '<', $filename) or die "Could not open $filename\n";

## declare the special array variable type (good programming practice)
my @resultarray;

## Loops through the file line by line
## Put each line read into the $line variable
while(my $line = <$filehandle>){
	## Chomp just removes the last character (usually a return character)
    chomp $line;
    ## removes double quotes at the start of a line
    $line=~ s/^\"//;
    ## removes double quotes at the end of a line
    $line=~ s/\"$//;
    ## splits each line on "," into an array
    ## puts each value in the @linearray array into an easy to use variable
     @linearray = split(/\"\,\"/, $line);
     $name = $linearray['0'];
     $id = $linearray['1'];
     $username = $linearray['2'];
     $admitStatus = $linearray['3'];
     $program = $linearray['4'];
     $startTerm = $linearray['5'];
     $currentStatus = $linearray['6'];

     if(! defined $username){
     	$username = "TBD";
     }
     if(! defined $program){
     	$program = "TBD";
     }

## take the sixth field 2014SP and split it into human readable $term and $year
## the =~ indicates a following regular expression that starts and ends with /
## the parens group the 'found' items which are referred to by variables named
## with their numeric order - the lower case 'd's mean digit and are escaped with
## a forward slash so it's not looking for a literal d character - uppercase 'D's
## match two non-numeric characters and plop them into the $2 variable
## if the value of $term doesn't match the 2014SP format die and throw an error
    if($startTerm =~ /(\d\d\d\d)(\D\D)/) {
    	my $year = $1;
## if the non numeric characters match SP or FA convert them to the nicer human
## readable form and it if it doesn't match die and throw an error.
    	if($2 eq "SP"){
    		$term = "Spring";
    	}elsif ($2 eq "FA"){
    		$term = "Fall";
    	}else{
    		die "unrecognized term (not FA or SP)\n";
    	}
## take the value for student major and convert to CCA-student-major taxonomy values
	if($program eq "ANIMA"){
			$program = "Animation (BFA)";
		}elsif ($program eq "ARCHT"){
			$program = "Architecture (BArch)";
		}elsif ($program eq "CERAM"){
			$program = "Ceramics (BFA)";
		}elsif ($program eq "COMAR"){
			$program = "Community Arts (BFA)";
		}elsif ($program eq "FASHN"){
			$program = "Fashion Design (BFA)";
		}elsif ($program eq "FILMS"){
			$program = "Film (BFA)";
		}elsif ($program eq "FURNT"){
			$program = "Furniture (BFA)";
		}elsif ($program eq "GLASS"){
			$program = "Glass (BFA)";
		}elsif ($program eq "GRAPH"){
			$program = "Graphic Design (BFA)";
		}elsif ($program eq "ILLUS"){
			$program = "Illustration (BFA)";
		}elsif ($program eq "INDIV"){
			$program = "Individualized Major (BFA)";
		}elsif ($program eq "INDUS"){
			$program = "Industrial Design (BFA)";
		}elsif ($program eq "IXDSN"){
			$program = "Interaction Design (BFA)";
		}elsif ($program eq "INTER"){
			$program = "Interior Design (BFA)";
		}elsif ($program eq "METAL"){
			$program = "Jewelry / Metal Arts (BFA)";
		}elsif ($program eq "PNTDR"){
			$program = "Painting/Drawing (BFA)";
		}elsif ($program eq "PHOTO"){
			$program = "Photography (BFA)";
		}elsif ($program eq "PRINT"){
			$program = "Printmaking (BFA)";
		}elsif ($program eq "SCULP"){
			$program = "Sculpture (BFA)";
		}elsif ($program eq "TEXTL"){
			$program = "Textiles (BFA)";
		}elsif ($program eq "UNDEC"){
			$program = "undeclared major";
		}elsif ($program eq "VISST"){
			$program = "Visual Studies (BA)";
		}elsif ($program eq "WRLIT"){
			$program = "Writing and Literature (BA)";
		}
    	##my	$equellaready = "\"$name\",ID,$id,username,$username,admitStatus,$admitStatus,program,$program,startTerm,$term $year,currentStatus,$currentStatus,\n";
    	my $equellaready = '"'.$name.'",ID,'.$id.',username,'.$username.',admitStatus,'.$admitStatus.',program,'.$program.',startTerm,'.$term.' '.$year.',currentStatus,'.$currentStatus.",\n";
    	print $equellaready;
    }else{
    	die "I don't recognize the values in the first field of the input file";
    }

##    push(@resultarray, @linearray);
}
