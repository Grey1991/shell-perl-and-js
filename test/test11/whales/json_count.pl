#!/usr/bin/perl -w
open FILE, "<", $ARGV[1] or die;
chomp(@json = <FILE>);
$num = 0;
for ($i = 0;$i<scalar(@json);$i++){
    if ($json[$i] =~ /"species": "(.*)"/){
        $sepcie = $1;
        # print $1,"\n";
        if ($sepcie eq $ARGV[0]){
            $json[$i-1] =~ /"how_many": (\d+),/;
            $num += $1
            # print $current_num,"\n";
        }
    }
}
print $num,"\n";