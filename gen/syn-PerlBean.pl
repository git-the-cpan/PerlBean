use strict;
use PerlBean;
use PerlBean::Attribute::Factory;

my $bean = PerlBean->new();
my $factory = PerlBean::Attribute::Factory->new();
my $attr = $factory->create_attribute( {
    attribute_name => 'true',
    short_description => 'something is true',
} );
$bean->add_attribute($attr);

use IO::File;
-d 'tmp' || mkdir('tmp');
my $fh = IO::File->new('> tmp/PerlBean.pl.out');
$bean->write($fh);
1;
