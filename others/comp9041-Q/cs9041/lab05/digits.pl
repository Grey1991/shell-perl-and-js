#!/usr/bin/perl -w

while (<>) {
	s/[01234]/</g;
	s/[6789]/>/g;
	print;
}
 
