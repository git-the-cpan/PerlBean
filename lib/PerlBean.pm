package PerlBean;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

our ( $VERSION ) = '$Revision: 0.2.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
	'attribute' => [ 'PerlBean::Attribute' ],
	'collection' => [ 'PerlBean::Collection' ],
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
	'abstract' => [ '^.*$' ],
	'base' => [ '^\S+$' ],
	'license' => [ '.*' ],
	'synopsis' => [ '.*' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
	'exception_class' => 'Error::Simple',
	'exported' => 0,
	'package' => 'main',
	'short_description' => 'NO DESCRIPTION AVAILABLE',
);

our @MON = qw (
	January
	February
	March
	April
	May
	June
	July
	August
	September
	October
	November
	December
);
our $PACKAGE = 'package';
our $SUB = 'sub';
our $END = '__END__';

1;

__END__

=head1 NAME

PerlBean - Package to generate bean like Perl modules

=head1 SYNOPSIS

 use strict;
 use PerlBean;
 use PerlBean::Attribute::Factory;
 
 my $bean = PerlBean->new ();
 my $factory = PerlBean::Attribute::Factory->new ();
 my $attr = $factory->createAttribute ({
 	attribute_name => 'true',
 	short_description => 'something is true',
 });
 $bean->addAttribute ($attr->getAttributeName (), $attr);
 
 use IO::File;
 -d 'tmp' || mkdir ('tmp');
 my $fh = IO::File->new ('> tmp/PerlBean.pl.out');
 $bean->write ($fh);

=head1 ABSTRACT

Code generation for bean like Perl modules

=head1 DESCRIPTION

C<PerlBean> generates bean like Perl packages. That is, it generates code with for a module with attributes (properties) and the attribute's access methods (B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<has>, B<get> or B<is>, depending on the type of attribute). The attribute base types are B<BOOLEAN>, B<SINGLE> and B<MULTI>. B<BOOLEAN> attributes may be set to C<0> or C<1>. B<SINGLE> attributes may contain any scalar. B<MULTI> attributes contain a set of values (ordered/not ordered and unique/not unique).

The attribute insertion methods (C<setAttribute ()>, C<pushAttribute ()> and unshiftAttribute ()) accept C<PerlBean::Attribute> objects. However, C<PerlBean::Attribute> are best generated using C<PerlBean::Attribute::Factory>. See the sample in the B<SYNOPSIS> section.

Finaly, the actual bean code is written using the C<wite ()> method.

The generated code should be free of syntax errors. It's intended to be mixed with the application logic you intend to write yourself.

Background information: Of course the attribute code in C<PerlBean> and C<PerlBean::Attribute> are actually generated using this method.

=head1 CONSTRUCTOR

=over

=item new ([OPT_HASH_REF])

Creates a new C<PerlBean> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<abstract>>

Passed to L<setAbstract ()>.

=item B<C<attribute>>

Passed to L<setAttribute ()>. Must be an C<ARRAY> reference.

=item B<C<base>>

Passed to L<setBase ()>. Must be an C<ARRAY> reference.

=item B<C<collection>>

Passed to L<setCollection ()>.

=item B<C<description>>

Passed to L<setDescription ()>.

=item B<C<exception_class>>

Passed to L<setExceptionClass ()>. Defaults to B<Error::Simple>.

=item B<C<exported>>

Passed to L<setExported ()>. Defaults to B<0>.

=item B<C<license>>

Passed to L<setLicense ()>.

=item B<C<package>>

Passed to L<setPackage ()>. Defaults to B<main>.

=item B<C<short_description>>

Passed to L<setShortDescription ()>. Defaults to B<NO DESCRIPTION AVAILABLE>.

=item B<C<synopsis>>

Passed to L<setSynopsis ()>.

=back

=back

=head1 METHODS

=over

=item setAbstract (VALUE)

Set the PerlBean' abstract. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^.*$

=back

=back

=item getAbstract ()

Returns the PerlBean' abstract.

=item setAttribute ([KEY, VALUE ...])

Set the list 'PerlBean::Attribute' objects absolutely using keys/values. C<KEY, VALUE> are key/value pairs. 0 or more of these pairs may be supplied. Each key in is allowed to occur only once. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Attribute

=back

=back

=item addAttribute ([KEY, VALUE ...])

Add additional keys/values on the list 'PerlBean::Attribute' objects. C<KEY, VALUE> are key/value pairs. The addition may not yield to multiple identical keys in the list. Hence, multiple occurences of the same key cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Attribute

=back

=back

=item deleteAttribute (ARRAY)

Delete elements from the list 'PerlBean::Attribute' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsAttribute (ARRAY)

Returns the count of items in C<ARRAY> that are in the list 'PerlBean::Attribute' objects.

=item keysAttribute ()

Returns an C<ARRAY> containing the keys of the list 'PerlBean::Attribute' objects.

=item valuesAttribute ([KEY_ARRAY])

Returns an C<ARRAY> containing the values of the list 'PerlBean::Attribute' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

=item setBase (ARRAY)

Set the list of class names in use base absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the first occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item pushBase (ARRAY)

Push additional values on the list of class names in use base. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item popBase ()

Pop and return an element off the list of class names in use base. On error an exception C<Error::Simple> is thrown.

=item shiftBase ()

Shift and return an element off the list of class names in use base. On error an exception C<Error::Simple> is thrown.

=item unshiftBase (ARRAY)

Unshift additional values on the list of class names in use base. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item existsBase (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of class names in use base.

=item getBase ()

Returns an C<ARRAY> containing the list of class names in use base. C<INDEX_ARRAY> is an optional list of indexes which when specified causes only the indexed elements in the ordered list to be returned. If not specified, all elements are returned.

=item setCollection (VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a (sub)class of:

=over

=item PerlBean::Collection

=back

=back

=item getCollection ()

Returns class to throw when exception occurs.

=item setDescription (VALUE)

Set the PerlBean description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getDescription ()

Returns the PerlBean description.

=item setExceptionClass (VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. Default value at initialization is C<Error::Simple>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getExceptionClass ()

Returns class to throw when exception occurs.

=item setExported (VALUE)

State that the PerlBean must contain code for exporter. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item isExported ()

Returns whether the PerlBean must contain code for exporter or not.

=item setLicense (VALUE)

Set the software license for the PerlBean. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item getLicense ()

Returns the software license for the PerlBean.

=item setPackage (VALUE)

Set package name. C<VALUE> is the value. Default value at initialization is C<main>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getPackage ()

Returns package name.

=item setShortDescription (VALUE)

Set the short PerlBean description. C<VALUE> is the value. Default value at initialization is C<NO DESCRIPTION AVAILABLE>. On error an exception C<Error::Simple> is thrown.

=item getShortDescription ()

Returns the short PerlBean description.

=item write (FILEHANDLE)

Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item setSynopsis (VALUE)

Set the synopsis for the PerlBean. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item getSynopsis ()

Returns the synopsis for the PerlBean.

=back

=head1 SEE ALSO

L<PerlBean::Attribute>,
L<PerlBean::Attribute::Boolean>,
L<PerlBean::Attribute::Factory>,
L<PerlBean::Attribute::Multi>,
L<PerlBean::Attribute::Multi::Ordered>,
L<PerlBean::Attribute::Multi::Unique>,
L<PerlBean::Attribute::Multi::Unique::Associative>,
L<PerlBean::Attribute::Multi::Unique::Ordered>,
L<PerlBean::Attribute::Single>,
L<PerlBean::Collection>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: November 2002

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
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::_initialize, first argument must be 'HASH' reference.");

	# abstract, SINGLE
	exists ($opt->{abstract}) && $self->setAbstract ($opt->{abstract});

	# attribute, MULTI
	if (exists ($opt->{attribute})) {
		ref ($opt->{attribute}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::_initialize, specified value for option 'attribute' must be an 'ARRAY' reference.");
		$self->setAttribute (@{$opt->{attribute}});
	} else {
		$self->setAttribute ();
	}

	# base, MULTI
	if (exists ($opt->{base})) {
		ref ($opt->{base}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::_initialize, specified value for option 'base' must be an 'ARRAY' reference.");
		$self->setBase (@{$opt->{base}});
	} else {
		$self->setBase ();
	}

	# collection, SINGLE
	exists ($opt->{collection}) && $self->setCollection ($opt->{collection});

	# description, SINGLE
	exists ($opt->{description}) && $self->setDescription ($opt->{description});

	# exception_class, SINGLE, with default value
	$self->setExceptionClass (exists ($opt->{exception_class}) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class});

	# exported, BOOLEAN, with default value
	$self->setExported (exists ($opt->{exported}) ? $opt->{exported} : $DEFAULT_VALUE{exported});

	# license, SINGLE
	exists ($opt->{license}) && $self->setLicense ($opt->{license});

	# package, SINGLE, with default value
	$self->setPackage (exists ($opt->{package}) ? $opt->{package} : $DEFAULT_VALUE{package});

	# short_description, SINGLE, with default value
	$self->setShortDescription (exists ($opt->{short_description}) ? $opt->{short_description} : $DEFAULT_VALUE{short_description});

	# synopsis, SINGLE
	exists ($opt->{synopsis}) && $self->setSynopsis ($opt->{synopsis});

	# Return $self
	return ($self);
}

sub setAbstract {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('abstract', $val) || throw Error::Simple ("ERROR: PerlBean::setAbstract, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{abstract} = $val;
}

sub getAbstract {
	my $self = shift;

	return ($self->{PerlBean}{abstract});
}

sub setAttribute {
	my $self = shift;

	# Separate keys/values
	my @key = ();
	my @value = ();
	while (my $key = shift (@_)) {
		push (@key, $key);
		push (@value, shift (@_));
	}

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('attribute', @value) || throw Error::Simple ("ERROR: PerlBean::setAttribute, one or more specified value(s) '@value' is/are not allowed.");

	# Empty list
	$self->{PerlBean}{attribute} = {};

	# Add keys/values
	foreach my $key (@key) {
		$self->{PerlBean}{attribute}{$key} = shift (@value);
		$self->{PerlBean}{attribute}{$key}->setPerlBean ($self);
	}
}

sub addAttribute {
	my $self = shift;

	# Separate keys/values
	my @key = ();
	my @value = ();
	while (my $key = shift (@_)) {
		push (@key, $key);
		push (@value, shift (@_));
	}

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('attribute', @value) || throw Error::Simple ("ERROR: PerlBean::addAttribute, one or more specified value(s) '@value' is/are not allowed.");

	# Add keys/values
	foreach my $key (@key) {
		$self->{PerlBean}{attribute}{$key} = shift (@value);
		$self->{PerlBean}{attribute}{$key}->setPerlBean ($self);
	}
}

sub deleteAttribute {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean}{attribute}{$val}) || next;
		delete ($self->{PerlBean}{attribute}{$val});
		$del++;
	}
	return ($del);
}

sub existsAttribute {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean}{attribute}{$val});
	}
	return ($count);
}

sub keysAttribute {
	my $self = shift;

	# Return all keys
	return (keys (%{$self->{PerlBean}{attribute}}));
}

sub valuesAttribute {
	my $self = shift;

	if (scalar (@_)) {
		my @ret = ();
		foreach my $key (@_) {
			exists ($self->{PerlBean}{attribute}{$key}) && push (@ret, $self->{PerlBean}{attribute}{$key});
		}
		return (@ret);
	} else {
		# Return all values
		return (values (%{$self->{PerlBean}{attribute}}));
	}
}

sub setBase {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('base', @_) || throw Error::Simple ("ERROR: PerlBean::setBase, one or more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{PerlBean}{base}{ARRAY} = [];
	$self->{PerlBean}{base}{HASH} = {};

	# Push values
	foreach my $val (@_) {
		next if (exists ($self->{PerlBean}{base}{HASH}{$val}));
		push (@{$self->{PerlBean}{base}{ARRAY}}, $val);
		$self->{PerlBean}{base}{HASH}{$val} = $val;
	}
}

sub pushBase {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('base', @_) || throw Error::Simple ("ERROR: PerlBean::pushBase, one or more specified value(s) '@_' is/are not allowed.");

	# Push values
	foreach my $val (@_) {
		next if (exists ($self->{PerlBean}{base}{HASH}{$val}));
		push (@{$self->{PerlBean}{base}{ARRAY}}, $val);
		$self->{PerlBean}{base}{HASH}{$val} = $val;
	}
}

sub popBase {
	my $self = shift;

	# Pop value
	my $val = pop (@{$self->{PerlBean}{base}{ARRAY}});
	delete ($self->{PerlBean}{base}{HASH}{$val});
	return ($val);
}

sub shiftBase {
	my $self = shift;

	# Shift value
	my $val = shift (@{$self->{PerlBean}{base}{ARRAY}});
	delete ($self->{PerlBean}{base}{HASH}{$val});
	return ($val);
}

sub unshiftBase {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('base', @_) || throw Error::Simple ("ERROR: PerlBean::unshiftBase, one or more specified value(s) '@_' is/are not allowed.");

	# Unshift values
	foreach my $val (reverse (@_)) {
		next if (exists ($self->{PerlBean}{base}{HASH}{$val}));
		unshift (@{$self->{PerlBean}{base}{ARRAY}}, $val);
		$self->{PerlBean}{base}{HASH}{$val} = $val;
	}
}

sub existsBase {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean}{base}{HASH}{$val});
	}
	return ($count);
}

sub getBase {
	my $self = shift;

	if (scalar (@_)) {
		my @ret = ();
		foreach my $i (@_) {
			push (@ret, $self->{PerlBean}{base}{ARRAY}[int ($i)]);
		}
		return (@ret);
	} else {
		# Return the list
		return (@{$self->{PerlBean}{base}{ARRAY}});
	}
}

sub setCollection {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('collection', $val) || throw Error::Simple ("ERROR: PerlBean::setCollection, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{collection} = $val;
}

sub getCollection {
	my $self = shift;

	return ($self->{PerlBean}{collection});
}

sub setDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('description', $val) || throw Error::Simple ("ERROR: PerlBean::setDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{description} = $val;
}

sub getDescription {
	my $self = shift;

	return ($self->{PerlBean}{description});
}

sub setExceptionClass {
	my $self = shift;
	my $val = shift;

	# Value for 'exception_class' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::setExceptionClass, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('exception_class', $val) || throw Error::Simple ("ERROR: PerlBean::setExceptionClass, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{exception_class} = $val;
}

sub getExceptionClass {
	my $self = shift;

	return ($self->{PerlBean}{exception_class});
}

sub setExported {
	my $self = shift;

	if (shift) {
		$self->{PerlBean}{exported} = 1;
	} else {
		$self->{PerlBean}{exported} = 0;
	}
}

sub isExported {
	my $self = shift;

	if ($self->{PerlBean}{exported}) {
		return (1);
	} else {
		return (0);
	}
}

sub setLicense {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('license', $val) || throw Error::Simple ("ERROR: PerlBean::setLicense, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{license} = $val;
}

sub getLicense {
	my $self = shift;

	return ($self->{PerlBean}{license});
}

sub setPackage {
	my $self = shift;
	my $val = shift;

	# Value for 'package' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::setPackage, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('package', $val) || throw Error::Simple ("ERROR: PerlBean::setPackage, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{package} = $val;
}

sub getPackage {
	my $self = shift;

	return ($self->{PerlBean}{package});
}

sub setShortDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('short_description', $val) || throw Error::Simple ("ERROR: PerlBean::setShortDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{short_description} = $val;
}

sub getShortDescription {
	my $self = shift;

	return ($self->{PerlBean}{short_description});
}

sub setSynopsis {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('synopsis', $val) || throw Error::Simple ("ERROR: PerlBean::setSynopsis, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean}{synopsis} = $val;
}

sub getSynopsis {
	my $self = shift;

	return ($self->{PerlBean}{synopsis});
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

sub getOverloadedAttribute {
	my $self = shift;
	my $match_attr = shift;
	my $loop_stop = shift;

	# Check for a loop
	my $pkg = $self->getPackage ();
	exists ($loop_stop->{$pkg}) && throw Error::Simple ("ERROR: PerlBean::getOverloadedAttribute, loop detected in inheritance at bean '$pkg'.");
	$loop_stop->{$pkg} = 1;

	# Check and return attribute if found in this bean
	my $found_attr = ($self->valuesAttribute ($match_attr->getAttributeName ()))[0];
	if (defined ($found_attr)) {
		# Get the reference type of the attribute to match
		my $match_attr_ref = ref ($match_attr);

		# Get the reference type of the found attribute
		my $found_attr_ref = ref ($found_attr);

		# Match found if the reference types of the attribute to match and the found attribute are identical.
		($match_attr_ref eq $found_attr_ref) && return ($found_attr);

		# The reference types of the attribute to match and the found attribute are different. Throw a usable exception.
		my $name = $found_attr->getAttributeName ();
		my $match_attr_pkg = $match_attr->getPerlBean ()->getPackage ();
		throw Error::Simple ("ERROR: PerlBean::getOverloadedAttribute, found an attribute named '$name' in package '$pkg' but the reference type '$found_attr_ref' was not as in package '$match_attr_pkg' ($match_attr_ref).");
	}

	# Check super classes
	foreach my $super_pkg ($self->getBase ()) {
		# Get the super class bean
		my $super_bean = ($self->getCollection ()->valuesBean ($super_pkg))[0];

		# If the super class bean has no bean in the collection then no attribute is found
		defined ($super_bean) || return (undef);

		# See if the super class bean has an attribute
		my $attr_over = $super_bean->getOverloadedAttribute ($match_attr, $loop_stop);

		# Return the overloaded bean if found
		defined ($attr_over) && return ($attr_over);
	}

	# Nothing found
	return (undef);
}

sub getInheritAttributes {
	my $self = shift;
	my $done = shift;
	my $loop_stop = shift;

	# Check for a loop
	my $pkg = $self->getPackage ();
	exists ($loop_stop->{$pkg}) && throw Error::Simple ("ERROR: PerlBean::getInheritAttributes, loop detected in inheritance at bean '$pkg'.");
	$loop_stop->{$pkg} = 1;

	# Add own attributes
	foreach my $attr ($self->valuesAttribute ()) {
		exists ($done->{$attr->getAttributeName ()}) && next;
		$done->{$attr->getAttributeName ()} = $attr;
	}

	# Add attributes from super classes
	foreach my $super_pkg ($self->getBase ()) {
		# Get the super class bean
		my $super_bean = ($self->getCollection ()->valuesBean ($super_pkg))[0];

		# If the super package is not in the collection, well too bad (for now anyway)
		defined ($super_bean) || next;

		# See if the super class bean has an attribute
		$super_bean->getInheritAttributes ($done, $loop_stop);
	}
}

sub superClassInCollection {
	my $self = shift;

	# Fail if this is not a subclass
	scalar ($self->getBase ()) || return (0);

	# Fail if the collection is not set
	$self->getCollection () || return (0);

	# Get the first super class package
	my $super_pkg = ($self->getBase ())[0];

	# Get the super class bean
	my $super_bean = ($self->getCollection ()->valuesBean ($super_pkg))[0];

	# Succeed if the superclass package is in the collection
	return (defined ($super_bean));
}

sub write {
	my $self = shift;
	my $fh = shift;

	# Package heading
	$self->writePackageHead ($fh);

	# Allow vairables
	if (scalar ($self->valuesAttribute ())) {
		$self->writeAllowIsaHash ($fh);
		$self->writeAllowRefHash ($fh);
		$self->writeAllowRxHash ($fh);
		$self->writeAllowValueHash ($fh);
		$self->writeDefaultValueHash ($fh);
	}

	# End of preloaded methods
	$self->writePreloadedEnd ($fh);

	# Start pod documentation
	$self->writeDocHead ($fh);

	# Check for inherited methods and remember the package names
	#
	# %attr contains both the attributes defined in the class itself and
	# in its superclasses. The attribute objects are indexed by attribute
	# name.
	#
	# %pkg contains the packages from which attribute methods are inherited
	#
	# $do_inherited is set to 1 when attribute methods actually are inherited
	#
	$self->getInheritAttributes (\my %attr, {});
	my %pkg = ();
	my $do_inherited = 0;
	foreach my $attr (values (%attr)) {
		$do_inherited = $do_inherited || ($attr->getPerlBean ()->getPackage () ne $self->getPackage ());
		$pkg{$attr->getPerlBean ()->getPackage ()} = 1;
	}

	# Constructor documentation
	$self->writeDocConstructorHead ($fh, \%attr);
	if (scalar ($self->valuesAttribute ())) {
		$self->writeDocConstructorBody ($fh);
	}
	if ($do_inherited) {
		$self->writeDocInheritConstructorBody ($fh, \%attr, \%pkg);
	}
	$self->writeDocConstructorTail ($fh);

	# Methods documentation
	if (scalar ($self->valuesAttribute ())) {
		$self->writeDocMethodsHead ($fh);
		$self->writeDocMethodsBody ($fh);
		$self->writeDocMethodsTail ($fh);
	}

	# Inherited methods documentation
	$self->writeDocInheritMethods ($fh, \%attr, \%pkg) if ($do_inherited);

	# Finish pod documentation
	$self->writeDocTail ($fh);

	# The new method
	if (! $self->superClassInCollection ()) {
		$self->writeNewMethod ($fh);
	}

	# The _initialize method
	if (scalar ($self->valuesAttribute ())) {
		$self->writeInitMethodHead ($fh);
		$self->writeInitMethodBody ($fh);
		$self->writeInitMethodTail ($fh, $do_inherited);
	}

	# All attributes from this bean
	my %all_attr_ref = ();
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeMethods ($fh);
		$all_attr_ref{$name} = $attribute;
	}

	# Allow method
	if (scalar ($self->valuesAttribute ())) {
		$self->writeValueAllowedMethod ($fh);
	}
}

sub writeAllowIsaHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
our \%ALLOW_ISA = (
EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeAllowIsa ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeAllowRefHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
our \%ALLOW_REF = (
EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeAllowRef ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeAllowRxHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
our \%ALLOW_RX = (
EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeAllowRx ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeAllowValueHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
our \%ALLOW_VALUE = (
EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeAllowValue ($fh);
	}
	$fh->print (<<EOF);
);
EOF

}

sub writeDefaultValueHash {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
our \%DEFAULT_VALUE = (
EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeDefaultValue ($fh);
	}
	$fh->print (<<EOF);
);

EOF

}

sub writeDocConstructorBody {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
Options for C<OPT_HASH_REF> may include:

\=over

EOF
	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeDocInit ($fh);
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocInheritConstructorBody {
	my $self = shift;
	my $fh = shift;
	my $attr = shift;
	my $pkg = shift;

	

	foreach my $pkg_name (sort (keys (%{$pkg}))) {
		next if ($self->getPackage () eq $pkg_name);

		$fh->print (<<EOF);
Options for C<OPT_HASH_REF> inherited through package B<C<$pkg_name>> may include:

\=over

EOF
		foreach my $attr_name (sort (keys (%{$attr}))) {
			next if ($attr->{$attr_name}->getPerlBean ()->getPackage () ne $pkg_name);
			$attr->{$attr_name}->writeDocInit ($fh);
		}

	$fh->print (<<EOF);
\=back

EOF
	}
}

sub writeDocConstructorHead {
	my $self = shift;
	my $fh = shift;
	my $attr = shift;

	my $pkg = $self->getPackage ();
	my $ec = $self->getExceptionClass ();
	my $mand = '';
	my $pre = '[';
	my $post = ']';
	foreach my $name ($self->keysAttribute ()) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		if ($attribute->isMandatory ()) {
			$pre = '';
			$post = '';
			$mand = ' C<OPT_HASH_REF> is mandatory.';
			last;
		}
	}

	if (! $mand) {
		foreach my $name (keys (%{$attr})) {
			my $attribute = $attr->{$name};
			if ($attribute->isMandatory ()) {
				$pre = '';
				$post = '';
				$mand = ' C<OPT_HASH_REF> is mandatory.';
				last;
			}
		}
	}

	$fh->print (<<EOF);
\=head1 CONSTRUCTOR

\=over

EOF

	$fh->print (<<EOF);
\=item new (${pre}OPT_HASH_REF${post})

Creates a new C<$pkg> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options.${mand} On error an exception C<$ec> is thrown.

EOF
}

sub writeDocConstructorTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();
	my $sdesc = $self->getShortDescription ();

	my $desc = defined ($self->getDescription ()) ? $self->getDescription () : "C<$pkg> TODO";

	my $syn = defined ($self->getSynopsis ()) ? $self->getSynopsis () : ' TODO';

	my $abs = defined ($self->getAbstract ()) ? $self->getAbstract () : 'TODO';

	$fh->print (<<EOF);
\=head1 NAME

${pkg} - ${sdesc}

\=head1 SYNOPSIS

$syn

\=head1 ABSTRACT

$abs

\=head1 DESCRIPTION

${desc}

EOF

	if ($self->isExported ()) {
		$fh->print (<<EOF);
\=head2 EXPORT

TODO

EOF
	}
}

sub writeDocMethodsBody {
	my $self = shift;
	my $fh = shift;

	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeDocMethods ($fh);
	}
}

sub writeDocMethodsHead {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=head1 METHODS

\=over

EOF
}

sub writeDocMethodsTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocTail {
	my $self = shift;
	my $fh = shift;

	my $m = $MON[(localtime ())[4]];
	my $y = (localtime ())[5] + 1900;
	my $p = (getpwuid ($>))[6];

	my $also = 'TODO';
	if (defined ($self->getCollection ())) {
		$also = '';
		foreach my $pkg (sort ($self->getCollection ()->keysBean ())) {
			next if ($pkg eq $self->getPackage ());
			$also .= "L<$pkg>,\n";
		}
		chop ($also);
		chop ($also);
		$also = $also ? $also : 'NONE';
	}

	my $lic = 'TODO';
	if (defined ($self->getLicense ())) {
		$lic = $self->getLicense ();
	} elsif (defined ($self->getCollection ()) && defined ($self->getCollection ()->getLicense ())) {
		$lic = $self->getCollection ()->getLicense ();
	}

	$fh->print (<<EOF);
\=head1 SEE ALSO

$also

\=head1 BUGS

None known (yet.)

\=head1 HISTORY

First development: ${m} ${y}

\=head1 AUTHOR

${p}

\=head1 COPYRIGHT

Copyright ${y} by ${p}

\=head1 LICENSE

$lic

\=cut

EOF
}

sub writeDocInheritMethods {
	my $self = shift;
	my $fh = shift;
	my $attr = shift;
	my $pkg = shift;

	foreach my $pkg_name (sort (keys (%{$pkg}))) {
		next if ($self->getPackage () eq $pkg_name);

		$self->writeDocInheritMethodsHead ($fh, $pkg_name);

		$self->writeDocInheritMethodsBody ($fh, $attr, $pkg_name);

		$self->writeDocInheritMethodsTail ($fh);
	}
}

sub writeDocInheritMethodsBody {
	my $self = shift;
	my $fh = shift;
	my $attr = shift;
	my $pkg = shift;

	foreach my $attr_name (sort (keys (%{$attr}))) {
		next if ($attr->{$attr_name}->getPerlBean ()->getPackage () ne $pkg);
		$fh->print (<<EOF);
\=item To access attribute named B<C<$attr_name>>:

EOF
		$attr->{$attr_name}->writeDocInheritMethods ($fh);
	}
}

sub writeDocInheritMethodsHead {
	my $self = shift;
	my $fh = shift;
	my $pkg = shift;

	$fh->print (<<EOF);
\=head1 INHERITED METHODS FROM $pkg

\=over

EOF
}

sub writeDocInheritMethodsTail {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
\=back

EOF
}

sub writeInitMethodBody {
	my $self = shift;
	my $fh = shift;

	foreach my $name (sort ($self->keysAttribute ())) {
		my $attribute = ($self->valuesAttribute ($name))[0];
		$attribute->writeOptInit ($fh);
	}
}

sub writeInitMethodHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();

	$fh->print (<<EOF);
$SUB _initialize {
	my \$self = shift;
	my \$opt = defined (\$_[0]) ? shift : {};

	# Check \$opt
	ref (\$opt) eq 'HASH' || throw Error::Simple ("ERROR: ${pkg}::_initialize, first argument must be 'HASH' reference.");

EOF
}

sub writeInitMethodTail {
	my $self = shift;
	my $fh = shift;
	my $do_inherited = shift;

	if ($do_inherited) {
		$fh->print (<<EOF);
	# Call the superclass' _initialize
	\$self->SUPER::_initialize (\$opt);

EOF
	}

	$fh->print (<<EOF);
	# Return \$self
	return (\$self);
}

EOF
}

sub writeNewMethod {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
$SUB new {
	my \$class = shift;

	my \$self = {};
	bless (\$self, (ref(\$class) || \$class));
	return (\$self->_initialize (\@_));
}

EOF
}

sub writePackageHead {
	my $self = shift;
	my $fh = shift;

	my $pkg = $self->getPackage ();
	$fh->print (<<EOF);
$PACKAGE $pkg;

use $];
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

EOF

	if ($self->isExported ()) {
		$fh->print (<<EOF);
require Exporter;

EOF
	}

	# base
	if (scalar ($self->getBase ())) {
		my @base = $self->getBase ();
		$self->isExported () && push (@base, qw (Exporter));
		$fh->print (<<EOF);
use base qw (@base);

EOF
	} elsif ($self->isExported ()) {
		$fh->print (<<EOF);
our \@ISA = qw (Exporter);

EOF
	}

	if ($self->isExported ()) {
		$fh->print (<<EOF);
our \%EXPORT_TAGS = (
	'all' => [
		qw (),
	],
);

our \@EXPORT_OK = ( \@{ \$EXPORT_TAGS{'all'} } );

our \@EXPORT = qw (
);

EOF
	}

	my $version = 'our ( $VERSION ) = \'$';
	$version .= 'Revision: 0.0.0.0 ';
	$version .= '$ \' =~ /\\$';
	$version .= 'Revision:\\s+([^\\s]+)/;';
	$fh->print (<<EOF);
${version}

EOF
}

sub writePreloadedEnd {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
1;

$END

EOF
}

sub writeValueAllowedMethod {
	my $self = shift;
	my $fh = shift;

	$fh->print (<<EOF);
$SUB valueIsAllowed {
	my \$name = shift;

	# Value is allowed if no ALLOW clauses exist for the named attribute
	if (!exists (\$ALLOW_ISA{\$name}) && !exists (\$ALLOW_REF{\$name}) && !exists (\$ALLOW_RX{\$name}) && !exists (\$ALLOW_VALUE{\$name})) {
		return (1);
	}

	# At this point, all values in \@_ must to be allowed
	CHECK_VALUES:
	foreach my \$val (\@_) {
		# Check ALLOW_ISA
		if (ref (\$val) && exists (\$ALLOW_ISA{\$name})) {
			foreach my \$class (\@{\$ALLOW_ISA{\$name}}) {
				&UNIVERSAL::isa (\$val, \$class) && next CHECK_VALUES;
			}
		}

		# Check ALLOW_REF
		if (ref (\$val) && exists (\$ALLOW_REF{\$name})) {
			exists (\$ALLOW_REF{\$name}{\$val}) && next CHECK_VALUES;
		}

		# Check ALLOW_RX
		if (defined (\$val) && !ref (\$val) && exists (\$ALLOW_RX{\$name})) {
			foreach my \$rx (\@{\$ALLOW_RX{\$name}}) {
				\$val =~ /\$rx/ && next CHECK_VALUES;
			}
		}

		# Check ALLOW_VALUE
		if (!ref (\$val) && exists (\$ALLOW_VALUE{\$name})) {
			exists (\$ALLOW_VALUE{\$name}{\$val}) && next CHECK_VALUES;
		}

		# We caught a not allowed value
		return (0);
	}

	# OK, all values are allowed
	return (1);
}

EOF
}

