use strict;
use PerlBean::Attribute::Factory;
my $factory = PerlBean::Attribute::Factory->new ();
my $attr = $factory->createAttribute ({
	type => 'BOOLEAN',
	attribute_name => 'true',
	short_description => 'something is true',
});

use IO::File;
-d 'tmp' || mkdir ('tmp');
my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Factory.pl.out');
$attr->writeMethods ($fh);
$attr->writeDocMethods ($fh);
1;
