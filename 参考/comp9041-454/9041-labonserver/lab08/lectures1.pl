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
