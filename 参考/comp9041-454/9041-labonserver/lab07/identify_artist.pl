#!/usr/bin/perl -w
if ($ARGV[0] eq '-d'){
  $filename=$ARGV[1];
%cl=();
@word_list=();
open F,'<',"$filename" or die;
while ($line=<F>){
    push @word_list, $line=~ /\b[a-z]+\b/ig;
}
for $i(@word_list){
  $word=$i;
  %cw=();
  %ct=();

  foreach $file (glob "lyrics/*.txt") {
          $len=0;
          $len2=0;
          open F,'<',"$file" or die;
          while ($line=<F>){
            @a=$line=~ /\b$word\b/ig;
            $len+=@a;
            @b=$line=~ /[a-zA-Z]+/g;
            $len2+=@b;
          }
          $file=~ s/.*\///;
          $file=~ s/.txt//;
          $file=~ s/[^a-z]/ /gi;
          $cw{$file}=$len;
          $ct{$file}=$len2;
          $cl{$file}+=log(($cw{$file}+1)/$ct{$file});
  }
}


$flag=0;
$result=0;
foreach my $i (sort{$cl{$a} cmp $cl{$b} } keys %cl) {
    printf "$filename: log_probability of %.1f for $i\n",$cl{$i};
    if ($flag==0){
      $result=$i;
      $flag=1;
    }
}
printf "$filename most resembles the work of $result (log-probability=%.1f)\n",$cl{$result};
}
else {
    foreach $filename (@ARGV){
      %cl=();
      @word_list=();
      open F,'<',"$filename" or die;
      while ($line=<F>){
          push @word_list, $line=~ /\b[a-z]+\b/ig;
      }
      for $i(@word_list){
        $word=$i;
        %cw=();
        %ct=();

        foreach $file (glob "lyrics/*.txt") {
          $len=0;
          $len2=0;
          open F,'<',"$file" or die;
          while ($line=<F>){
            @a=$line=~ /\b$word\b/ig;
            $len+=@a;
            @b=$line=~ /[a-zA-Z]+/g;
            $len2+=@b;
          }
          $file=~ s/.*\///;
          $file=~ s/.txt//;
          $file=~ s/[^a-z]/ /gi;
          $cw{$file}=$len;
          $ct{$file}=$len2;
          $cl{$file}+=log(($cw{$file}+1)/$ct{$file});
        }

    }

    $flag=0;
    $result=0;
    foreach my $i (sort{$cl{$a} cmp $cl{$b} } keys %cl) {
        if ($flag==0){
          $result=$i;
          $flag=1;
          last;
        }
    }
    printf "$filename most resembles the work of $result (log-probability=%.1f)\n",$cl{$result};
  }
}
