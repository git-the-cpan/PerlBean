use strict;
use PerlBean::Attribute::Single;
my $attr = PerlBean::Attribute::Single->new ({
	attribute_name => 'name',
	short_description => 'my name',
});

use IO::File;
-d 'tmp' || mkdir ('tmp');
my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Single.pl.out');
$attr->writeMethods ($fh);
$attr->writeDocMethods ($fh);
1;
