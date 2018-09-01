#!/usr/bin/perl -w
while ($input = <STDIN>){
	chomp $input;
	$input =~ /^(\d+)\s*(.*)$/ or die;
	$tmp = $2;
	$num = $1;
	$tmp =~ tr/[A-Z]/[a-z]/;
	$tmp =~ tr/' '/' '/s;
	$tmp =~ s/ $//g;
	$tmp =~ s/s$//i;
	


	if (not $data{$tmp}){
		$data{$tmp} = "$num";
	}
	else{
		$data{$tmp} = "$data{$tmp},$num";
	}
}


@key = keys %data;
@key = sort(@key);
foreach $key (@key){
	@arr = split(',',$data{$key});
	$sum=eval(join("+",@arr));
	$pod=$#arr+1;
	print "$key observations: $pod pods, $sum individuals\n";
}
