use strict;
use PerlBean;
use PerlBean::Collection;
use PerlBean::Attribute::Factory;

my $bean = PerlBean->new ({
	package => 'Athlete',
});
my $factory = PerlBean::Attribute::Factory->new ();
my $attr = $factory->createAttribute ({
	attribute_name => 'name',
	short_description => 'the name of the athlete',
});
$bean->addAttribute ($attr->getAttributeName (), $attr);

my $bean2 = PerlBean->new ({
	package => 'Cyclist',
	base => [ qw (Athlete)],
});
my $factory = PerlBean::Attribute::Factory->new ();
my $attr2 = $factory->createAttribute ({
	attribute_name => 'cycle',
	short_description => 'the cyclist\'s cycle',
});
$bean2->addAttribute ($attr2->getAttributeName (), $attr2);

my $collection = PerlBean::Collection->new ();
$collection->addBean ($bean->getPackage (), $bean);
$collection->addBean ($bean2->getPackage (), $bean2);
$collection->write ('tmp');
1;
