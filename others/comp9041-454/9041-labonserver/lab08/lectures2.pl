#!/usr/bin/perl -w
if ($ARGV[0] eq '-d'){
  for($l=1;$l<=$#ARGV;$l++){
      $course=$ARGV[$l];
      $start_flag=0;
      $i=0;
      @result_list=();
      $url = "http://timetable.unsw.edu.au/current/$course.html";
      open F, "wget -q -O- $url|" or die;
      while ($line = <F>) {
        if ($line=~/<td class=.*><a href=.*>Lecture<\/a><\/td>/){
            $start_flag=1;
        }
        if ($start_flag==1){
          $i++;
        }
        if ($i==2){
          if ($line=~ /T1/){
            push @result_list,"S1";
          }
          if ($line=~ /T2/){
            push @result_list,"S2";
          }
        }
        if ($i==7){
          $line=~ /<td class="data">(.*)<\/td>/;
          push @result_list, $1;
          $start_flag=0;
          $i=0;
        }
      }
      @re_tot=();
      for($k=0;$k<=$#result_list;$k=$k+2){
        if ($result_list[$k+1] ne ''){
            $curr_line="$course: "."$result_list[$k]"." $result_list[$k+1]\n";
            push @re_tot,$curr_line;
        }
      }
      %count=();
      @re_tot=grep { ++$count{ $_ } < 2 } @re_tot;
      @re2=();
      foreach $i(@re_tot){
        if ($i=~/S1/){
          $semester='S1';
        }
        if ($i=~/S2/){
          $semester='S2';
        }
        $i=~ /([A-Z]{4}\d{4})/;
        $code=$1;
        $i=~ s/[A-Z]{4}\d{4}: S[12] //;
        @a=split(/, /,$i);
        foreach $m(@a){
          $m=~ /([A-Z][a-z][a-z])/;
          $week=$1;
          $m=~/(\d{2}):\d{2} - (\d{2}):(\d{2})/;
          $t_start=$1;
          $t_end=$2;
          if ($3 ne '00'){
            $t_start=$t_start+1;
          }
          if ($t_start=~ /0\d/){
            $t_start=~ s/0//;
          }
          if ($t_end=~ /0\d/){
            $t_end=~ s/0//;
          }
          for($n=$t_start;$n<$t_end;$n++){
              push @re2,"$semester"." $code"." $week"." $n\n";
          }
        }
      }
      %count=();
      @re2=grep { ++$count{ $_ } < 2 } @re2;
      foreach $s(@re2){
        printf "$s";
      }
  }

}
elsif ($ARGV[0] eq '-t') {
  @re2=();
  %week_list=();
  for($l=1;$l<=$#ARGV;$l++){
      $course=$ARGV[$l];
      $start_flag=0;
      $i=0;
      @result_list=();
      $url = "http://timetable.unsw.edu.au/current/$course.html";
      open F, "wget -q -O- $url|" or die;
      while ($line = <F>) {
        if ($line=~/<td class=.*><a href=.*>Lecture<\/a><\/td>/){
            $start_flag=1;
        }
        if ($start_flag==1){
          $i++;
        }
        if ($i==2){
          if ($line=~ /T1/){
            push @result_list,"S1";
          }
          if ($line=~ /T2/){
            push @result_list,"S2";
          }
        }
        if ($i==7){
          $line=~ /<td class="data">(.*)<\/td>/;
          push @result_list, $1;
          $start_flag=0;
          $i=0;
        }
      }
      @re_tot=();
      for($k=0;$k<=$#result_list;$k=$k+2){
        if ($result_list[$k+1] ne ''){
            $curr_line="$course: "."$result_list[$k]"." $result_list[$k+1]\n";
            push @re_tot,$curr_line;
        }
      }
      %count=();
      @re_tot=grep { ++$count{ $_ } < 2 } @re_tot;

      foreach $i(@re_tot){
        if ($i=~/S1/){
          $semester='S1';
        }
        if ($i=~/S2/){
          $semester='S2';
        }
        $i=~ /([A-Z]{4}\d{4})/;
        $code=$1;
        $i=~ s/[A-Z]{4}\d{4}: S[12] //;
        @a=split(/, /,$i);
        foreach $m(@a){
          $m=~ /([A-Z][a-z][a-z])/;
          $week=$1;
          $m=~/(\d{2}):\d{2} - (\d{2}):(\d{2})/;
          $t_start=$1;
          $t_end=$2;
          if ($3 ne '00'){
            $t_start=$t_start+1;
          }
          if ($t_start=~ /0\d/){
            $t_start=~ s/0//;
          }
          if ($t_end=~ /0\d/){
            $t_end=~ s/0//;
          }
          for($n=$t_start;$n<$t_end;$n++){
              push @re2,"$semester"." $code"." $week"." $n\n";
          }
        }
      }
      %count=();
      @re2=grep { ++$count{ $_ } < 2 } @re2;
  }

  %sem1_list=();
  %sem2_list=();
  foreach $i(@re2){
    if ($i=~ /S1/){
      push @sem1_list, $i;
    }
    if ($i=~ /S2/){
      push @sem2_list,$i;
    }
  }
  foreach $s(@sem1_list){
    $s=~ s/S1 [A-Z]{4}\d{4} //;
    $s=~ /([A-Z][a-z][a-z]) (\d{1,2})/;
    $week_list{$1}{$2}++;
  }

  for($i=9;$i<=20;$i++){
      if (!($week_list{'Mon'}{$i})){
          $week_list{'Mon'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Tue'}{$i})){
          $week_list{'Tue'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Wed'}{$i})){
          $week_list{'Wed'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Thu'}{$i})){
          $week_list{'Thu'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Fri'}{$i})){
          $week_list{'Fri'}{$i}=' ';
      }
  }
  $empty_flag=0;
  foreach $m(keys %week_list){
    foreach $n(keys $week_list{$m}){
      if ($week_list{$m}{$n} ne ' '){
          $empty_flag=1;
      }
    }
  }


  if ($empty_flag==1){
    printf "S1       Mon   Tue   Wed   Thu   Fri\n";
    printf "09:00     $week_list{'Mon'}{9}     $week_list{'Tue'}{9}     $week_list{'Wed'}{9}     $week_list{'Thu'}{9}     $week_list{'Fri'}{9}\n";
    printf "10:00     $week_list{'Mon'}{10}     $week_list{'Tue'}{10}     $week_list{'Wed'}{10}     $week_list{'Thu'}{10}     $week_list{'Fri'}{10}\n";
    printf "11:00     $week_list{'Mon'}{11}     $week_list{'Tue'}{11}     $week_list{'Wed'}{11}     $week_list{'Thu'}{11}     $week_list{'Fri'}{11}\n";
    printf "12:00     $week_list{'Mon'}{12}     $week_list{'Tue'}{12}     $week_list{'Wed'}{12}     $week_list{'Thu'}{12}     $week_list{'Fri'}{12}\n";
    printf "13:00     $week_list{'Mon'}{13}     $week_list{'Tue'}{13}     $week_list{'Wed'}{13}     $week_list{'Thu'}{13}     $week_list{'Fri'}{13}\n";
    printf "14:00     $week_list{'Mon'}{14}     $week_list{'Tue'}{14}     $week_list{'Wed'}{14}     $week_list{'Thu'}{14}     $week_list{'Fri'}{14}\n";
    printf "15:00     $week_list{'Mon'}{15}     $week_list{'Tue'}{15}     $week_list{'Wed'}{15}     $week_list{'Thu'}{15}     $week_list{'Fri'}{15}\n";
    printf "16:00     $week_list{'Mon'}{16}     $week_list{'Tue'}{16}     $week_list{'Wed'}{16}     $week_list{'Thu'}{16}     $week_list{'Fri'}{16}\n";
    printf "17:00     $week_list{'Mon'}{17}     $week_list{'Tue'}{17}     $week_list{'Wed'}{17}     $week_list{'Thu'}{17}     $week_list{'Fri'}{17}\n";
    printf "18:00     $week_list{'Mon'}{18}     $week_list{'Tue'}{18}     $week_list{'Wed'}{18}     $week_list{'Thu'}{18}     $week_list{'Fri'}{18}\n";
    printf "19:00     $week_list{'Mon'}{19}     $week_list{'Tue'}{19}     $week_list{'Wed'}{19}     $week_list{'Thu'}{19}     $week_list{'Fri'}{19}\n";
    printf "20:00     $week_list{'Mon'}{20}     $week_list{'Tue'}{20}     $week_list{'Wed'}{20}     $week_list{'Thu'}{20}     $week_list{'Fri'}{20}\n";
  }

  $empty_flag2=0;
  %week_list=();
  foreach $s(@sem2_list){
    $s=~ s/S2 [A-Z]{4}\d{4} //;
    $s=~ /([A-Z][a-z][a-z]) (\d{1,2})/;
    $week_list{$1}{$2}++;
  }

  for($i=9;$i<=20;$i++){
      if (!($week_list{'Mon'}{$i})){
          $week_list{'Mon'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Tue'}{$i})){
          $week_list{'Tue'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Wed'}{$i})){
          $week_list{'Wed'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Thu'}{$i})){
          $week_list{'Thu'}{$i}=' ';
      }
  }
  for($i=9;$i<=20;$i++){
      if (!($week_list{'Fri'}{$i})){
          $week_list{'Fri'}{$i}=' ';
      }
  }
  foreach $m(keys %week_list){
    foreach $n(keys $week_list{$m}){
      if ($week_list{$m}{$n} ne ' '){
          $empty_flag2=1;
      }
    }
  }

  if ($empty_flag2==1){
    printf "S2       Mon   Tue   Wed   Thu   Fri\n";
    printf "09:00     $week_list{'Mon'}{9}     $week_list{'Tue'}{9}     $week_list{'Wed'}{9}     $week_list{'Thu'}{9}     $week_list{'Fri'}{9}\n";
    printf "10:00     $week_list{'Mon'}{10}     $week_list{'Tue'}{10}     $week_list{'Wed'}{10}     $week_list{'Thu'}{10}     $week_list{'Fri'}{10}\n";
    printf "11:00     $week_list{'Mon'}{11}     $week_list{'Tue'}{11}     $week_list{'Wed'}{11}     $week_list{'Thu'}{11}     $week_list{'Fri'}{11}\n";
    printf "12:00     $week_list{'Mon'}{12}     $week_list{'Tue'}{12}     $week_list{'Wed'}{12}     $week_list{'Thu'}{12}     $week_list{'Fri'}{12}\n";
    printf "13:00     $week_list{'Mon'}{13}     $week_list{'Tue'}{13}     $week_list{'Wed'}{13}     $week_list{'Thu'}{13}     $week_list{'Fri'}{13}\n";
    printf "14:00     $week_list{'Mon'}{14}     $week_list{'Tue'}{14}     $week_list{'Wed'}{14}     $week_list{'Thu'}{14}     $week_list{'Fri'}{14}\n";
    printf "15:00     $week_list{'Mon'}{15}     $week_list{'Tue'}{15}     $week_list{'Wed'}{15}     $week_list{'Thu'}{15}     $week_list{'Fri'}{15}\n";
    printf "16:00     $week_list{'Mon'}{16}     $week_list{'Tue'}{16}     $week_list{'Wed'}{16}     $week_list{'Thu'}{16}     $week_list{'Fri'}{16}\n";
    printf "17:00     $week_list{'Mon'}{17}     $week_list{'Tue'}{17}     $week_list{'Wed'}{17}     $week_list{'Thu'}{17}     $week_list{'Fri'}{17}\n";
    printf "18:00     $week_list{'Mon'}{18}     $week_list{'Tue'}{18}     $week_list{'Wed'}{18}     $week_list{'Thu'}{18}     $week_list{'Fri'}{18}\n";
    printf "19:00     $week_list{'Mon'}{19}     $week_list{'Tue'}{19}     $week_list{'Wed'}{19}     $week_list{'Thu'}{19}     $week_list{'Fri'}{19}\n";
    printf "20:00     $week_list{'Mon'}{20}     $week_list{'Tue'}{20}     $week_list{'Wed'}{20}     $week_list{'Thu'}{20}     $week_list{'Fri'}{20}\n";
  }
}
else {
  foreach $course (@ARGV){
    $start_flag=0;
    $i=0;
    @result_list=();
    $url = "http://timetable.unsw.edu.au/current/$course.html";
    open F, "wget -q -O- $url|" or die;
    while ($line = <F>) {
      if ($line=~/<td class=.*><a href=.*>Lecture<\/a><\/td>/){
          $start_flag=1;
      }
      if ($start_flag==1){
        $i++;
      }
      if ($i==2){
        if ($line=~ /T1/){
          push @result_list,"S1";
        }
        if ($line=~ /T2/){
          push @result_list,"S2";
        }
      }
      if ($i==7){
        $line=~ /<td class="data">(.*)<\/td>/;
        push @result_list, $1;
        $start_flag=0;
        $i=0;
      }
    }
    @re_tot=();
    for($k=0;$k<=$#result_list;$k=$k+2){
      if ($result_list[$k+1] ne ''){
          $curr_line="$course: "."$result_list[$k]"." $result_list[$k+1]\n";
          push @re_tot,$curr_line;
      }
    }
    %count=();
    @re_tot=grep { ++$count{ $_ } < 2 } @re_tot;
    foreach $i(@re_tot){
      printf "$i";
    }
  }
}
