#!/usr/bin/perl -w


$a = int(3/2);
print $a;

# $line = "\twhile x <= 10: print(x); x = x + 1";
#
# sub std_format{                                ## for std format
#   my ($in) = @_;
#   $in =~ s/([+*\-\/=<>%])/ $1 /g;
#   $in =~ tr/" "/" "/s;
#   $in =~ s/= =/==/g;
#   $in =~ s/> =/>=/g;
#   $in =~ s/< =/<=/g;
#   $in =~ s/\/ \//\/\//g;
#   return $in;
# }
# $line = std_format($line);
# if ($line =~/^(\s*)(.*)/) {
#   print $1,$2;
# }

# if ($line =~ /(^\s*)while (.*): (.+)$/){
#   my $indent = $1;
#   my $condition = $2;
#   my @statements = split /; /, $3;
#   foreach my $statement (@statements){
#     $statement =~ s/^/\t$indent/;
#   }
#   print join "|",@statements;
#
# }
# @a = (1,2,3);
# @b = (4,5);
# @c = (@a,@b);
# print join "|",@c;
# print "\n";

# sub push_distinct{                              #push distinct element
#   my (@arr) = @_;
#   $element = pop @arr;
#   foreach my $x (@arr){
#     return @arr if $x eq $element;
#   }
#   return (@arr, $element);
# }
#
# @arr = push_distinct(@arr, "123");
# @arr = push_distinct(@arr, "123");
# @arr = push_distinct(@arr, "123");
# @arr = push_distinct(@arr, "124");
#
# print @arr;
