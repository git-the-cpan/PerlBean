# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

use Test;
BEGIN { plan tests => 1 };

#########################

# Insert your test code below, the Test module is use()ed here so read
# its man page ( perldoc Test ) for help writing this test script.

ok (1);

use strict;
use PerlBean;
use PerlBean::Collection;
use PerlBean::Method;
use PerlBean::Attribute::Factory;

# Bean description array
@::bean_desc = ();

# The license for this Perlbean collection
my $lic = <<EOF;
This file is part of the C<PerlBean> module hierarchy for Perl by
Vincenzo Zocca.

The PerlBean module hierarchy is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2 of
the License, or (at your option) any later version.

The PerlBean module hierarchy is distributed in the hope that it will
be useful, but WITHOUT ANY WARRANTY; without even the implied
warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with the PerlBean module hierarchy; if not, write to
the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA 02111-1307 USA
EOF
chomp ($lic);

# Add descriptions to bean description array
foreach my $fn (<gen/attr-*.pl>) {
	require $fn;
}

my $collection = PerlBean::Collection->new ({license => $lic});
my $factory = PerlBean::Attribute::Factory->new ();

foreach my $bean_desc (@::bean_desc) {
	$bean_desc->{bean_opt}{collection} = $collection;
	my $bean = PerlBean->new ($bean_desc->{bean_opt});
	foreach my $attr_opt (@{$bean_desc->{attr_opt}}) {
		my $attr = $factory->createAttribute ($attr_opt);
		$bean->addAttribute ($attr);
	}
	foreach my $meth_opt (@{$bean_desc->{meth_opt}}) {
		my $meth = PerlBean::Method->new ($meth_opt);
		$bean->addMethod ($meth);
	}
	$collection->addPerlBean ($bean);
}

# Revove the old tmp directory
system ('rm -rf tmp');

# Revove the old auto directory
system ('rm -rf auto');

# Make a new tmp directory
mkdir ('tmp');

# Make a new auto directory
mkdir ('auto');

# Write the hierarch
$collection->write ('tmp');
