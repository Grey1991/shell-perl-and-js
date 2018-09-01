#!/usr/bin/perl -w
if (@ARGV==1){
$course=$ARGV[0];
$len=0;
@cl=();
$url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/$course.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
  if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
    $line=~ s/<\/p><p><strong>.*//;
    $line=~ s/.*<p>//;
    $line=~ s/Prerequisite: //;
    $line=~ s/Prerequisites: //;
    $line=~ s/pre-requisite //;
    while ($line=~ /[A-Z]{4}\d{4}/){
      $cl[$len]=$&;
      $line=~ s/[A-Z]{4}\d{4}//;
      $len++;
    }
  }
}
$url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/$course.html";
open F, "wget -q -O- $url|" or die;
while ($line = <F>) {
  if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
    $line=~ s/<\/p><p><strong>.*//;
    $line=~ s/.*<p>//;
    $line=~ s/Prerequisite: //;
    $line=~ s/Prerequisites: //;
    $line=~ s/pre-requisite //;
    while ($line=~ /[A-Z]{4}\d{4}/){
      $cl[$len]=$&;
      $line=~ s/[A-Z]{4}\d{4}//;
      $len++;
    }
  }
}
%count=();
@cl=grep { ++$count{ $_ } < 2 } @cl;
foreach $data(sort @cl){
  printf "$data\n";
}
}

if (@ARGV==2){
  $course=$ARGV[1];
  $len=0;
  @cl=();
  @cl2=();
  $url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/$course.html";
  open F, "wget -q -O- $url|" or die;
  while ($line = <F>) {
    if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
      $line=~ s/<\/p><p><strong>.*//;
      $line=~ s/.*<p>//;
      $line=~ s/Prerequisite: //;
      $line=~ s/Prerequisites: //;
      $line=~ s/pre-requisite //;
      while ($line=~ /[A-Z]{4}\d{4}/){
        $cl[$len]=$&;
        $line=~ s/[A-Z]{4}\d{4}//;
        $len++;
      }
    }
  }
  $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/$course.html";
  open F, "wget -q -O- $url|" or die;
  while ($line = <F>) {
    if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
      $line=~ s/<\/p><p><strong>.*//;
      $line=~ s/.*<p>//;
      $line=~ s/Prerequisite: //;
      $line=~ s/Prerequisites: //;
      while ($line=~ /[A-Z]{4}\d{4}/){
        $cl[$len]=$&;
        $line=~ s/[A-Z]{4}\d{4}//;
        $len++;
      }
    }
  }

  @cl3=();
  @cl3=@cl;
  @cl2=@cl;

  while(@cl2!=0){
      $ns=$cl2[0];
      $url = "http://www.handbook.unsw.edu.au/undergraduate/courses/2017/$ns.html";
      open F, "wget -q -O- $url|" or die;
      while ($line = <F>) {
        if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
          $line=~ s/<\/p><p><strong>.*//;
          $line=~ s/.*<p>//;
          $line=~ s/Prerequisite: //;
          $line=~ s/Prerequisites: //;
          $line=~ s/pre-requisite //;
          while ($line=~ /[A-Z]{4}\d{4}/){
            $cl[$len]=$&;
            push @cl2, $&;
            $line=~ s/[A-Z]{4}\d{4}//;
            $len++;
          }
  }
 }
 shift @cl2;
 }

 while(@cl3!=0){
   $ns=$cl3[0];
     $url = "http://www.handbook.unsw.edu.au/postgraduate/courses/2017/$ns.html";
     open F, "wget -q -O- $url|" or die;
     while ($line = <F>) {
       if ($line=~ /<p>Prerequisite:|<p>Prerequisites:/){
         $line=~ s/<\/p><p><strong>.*//;
         $line=~ s/.*<p>//;
         $line=~ s/Prerequisite: //;
         $line=~ s/Prerequisites: //;
         $line=~ s/pre-requisite //;
         while ($line=~ /[A-Z]{4}\d{4}/){
           $cl[$len]=$&;
           push @cl3, $&;
           $line=~ s/[A-Z]{4}\d{4}//;
           $len++;
         }
   }
 }
 shift @cl3;
}
%count=();
@cl=grep { ++$count{ $_ } < 2 } @cl;
foreach $data(sort @cl){
  printf "$data\n";
}


}
