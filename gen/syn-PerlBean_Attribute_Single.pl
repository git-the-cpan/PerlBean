use strict;
use PerlBean::Attribute::Single;
my $attr = PerlBean::Attribute::Single->new( {
    attribute_name => 'name',
    short_description => 'my name',
} );

use IO::File;
-d 'tmp' || mkdir('tmp');
my $fh = IO::File->new('> tmp/PerlBean_Attribute_Single.pl.out');
$attr->write_methods($fh);
$attr->write_doc_methods($fh);
1;
