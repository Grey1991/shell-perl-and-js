#!/usr/bin/perl -w
while (<>) {
	s/[0123456789]//g;
	push @arr,$_;
	# print;
}
print @arr;