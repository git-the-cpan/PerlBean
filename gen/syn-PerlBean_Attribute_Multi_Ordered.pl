use strict;
use PerlBean::Attribute::Multi::Ordered;
my $attr = PerlBean::Attribute::Multi::Ordered->new ({
	attribute_name => 'note_to_self',
	short_description => 'my notes to self',
});

use IO::File;
-d 'tmp' || mkdir ('tmp');
my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Multi_Ordered.pl.out');
$attr->writeMethods ($fh);
$attr->writeDocMethods ($fh);
1;
