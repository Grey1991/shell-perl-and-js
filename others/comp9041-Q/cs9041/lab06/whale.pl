#!/usr/bin/perl -w
while ($input = <STDIN>){
	chomp $input;
	$input =~ /(\d+) (.*)/;
	if (not $data{$2}){
		$data{$2} = "$1";
	}
	else{
		$data{$2} = "$data{$2},$1"
	}
}

$target = shift @ARGV or die;

if ($data{$target}) {
	@arr = split(',',$data{$target});
	$sum=eval(join("+",@arr));
	$pod=$#arr+1;
	print "$target observations: $pod pods, $sum individuals","\n";
}
else{
	print "$target observations: 0 pods, 0 individuals","\n";
}
