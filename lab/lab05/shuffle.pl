#!/usr/bin/perl -w
while($digit = <STDIN>){
	push @arr, $digit;
}

for ($i=$#arr+1;$i>0;$i--) {
  $line_num = int(rand($i));
  push @result, $arr[$line_num];
  splice(@arr, $line_num, 1);
}
print foreach(@result);
