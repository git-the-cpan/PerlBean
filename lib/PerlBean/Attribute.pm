package PerlBean::Attribute;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

our ( $VERSION ) = '$Revision: 0.2.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
	'perl_bean' => [ 'PerlBean' ],
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
	'attribute_name' => [ '^\w+$' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
	'exception_class' => 'Error::Simple',
	'mandatory' => 0,
);

1;

__END__

=head1 NAME

PerlBean::Attribute - contains bean attribute information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

Abstract PerlBean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute> abstract class for bean attribute information. Attribute access methods are implemented and code and documentation generation interface methods are defined.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<attribute_name>>

Passed to L<setAttributeName ()>. Mandatory option.

=item B<C<default_value>>

Passed to L<setDefaultValue ()>.

=item B<C<exception_class>>

Passed to L<setExceptionClass ()>. Defaults to B<Error::Simple>.

=item B<C<mandatory>>

Passed to L<setMandatory ()>. Defaults to B<0>.

=item B<C<method_base>>

Passed to L<setMethodBase ()>.

=item B<C<perl_bean>>

Passed to L<setPerlBean ()>.

=item B<C<short_description>>

Passed to L<setShortDescription ()>.

=back

=back

=head1 METHODS

=over

=item setAttributeName (VALUE)

Set attribute's name. C<VALUE> is the value. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^\w+$

=back

=back

=item getAttributeName ()

Returns attribute's name.

=item setDefaultValue (VALUE)

Set attribute's default value. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getDefaultValue ()

Returns attribute's default value.

=item setExceptionClass (VALUE)

Set the class to throw when an exception occurs. C<VALUE> is the value. Default value at initialization is C<Error::Simple>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getExceptionClass ()

Returns the class to throw when an exception occurs.

=item setMandatory (VALUE)

State that the attribute is mandatory for construction. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item isMandatory ()

Returns whether the attribute is mandatory for construction or not.

=item setMethodBase (VALUE)

Set the method base name. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getMethodBase ()

Returns the method base name.

=item setPerlBean (VALUE)

Set the PerlBean to which this attribute belongs. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a (sub)class of:

=over

=item PerlBean

=back

=back

=item getPerlBean ()

Returns the PerlBean to which this attribute belongs.

=item setShortDescription (VALUE)

Set the attribute description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getShortDescription ()

Returns the attribute description.

=item getPackage ()

Returns package name.

=item getPackageUS ()

Returns package name with C<:+> replaces by C <_>.

=item writeDefaultValue (FILEHANDLE)

Write C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeOptInit (FILEHANDLE)

Write C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInit (FILEHANDLE)

Write documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeMethods (FILEHANDLE)

Write the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

Write documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=back

=head1 SEE ALSO

L<PerlBean>,
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
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::Attribute::_initialize, first argument must be 'HASH' reference.");

	# attribute_name, SINGLE, mandatory
	exists ($opt->{attribute_name}) || throw Error::Simple ("ERROR: PerlBean::Attribute::_initialize, option 'attribute_name' is mandatory.");
	$self->setAttributeName ($opt->{attribute_name});

	# default_value, SINGLE
	exists ($opt->{default_value}) && $self->setDefaultValue ($opt->{default_value});

	# exception_class, SINGLE, with default value
	$self->setExceptionClass (exists ($opt->{exception_class}) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class});

	# mandatory, BOOLEAN, with default value
	$self->setMandatory (exists ($opt->{mandatory}) ? $opt->{mandatory} : $DEFAULT_VALUE{mandatory});

	# method_base, SINGLE
	exists ($opt->{method_base}) && $self->setMethodBase ($opt->{method_base});

	# perl_bean, SINGLE
	exists ($opt->{perl_bean}) && $self->setPerlBean ($opt->{perl_bean});

	# short_description, SINGLE
	exists ($opt->{short_description}) && $self->setShortDescription ($opt->{short_description});

	# Return $self
	return ($self);
}

sub setAttributeName {
	my $self = shift;
	my $val = shift;

	# Value for 'attribute_name' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setAttributeName, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('attribute_name', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setAttributeName, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{attribute_name} = $val;
}

sub getAttributeName {
	my $self = shift;

	return ($self->{PerlBean_Attribute}{attribute_name});
}

sub setDefaultValue {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('default_value', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setDefaultValue, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{default_value} = $val;
}

sub getDefaultValue {
	my $self = shift;

	return ($self->{PerlBean_Attribute}{default_value});
}

sub setExceptionClass {
	my $self = shift;
	my $val = shift;

	# Value for 'exception_class' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setExceptionClass, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('exception_class', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setExceptionClass, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{exception_class} = $val;
}

sub getExceptionClass {
	my $self = shift;

	return ($self->{PerlBean_Attribute}{exception_class});
}

sub setMandatory {
	my $self = shift;

	if (shift) {
		$self->{PerlBean_Attribute}{mandatory} = 1;
	} else {
		$self->{PerlBean_Attribute}{mandatory} = 0;
	}
}

sub isMandatory {
	my $self = shift;

	if ($self->{PerlBean_Attribute}{mandatory}) {
		return (1);
	} else {
		return (0);
	}
}

sub setMethodBase {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('method_base', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setMethodBase, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{method_base} = $val;
}

sub getMethodBase {
	my $self = shift;

	defined ($self->{PerlBean_Attribute}{method_base}) && return ($self->{PerlBean_Attribute}{method_base});

	my @method_base = split (/_/, $self->getAttributeName ());
	foreach my $part (@method_base) {
		$part = ucfirst ($part);
	}
	return (join ('', @method_base));
}

sub setPerlBean {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('perl_bean', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setPerlBean, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{perl_bean} = $val;
}

sub getPerlBean {
	my $self = shift;

	return ($self->{PerlBean_Attribute}{perl_bean});
}

sub getPackage {
	my $self = shift;

	defined ($self->getPerlBean) && return ( $self->getPerlBean ()->getPackage ());
	return ('main');
}

sub getPackageUS {
	my $self = shift;

	my $pkg = $self->getPackage ();
	$pkg =~ s/:+/_/g;
	return ($pkg);
}

sub setShortDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('short_description', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::setShortDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute}{short_description} = $val;
}

sub getShortDescription {
	my $self = shift;

	return ($self->{PerlBean_Attribute}{short_description});
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

	# No attribute found if no collection defined
	defined ($self->getPerlBean ()) || return (undef);
	defined ($self->getPerlBean ()->getCollection ()) || return (undef);

	# Look for the attribute in super classes
	foreach my $super_pkg ($self->getPerlBean ()->getBase ()) {
		# Get the super class bean
		my $super_bean = ($self->getPerlBean ()->getCollection ()->valuesBean ($super_pkg))[0];

		# If the super class bean has no bean in the collection then no attribute is found
		defined ($super_bean) || return (undef);

		# See if the super class bean has an attribute
		my $attr_over = $super_bean->getOverloadedAttribute ($self, {
			$self->getPerlBean ()->getPackage () => 1,
		});

		# Return the overloaded bean if found
		defined ($attr_over) && return ($attr_over);
	}

	# Nothing found
	return (undef);
}

sub writeMethods {
	throw Error::Simple ("ERROR: PerlBean::Attribute::writeMethods, call this method in a subclass that has implemented it.");
}

sub writeDocMethods {
	throw Error::Simple ("ERROR: PerlBean::Attribute::writeDocMethods, call this method in a subclass that has implemented it.");
}

sub writeDocClauses {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowIsa ()) && !scalar ($self->valuesAllowRef ()) && !scalar ($self->valuesAllowRx ()) && !scalar ($self->valuesAllowValue ()));

	$fh->print (<<EOF);
\=over

EOF

	$self->writeDocClausesAllowIsa ($fh, @_);
	$self->writeDocClausesAllowRef ($fh, @_);
	$self->writeDocClausesAllowRx ($fh, @_);
	$self->writeDocClausesAllowValue ($fh, @_);

	$fh->print (<<EOF);
\=back

EOF
}

sub type {
	my $self = shift;

	$self->isa ('PerlBean::Attribute::Boolean') && return ('BOOLEAN');
	$self->isa ('PerlBean::Attribute::Multi') && return ('MULTI');
	$self->isa ('PerlBean::Attribute::Single') && return ('SINGLE');
}

