#!/usr/bin/perl -w

while($digit = <STDIN>){
	push @arr, $digit;
}


$i = $#arr + 1;
while ($i > 0) {
	$a = int(rand($i));
	push @new,$arr[$a];
	splice(@arr,$a,1);
	$i--;
}

print foreach (@new);
