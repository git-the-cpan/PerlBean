use strict;
use PerlBean::Attribute::Multi::Unique::Ordered;
my $attr = PerlBean::Attribute::Multi::Unique::Ordered->new( {
    attribute_name => 'locations_in_traveling_salesman_itinerary',
    short_description => 'the locations in a traveling salesman\'s itinerary',
} );

use IO::File;
-d 'tmp' || mkdir('tmp');
my $fh = IO::File->new('> tmp/PerlBean_Attribute_Multi_Unique_Ordered.pl.out');
$attr->write_methods($fh);
$attr->write_doc_methods($fh);
1;
