use strict;
use PerlBean::Attribute::Multi::Unique;
my $attr = PerlBean::Attribute::Multi::Unique->new( {
    attribute_name => 'ssns_i_can_remember',
    short_description => 'all SSNs I can remember',
} );

use IO::File;
-d 'tmp' || mkdir('tmp');
my $fh = IO::File->new('> tmp/PerlBean_Attribute_Multi_Unique.pl.out');
$attr->write_methods($fh);
$attr->write_doc_methods($fh);
1;
