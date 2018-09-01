#!/usr/bin/perl -w
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
