#!/usr/bin/perl -w
$word = shift @ARGV;
$word =~ tr /[A-Z]/[a-z]/;
$word =~ s/[^a-z]//g;
@letter = split //,$word;
$flag = 1;
foreach $i (0..$#letter){
    # print "$letter[$i]","\n";
    # print "$letter[-($i + 1)]","\n";
    if ($letter[$i] ne $letter[-($i + 1)]){
        $flag = 0;
    }
}
if ($flag){
    print "TRUE\n";
}else{
    print "FALSE\n";
}



# import sys
# l=[char.lower() for char in sys.argv[1] if char.isalpha()]
# print(True) if l[::-1] == l else print(False)
