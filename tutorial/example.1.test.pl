#!/usr/bin/perl

use strict;
use lib qw( example.1 );

use Circle;
my $circle = Circle->new( {
    radius => 1,
} );
print 'Circle with radius ', $circle->get_radius(),
      ' has an area of ', $circle->area(), "\n";

use Square;
my $square = Square->new( {
    width => 1,
} );
print 'Square with width ', $square->get_width(),
      ' has an area of ', $square->area(), "\n";

use Rectangle;
my $rectangle = Rectangle->new( {
    width => 1,
    height => 2,
} );
print 'Rectangle with width ', $rectangle->get_width(),
      ' and with height ', $rectangle->get_height(),
      ' has an area of ', $rectangle->area(), "\n";
