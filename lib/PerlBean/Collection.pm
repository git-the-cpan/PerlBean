package PerlBean::Collection;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

our ( $VERSION ) = '$Revision: 0.2.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
	'bean' => [ 'PerlBean' ],
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
	'license' => [ '.*' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
);

1;

__END__

=head1 NAME

PerlBean::Collection - contains a ccollection of PerlBean objects

=head1 SYNOPSIS

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

=head1 ABSTRACT

Code hierarchy generation for bean like Perl modules

=head1 DESCRIPTION

C<PerlBean::Collection> contains a collection of C<PerlBean> objects in order to generate an hierarchy of Perl modules.

=head1 CONSTRUCTOR

=over

=item new ([OPT_HASH_REF])

Creates a new C<PerlBean::Collection> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<bean>>

Passed to L<setBean ()>. Must be an C<ARRAY> reference.

=item B<C<license>>

Passed to L<setLicense ()>.

=back

=back

=head1 METHODS

=over

=item setBean ([KEY, VALUE ...])

Set the list of beans in the collection absolutely using keys/values. C<KEY, VALUE> are key/value pairs. 0 or more of these pairs may be supplied. Each key in is allowed to occur only once. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean

=back

=back

=item addBean ([KEY, VALUE ...])

Add additional keys/values on the list of beans in the collection. C<KEY, VALUE> are key/value pairs. The addition may not yield to multiple identical keys in the list. Hence, multiple occurences of the same key cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean

=back

=back

=item deleteBean (ARRAY)

Delete elements from the list of beans in the collection. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsBean (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of beans in the collection.

=item keysBean ()

Returns an C<ARRAY> containing the keys of the list of beans in the collection.

=item valuesBean ([KEY_ARRAY])

Returns an C<ARRAY> containing the values of the list of beans in the collection. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

=item setLicense (VALUE)

Set the software license for the PerlBean collection. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item getLicense ()

Returns the software license for the PerlBean collection.

=item write (DIRECTORY)

Write the hierarchy of Perl class code to C<DIRECTORY>. C<DIRECTORY> is a directory name. On error an exception C<Error::Simple> is thrown.

=back

=head1 SEE ALSO

L<PerlBean>,
L<PerlBean::Attribute>,
L<PerlBean::Attribute::Boolean>,
L<PerlBean::Attribute::Factory>,
L<PerlBean::Attribute::Multi>,
L<PerlBean::Attribute::Multi::Ordered>,
L<PerlBean::Attribute::Multi::Unique>,
L<PerlBean::Attribute::Multi::Unique::Associative>,
L<PerlBean::Attribute::Multi::Unique::Ordered>,
L<PerlBean::Attribute::Single>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: December 2002

=head1 AUTHOR

Vincenzo Zocca

=head1 COPYRIGHT

Copyright 2002 by Vincenzo Zocca

=head1 LICENSE

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

=cut

sub new {
	my $class = shift;

	my $self = {};
	bless ($self, (ref($class) || $class));
	return ($self->_initialize (@_));
}

sub _initialize {
	my $self = shift;
	my $opt = defined ($_[0]) ? shift : {};

	# Check $opt
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::Collection::_initialize, first argument must be 'HASH' reference.");

	# bean, MULTI
	if (exists ($opt->{bean})) {
		ref ($opt->{bean}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::Collection::_initialize, specified value for option 'bean' must be an 'ARRAY' reference.");
		$self->setBean (@{$opt->{bean}});
	} else {
		$self->setBean ();
	}

	# license, SINGLE
	exists ($opt->{license}) && $self->setLicense ($opt->{license});

	# Return $self
	return ($self);
}

sub setBean {
	my $self = shift;

	# Separate keys/values
	my @key = ();
	my @value = ();
	while (my $key = shift (@_)) {
		push (@key, $key);
		push (@value, shift (@_));
	}

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('bean', @value) || throw Error::Simple ("ERROR: PerlBean::Collection::setBean, one or more specified value(s) '@value' is/are not allowed.");

	# Empty list
	$self->{PerlBean_Collection}{bean} = {};

	# Add keys/values
	foreach my $key (@key) {
		$self->{PerlBean_Collection}{bean}{$key} = shift (@value);
		$self->{PerlBean_Collection}{bean}{$key}->setCollection ($self);
	}
}

sub addBean {
	my $self = shift;

	# Separate keys/values
	my @key = ();
	my @value = ();
	while (my $key = shift (@_)) {
		push (@key, $key);
		push (@value, shift (@_));
	}

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('bean', @value) || throw Error::Simple ("ERROR: PerlBean::Collection::addBean, one or more specified value(s) '@value' is/are not allowed.");

	# Add keys/values
	foreach my $key (@key) {
		$self->{PerlBean_Collection}{bean}{$key} = shift (@value);
		$self->{PerlBean_Collection}{bean}{$key}->setCollection ($self);
	}
}

sub deleteBean {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean_Collection}{bean}{$val}) || next;
		delete ($self->{PerlBean_Collection}{bean}{$val});
		$del++;
	}
	return ($del);
}

sub existsBean {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean_Collection}{bean}{$val});
	}
	return ($count);
}

sub keysBean {
	my $self = shift;

	# Return all keys
	return (keys (%{$self->{PerlBean_Collection}{bean}}));
}

sub valuesBean {
	my $self = shift;

	if (scalar (@_)) {
		my @ret = ();
		foreach my $key (@_) {
			exists ($self->{PerlBean_Collection}{bean}{$key}) && push (@ret, $self->{PerlBean_Collection}{bean}{$key});
		}
		return (@ret);
	} else {
		# Return all values
		return (values (%{$self->{PerlBean_Collection}{bean}}));
	}
}

sub setLicense {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('license', $val) || throw Error::Simple ("ERROR: PerlBean::Collection::setLicense, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Collection}{license} = $val;
}

sub getLicense {
	my $self = shift;

	return ($self->{PerlBean_Collection}{license});
}

sub valueIsAllowed {
	my $name = shift;

	# Value is allowed if no ALLOW clauses exist for the named attribute
	if (!exists ($ALLOW_ISA{$name}) && !exists ($ALLOW_REF{$name}) && !exists ($ALLOW_RX{$name}) && !exists ($ALLOW_VALUE{$name})) {
		return (1);
	}

	# At this point, all values in @_ must to be allowed
	CHECK_VALUES:
	foreach my $val (@_) {
		# Check ALLOW_ISA
		if (ref ($val) && exists ($ALLOW_ISA{$name})) {
			foreach my $class (@{$ALLOW_ISA{$name}}) {
				&UNIVERSAL::isa ($val, $class) && next CHECK_VALUES;
			}
		}

		# Check ALLOW_REF
		if (ref ($val) && exists ($ALLOW_REF{$name})) {
			exists ($ALLOW_REF{$name}{$val}) && next CHECK_VALUES;
		}

		# Check ALLOW_RX
		if (defined ($val) && !ref ($val) && exists ($ALLOW_RX{$name})) {
			foreach my $rx (@{$ALLOW_RX{$name}}) {
				$val =~ /$rx/ && next CHECK_VALUES;
			}
		}

		# Check ALLOW_VALUE
		if (!ref ($val) && exists ($ALLOW_VALUE{$name})) {
			exists ($ALLOW_VALUE{$name}{$val}) && next CHECK_VALUES;
		}

		# We caught a not allowed value
		return (0);
	}

	# OK, all values are allowed
	return (1);
}

sub write {
	my $self = shift;
	my $dir = shift || '.';

	# Check for directory existance
	(-d $dir) || throw Error::Simple ("ERROR: PerlBean::Collection::write, directory '$dir' does not exist.");

	# Check for directory writability
	(-w $dir) || throw Error::Simple ("ERROR: PerlBean::Collection::write, directory '$dir' is not writable.");

	# Generate the PerlBeans
	foreach my $bean ($self->valuesBean ()) {
		my $pkg = $bean->getPackage ();
		my @dir = split (/:+/, $pkg);
		my $fn = pop (@dir);
		my $dir_tot = $dir;

		# Make directory
		foreach my $sub_dir (@dir) {
			$dir_tot .= '/' . $sub_dir;
			next if (-d $dir_tot);
			mkdir ($dir_tot);
		}

		# Make the file handle and write bean
		use IO::File;
		my $fh = IO::File->new ("> $dir_tot/$fn.pm");
		$bean->write ($fh, $self);
	}
}

