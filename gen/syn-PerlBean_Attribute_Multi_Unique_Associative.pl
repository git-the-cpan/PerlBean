use strict;
use PerlBean::Attribute::Multi::Unique::Associative;
my $attr = PerlBean::Attribute::Multi::Unique::Associative->new( {
    attribute_name => 'ssns_i_know_from_people',
    short_description => 'all SSNs I know from people',
} );

use IO::File;
-d 'tmp' || mkdir('tmp');
my $fh = IO::File->new('> tmp/PerlBean_Attribute_Multi_Unique_Associative.pl.out');
$attr->write_methods($fh);
$attr->write_doc_methods($fh);
1;
