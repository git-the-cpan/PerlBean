package PerlBean::Method;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

our ( $VERSION ) = '$Revision: 0.5 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
	'perl_bean' => [ 'PerlBean' ],
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
	'body' => [ '.*' ],
	'method_name' => [ '^\w+$' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
	'exception_class' => 'Error::Simple',
);

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Method - contains bean method information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

Abstract PerlBean method information

=head1 DESCRIPTION

C<PerlBean::Method> class for bean method information.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Method> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<body>>

Passed to L<setBody ()>.

=item B<C<description>>

Passed to L<setDescription ()>.

=item B<C<exception_class>>

Passed to L<setExceptionClass ()>. Defaults to B<Error::Simple>.

=item B<C<interface>>

Passed to L<setInterface ()>.

=item B<C<method_name>>

Passed to L<setMethodName ()>. Mandatory option.

=item B<C<parameter_description>>

Passed to L<setParameterDescription ()>.

=item B<C<perl_bean>>

Passed to L<setPerlBean ()>.

=back

=back

=head1 METHODS

=over

=item getPackage ()

Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.

=item getSuperMethod ()

Search the superclasses hierarchy for an identically named C<PerlBean::Method> and return it. If no method is found C<undef> is returned.

=item writeCode (FILEHANDLE)

Write the code for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item writePod (FILEHANDLE)

Write the documentation for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item setBody (VALUE)

Set the method's body. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item getBody ()

Returns the method's body.

=item setDescription (VALUE)

Set the method description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getDescription ()

Returns the method description.

=item setExceptionClass (VALUE)

Set the class to throw in eventual interface inplementations. C<VALUE> is the value. Default value at initialization is C<Error::Simple>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item getExceptionClass ()

Returns the class to throw in eventual interface inplementations.

=item setInterface (VALUE)

State that the method is defined as interface. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item isInterface ()

Returns whether the method is defined as interface or not.

=item setMethodName (VALUE)

Set the method's name. C<VALUE> is the value. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^\w+$

=back

=back

=item getMethodName ()

Returns the method's name.

=item setParameterDescription (VALUE)

Set the parameter description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item getParameterDescription ()

Returns the parameter description.

=item setPerlBean (VALUE)

Set the PerlBean to which this method belongs. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a (sub)class of:

=over

=item PerlBean

=back

=back

=item getPerlBean ()

Returns the PerlBean to which this method belongs.

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
L<PerlBean::Attribute::Multi::Unique::Associative::MethodKey>,
L<PerlBean::Attribute::Multi::Unique::Ordered>,
L<PerlBean::Attribute::Single>,
L<PerlBean::Collection>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: January 2003

=head1 AUTHOR

Vincenzo Zocca

=head1 COPYRIGHT

Copyright 2003 by Vincenzo Zocca

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
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::Method::_initialize, first argument must be 'HASH' reference.");

	# body, SINGLE
	exists ($opt->{body}) && $self->setBody ($opt->{body});

	# description, SINGLE
	exists ($opt->{description}) && $self->setDescription ($opt->{description});

	# exception_class, SINGLE, with default value
	$self->setExceptionClass (exists ($opt->{exception_class}) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class});

	# interface, BOOLEAN
	exists ($opt->{interface}) && $self->setInterface ($opt->{interface});

	# method_name, SINGLE, mandatory
	exists ($opt->{method_name}) || throw Error::Simple ("ERROR: PerlBean::Method::_initialize, option 'method_name' is mandatory.");
	$self->setMethodName ($opt->{method_name});

	# parameter_description, SINGLE
	exists ($opt->{parameter_description}) && $self->setParameterDescription ($opt->{parameter_description});

	# perl_bean, SINGLE
	exists ($opt->{perl_bean}) && $self->setPerlBean ($opt->{perl_bean});

	# Return $self
	return ($self);
}

sub getPackage {
	my $self = shift;

	defined ($self->getPerlBean) && return ( $self->getPerlBean ()->getPackage ());
	return ('main');
}

sub getSuperMethod {
	my $self = shift;

	# No super method found if no collection defined
	defined ($self->getPerlBean ()) || return (undef);
	defined ($self->getPerlBean ()->getCollection ()) || return (undef);

	# Look for the method in super classes
	foreach my $super_pkg ($self->getPerlBean ()->getBase ()) {
		# Get the superclass bean
		my $super_bean = ($self->getPerlBean ()->getCollection ()->valuesPerlBean ($super_pkg))[0];

		# If the super class bean has no bean in the collection then no method is found
		defined ($super_bean) || return (undef);

		# See if the super class bean has the method
		my $super_meth = $super_bean->getSuperMethod ($self, {
			$self->getPerlBean ()->getPackage () => 1,
		});

		# Return the suprclass method if found
		defined ($super_meth) && return ($super_meth);
	}

	# Nothing found
	return (undef);
}

sub writeCode {
	my $self = shift;
	my $fh = shift;

	my $name = $self->getMethodName ();
	my $body = $self->isInterface () ?
			"\tthrow Error::Simple (\"ERROR: " .
			$self->getPackage () .
			'::' .
			$self->getMethodName () .
			", call this method in a subclass that has implemented it.\");\n"
		: '';
	$body = defined ($self->getBody ()) ? $self->getBody () : $body;
	$fh->print (<<EOF);
$SUB $name {
$body}

EOF
}

sub writePod {
	my $self = shift;
	my $fh = shift;
	my $pkg = shift;

	my $name = $self->getMethodName ();
	my $pre = '';
	my $par = $self->getParameterDescription ();
	my $desc = $self->getDescription ();
	if ($pkg eq $self->getPackage ()) {
		my $super_meth = $self->getSuperMethod ();
		if (defined ($super_meth)) {
			if ($super_meth->isInterface ()) {
				$self->isInterface () && throw Error::Simple (
					"ERROR: PerlBean::Method::writePod, superclass '" .
					$super_meth->getPackage () .
					"' defined method '$name' as interface and package '" .
					$self->getPackage () .
					"' -which is a subclass- too defines the method as interface"
				);
				$pre = "This method is an implementation from package C<'" .
					$super_meth->getPackage () . "'>. ";
			} else {
				$pre = "This method is overloaded from package C<'" .
					$super_meth->getPackage () . "'>. ";
			}
		} elsif ($self->isInterface ()) {
			$pre = "This is an interface method. ";
		}
	} else {
		$pre = "This method is inherited from package C<'" .
			$self->getPackage () . "'>. ";
	}
	$fh->print (<<EOF);
\=item $name ($par)

$pre$desc

EOF
}

sub setBody {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('body', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setBody, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{body} = $val;
}

sub getBody {
	my $self = shift;

	return ($self->{PerlBean_Method}{body});
}

sub setDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('description', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{description} = $val;
}

sub getDescription {
	my $self = shift;

	if ($self->{PerlBean_Method}{description}) {
		if ($self->{PerlBean_Method}{description} =~ /__SUPER_POD__/) {
			my $super_meth = $self->getSuperMethod ();
			my $super_pod = '';
			$super_pod = $super_meth->getDescription () if (defined ($super_meth));
			my $ret = $self->{PerlBean_Method}{description};
			$ret =~ s/__SUPER_POD__/$super_pod/g;
			return ($ret);
		} else {
			return ($self->{PerlBean_Method}{description});
		}
	}

	my $super_meth = $self->getSuperMethod ();
	defined ($super_meth) && return ($super_meth->getDescription ());

	return ('');
}

sub setExceptionClass {
	my $self = shift;
	my $val = shift;

	# Value for 'exception_class' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::Method::setExceptionClass, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('exception_class', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setExceptionClass, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{exception_class} = $val;
}

sub getExceptionClass {
	my $self = shift;

	return ($self->{PerlBean_Method}{exception_class});
}

sub setInterface {
	my $self = shift;

	if (shift) {
		$self->{PerlBean_Method}{interface} = 1;
	} else {
		$self->{PerlBean_Method}{interface} = 0;
	}
}

sub isInterface {
	my $self = shift;

	if ($self->{PerlBean_Method}{interface}) {
		return (1);
	} else {
		return (0);
	}
}

sub setMethodName {
	my $self = shift;
	my $val = shift;

	# Value for 'method_name' is not allowed to be empty
	defined ($val) || throw Error::Simple ("ERROR: PerlBean::Method::setMethodName, value may not be empty.");

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('method_name', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setMethodName, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{method_name} = $val;
}

sub getMethodName {
	my $self = shift;

	return ($self->{PerlBean_Method}{method_name});
}

sub setParameterDescription {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('parameter_description', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setParameterDescription, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{parameter_description} = $val;
}

sub getParameterDescription {
	my $self = shift;

	if ($self->{PerlBean_Method}{parameter_description}) {
		if ($self->{PerlBean_Method}{parameter_description} =~ /__SUPER_POD__/) {
			my $super_meth = $self->getSuperMethod ();
			my $super_pod = '';
			$super_pod = $super_meth->getParameterDescription () if (defined ($super_meth));
			my $ret = $self->{PerlBean_Method}{parameter_description};
			$ret =~ s/__SUPER_POD__/$super_pod/g;
			return ($ret);
		} else {
			return ($self->{PerlBean_Method}{parameter_description});
		}
	}

	my $super_meth = $self->getSuperMethod ();
	defined ($super_meth) && return ($super_meth->getParameterDescription ());

	return ('');
}

sub setPerlBean {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('perl_bean', $val) || throw Error::Simple ("ERROR: PerlBean::Method::setPerlBean, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Method}{perl_bean} = $val;
}

sub getPerlBean {
	my $self = shift;

	return ($self->{PerlBean_Method}{perl_bean});
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

