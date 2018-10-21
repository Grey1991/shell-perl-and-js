#!/usr/bin/perl -w
$flag=0;
@need_printlist=();
while ($line=<STDIN>){
    @line_list=split(/\s+/,$line);
    foreach $word (@line_list){
        %char_occ=();
        @occ_times=();
        @char_list=split(//,$word);
        foreach $char (@char_list){
            $char=~ tr/A-Z/a-z/;
            $char_occ{$char}++;
        }
        foreach $char_key (keys %char_occ){
            push @occ_times,$char_occ{$char_key};
        }
        $first_ele=$occ_times[0];
        foreach $occ (@occ_times){
            if ($occ!=$first_ele){
                $flag=1;
                last;
            }
        }
        if ($flag==0){
            push @need_printlist, $word;
            push @need_printlist, " ";
        }
        else{
            $flag=0;
        }
    }
    push @need_printlist, "\n";
}
foreach $i (@need_printlist){
    print "$i";
}
