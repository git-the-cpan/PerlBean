use strict;
use PerlBean;
use PerlBean::Collection;
use PerlBean::Attribute::Factory;

my $bean = PerlBean->new( {
    package => 'Athlete',
} );
my $factory = PerlBean::Attribute::Factory->new();
my $attr = $factory->create_attribute( {
    attribute_name => 'name',
    short_description => 'the name of the athlete',
} );
$bean->add_attribute($attr);

my $bean2 = PerlBean->new( {
    package => 'Cyclist',
    base => [ qw(Athlete)],
} );
my $factory = PerlBean::Attribute::Factory->new();
my $attr2 = $factory->create_attribute( {
    attribute_name => 'cycle',
    short_description => 'the cyclist\'s cycle',
} );
$bean2->add_attribute($attr2);

my $collection = PerlBean::Collection->new();
$collection->add_perl_bean($bean);
$collection->add_perl_bean($bean2);
$collection->write('tmp');
1;
