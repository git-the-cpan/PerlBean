package PerlBean::Attribute::Single;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

use base qw (PerlBean::Attribute);

our ( $VERSION ) = '$Revision: 0.3 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
	'allow_empty' => 1,
);

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Single - contains SINGLE bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Single;
 my $attr = PerlBean::Attribute::Single->new ({
 	attribute_name => 'name',
 	short_description => 'my name',
 });
 
 use IO::File;
 -d 'tmp' || mkdir ('tmp');
 my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Single.pl.out');
 $attr->writeMethods ($fh);
 $attr->writeDocMethods ($fh);

=head1 ABSTRACT

SINGLE bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Single> contains SINGLE bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code and documentation methods are implemented.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Single> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<allow_empty>>

Passed to L<setAllowEmpty ()>. Defaults to B<1>.

=item B<C<allow_isa>>

Passed to L<setAllowIsa ()>. Must be an C<ARRAY> reference.

=item B<C<allow_ref>>

Passed to L<setAllowRef ()>. Must be an C<ARRAY> reference.

=item B<C<allow_rx>>

Passed to L<setAllowRx ()>. Must be an C<ARRAY> reference.

=item B<C<allow_value>>

Passed to L<setAllowValue ()>. Must be an C<ARRAY> reference.

=back

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Attribute>> may include:

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

=item getOverloadedAttribute ()

This method is inherited from package C<'PerlBean::Attribute'>. Searches superclass packages for an identically named C<PerlBean::Attribute>. If found it is returned otherwise C<undef> is returned

=item getPackage ()

This method is inherited from package C<'PerlBean::Attribute'>. Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.

=item getPackageUS ()

This method is inherited from package C<'PerlBean::Attribute'>. Calls C<getPackage ()> and replaces C<:+> with C <_>.

=item type ()

This method is inherited from package C<'PerlBean::Attribute'>. Determins and returns the type of the attribute. The type is either C<BOOLEAN>, C<SINGLE> or C<MULTI>.

=item writeAllowIsa (FILEHANDLE)

Writes C<%ALLOW_ISA> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowRef (FILEHANDLE)

Writes C<%ALLOW_REF> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowRx (FILEHANDLE)

Writes C<%ALLOW_RX> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowValue (FILEHANDLE)

Writes C<%ALLOW_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDefaultValue (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocClauses (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInheritMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInit (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeOptInit (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item setAllowEmpty (VALUE)

State that the attribute is allowed to be empty. C<VALUE> is the value. Default value at initialization is C<1>. On error an exception C<Error::Simple> is thrown.

=item isAllowEmpty ()

Returns whether the attribute is allowed to be empty or not.

=item setAllowIsa (ARRAY)

Set the list of allowed classes absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowIsa (ARRAY)

Add additional values on the list of allowed classes. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowIsa (ARRAY)

Delete elements from the list of allowed classes. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsAllowIsa (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed classes.

=item valuesAllowIsa ()

Returns an C<ARRAY> containing all values of the list of allowed classes.

=item setAllowRef (ARRAY)

Set the list of allowed references absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowRef (ARRAY)

Add additional values on the list of allowed references. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowRef (ARRAY)

Delete elements from the list of allowed references. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsAllowRef (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed references.

=item valuesAllowRef ()

Returns an C<ARRAY> containing all values of the list of allowed references.

=item setAllowRx (ARRAY)

Set the list of allow regular expressions absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowRx (ARRAY)

Add additional values on the list of allow regular expressions. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowRx (ARRAY)

Delete elements from the list of allow regular expressions. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsAllowRx (ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allow regular expressions.

=item valuesAllowRx ()

Returns an C<ARRAY> containing all values of the list of allow regular expressions.

=item setAllowValue (ARRAY)

Set allowed values absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item addAllowValue (ARRAY)

Add additional values on allowed values. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item deleteAllowValue (ARRAY)

Delete elements from allowed values. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item existsAllowValue (ARRAY)

Returns the count of items in C<ARRAY> that are in allowed values.

=item valuesAllowValue ()

Returns an C<ARRAY> containing all values of allowed values.

=back

=head1 INHERITED METHODS FROM PerlBean::Attribute

=over

=item To access attribute named B<C<attribute_name>>:

setAttributeName (), getAttributeName ()

=item To access attribute named B<C<default_value>>:

setDefaultValue (), getDefaultValue ()

=item To access attribute named B<C<exception_class>>:

setExceptionClass (), getExceptionClass ()

=item To access attribute named B<C<mandatory>>:

setMandatory (), isMandatory ()

=item To access attribute named B<C<method_base>>:

setMethodBase (), getMethodBase ()

=item To access attribute named B<C<perl_bean>>:

setPerlBean (), getPerlBean ()

=item To access attribute named B<C<short_description>>:

setShortDescription (), getShortDescription ()

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
L<PerlBean::Collection>,
L<PerlBean::Method>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: November 2002

=head1 AUTHOR

Vincenzo Zocca

=head1 COPYRIGHT

Copyright 2002, 2003 by Vincenzo Zocca

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

sub _initialize {
	my $self = shift;
	my $opt = defined ($_[0]) ? shift : {};

	# Check $opt
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::_initialize, first argument must be 'HASH' reference.");

	# allow_empty, BOOLEAN, with default value
	$self->setAllowEmpty (exists ($opt->{allow_empty}) ? $opt->{allow_empty} : $DEFAULT_VALUE{allow_empty});

	# allow_isa, MULTI
	if (exists ($opt->{allow_isa})) {
		ref ($opt->{allow_isa}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_isa' must be an 'ARRAY' reference.");
		$self->setAllowIsa (@{$opt->{allow_isa}});
	} else {
		$self->setAllowIsa ();
	}

	# allow_ref, MULTI
	if (exists ($opt->{allow_ref})) {
		ref ($opt->{allow_ref}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_ref' must be an 'ARRAY' reference.");
		$self->setAllowRef (@{$opt->{allow_ref}});
	} else {
		$self->setAllowRef ();
	}

	# allow_rx, MULTI
	if (exists ($opt->{allow_rx})) {
		ref ($opt->{allow_rx}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_rx' must be an 'ARRAY' reference.");
		$self->setAllowRx (@{$opt->{allow_rx}});
	} else {
		$self->setAllowRx ();
	}

	# allow_value, MULTI
	if (exists ($opt->{allow_value})) {
		ref ($opt->{allow_value}) eq 'ARRAY' || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_value' must be an 'ARRAY' reference.");
		$self->setAllowValue (@{$opt->{allow_value}});
	} else {
		$self->setAllowValue ();
	}

	# Call the superclass' _initialize
	$self->SUPER::_initialize ($opt);

	# Return $self
	return ($self);
}

sub writeAllowIsa {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->valuesAllowIsa ())) {
		my $an = $self->escQuote( $self->getAttributeName ());
		my $dv = $self->escQuote (sort ($self->valuesAllowIsa ()));
		$fh->print (<<EOF);
\t$an => [ $dv ],
EOF
	}
}

sub writeAllowRef {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->valuesAllowRef ())) {
		my $an = $self->escQuote( $self->getAttributeName ());
		$fh->print (<<EOF);
\t$an => {
EOF
		my @dv = sort ($self->escQuoteL ($self->valuesAllowRef ()));
		foreach my $dv (@dv) {
			$fh->print (<<EOF);
\t\t$dv => 1,
EOF
		}
		$fh->print (<<EOF);
\t},
EOF
	}
}

sub writeAllowRx {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->valuesAllowRx ())) {
		my $an = $self->escQuote( $self->getAttributeName ());
		my $dv = $self->escQuote (sort ($self->valuesAllowRx ()));
		$fh->print (<<EOF);
\t$an => [ $dv ],
EOF
	}
}

sub writeAllowValue {
	my $self = shift;
	my $fh = shift;

	if (scalar ($self->valuesAllowValue ())) {
		my $an = $self->escQuote( $self->getAttributeName ());
		$fh->print (<<EOF);
\t$an => {
EOF
		my @dv = sort ($self->escQuoteL ($self->valuesAllowValue ()));
		foreach my $dv (@dv) {
			$fh->print (<<EOF);
\t\t$dv => 1,
EOF
		}
		$fh->print (<<EOF);
\t},
EOF
	}
}

sub writeDefaultValue {
	my $self = shift;
	my $fh = shift;

	defined ($self->getDefaultValue ()) || return;

	my $an = $self->escQuote( $self->getAttributeName ());
	my $dv = $self->escQuote ($self->getDefaultValue ());
	$fh->print (<<EOF);
\t$an => $dv,
EOF
}

sub writeDocInheritMethods {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();

	my @meth = ();
	foreach my $op (qw (set get)) {
		push (@meth, "$op$mb ()");
	}
	my $meth = join (', ', @meth);

	$fh->print (<<EOF);
$meth

EOF
}

sub writeDocInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $mand = $self->isMandatory () ? ' Mandatory option.' : '';
	my $def = '';
	if (defined ($self->getDefaultValue ())) {
		$def = ' Defaults to B<' . $self->getDefaultValue () . '>.';
	}

	$fh->print (<<EOF);
\=item B<C<$an>>

Passed to L<set$mb ()>.${mand}${def}

EOF
}

sub writeDocMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetDoc ($fh);
	$self->writeGetDoc ($fh);
}

sub writeMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetMethod ($fh);
	$self->writeGetMethod ($fh);

}

sub writeOptInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();

	# Comment
	$fh->print ("\t# $an, ", $self->type ());
	$self->isMandatory () && $fh->print (', mandatory');
	defined ($self->getDefaultValue ()) && $fh->print (', with default value');
	$fh->print ("\n");

	# isMandatory check
	if ($self->isMandatory ()) {
		$fh->print (<<EOF);
	exists (\$opt->{$an}) || throw $ec ("ERROR: ${pkg}::_initialize, option '$an' is mandatory.");
EOF
	}

	if ($self->isMandatory ()) {
		$fh->print (<<EOF);
	\$self->set$mb (\$opt->{$an});
EOF
	} else {
		if (defined ($self->getDefaultValue ())) {
		$fh->print (<<EOF);
	\$self->set$mb (exists (\$opt->{$an}) ? \$opt->{$an} : \$DEFAULT_VALUE{$an});
EOF
		} else {
		$fh->print (<<EOF);
	exists (\$opt->{$an}) && \$self->set$mb (\$opt->{$an});
EOF
		}
	}

	# Empty line
	$fh->print ("\n");
}

sub setAllowEmpty {
	my $self = shift;

	if (shift) {
		$self->{PerlBean_Attribute_Single}{allow_empty} = 1;
	} else {
		$self->{PerlBean_Attribute_Single}{allow_empty} = 0;
	}
}

sub isAllowEmpty {
	my $self = shift;

	if ($self->{PerlBean_Attribute_Single}{allow_empty}) {
		return (1);
	} else {
		return (0);
	}
}

sub setAllowIsa {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_isa', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::setAllowIsa, one or more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{PerlBean_Attribute_Single}{allow_isa} = {};

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_isa}{$val} = $val;
	}
}

sub addAllowIsa {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_isa', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::addAllowIsa, one or more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_isa}{$val} = $val;
	}
}

sub deleteAllowIsa {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean_Attribute_Single}{allow_isa}{$val}) || next;
		delete ($self->{PerlBean_Attribute_Single}{allow_isa}{$val});
		$del++;
	}
	return ($del);
}

sub existsAllowIsa {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean_Attribute_Single}{allow_isa}{$val});
	}
	return ($count);
}

sub valuesAllowIsa {
	my $self = shift;

	# Return all values
	return (values (%{$self->{PerlBean_Attribute_Single}{allow_isa}}));
}

sub setAllowRef {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_ref', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::setAllowRef, one or more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{PerlBean_Attribute_Single}{allow_ref} = {};

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_ref}{$val} = $val;
	}
}

sub addAllowRef {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_ref', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::addAllowRef, one or more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_ref}{$val} = $val;
	}
}

sub deleteAllowRef {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean_Attribute_Single}{allow_ref}{$val}) || next;
		delete ($self->{PerlBean_Attribute_Single}{allow_ref}{$val});
		$del++;
	}
	return ($del);
}

sub existsAllowRef {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean_Attribute_Single}{allow_ref}{$val});
	}
	return ($count);
}

sub valuesAllowRef {
	my $self = shift;

	# Return all values
	return (values (%{$self->{PerlBean_Attribute_Single}{allow_ref}}));
}

sub setAllowRx {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_rx', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::setAllowRx, one or more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{PerlBean_Attribute_Single}{allow_rx} = {};

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_rx}{$val} = $val;
	}
}

sub addAllowRx {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_rx', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::addAllowRx, one or more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_rx}{$val} = $val;
	}
}

sub deleteAllowRx {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean_Attribute_Single}{allow_rx}{$val}) || next;
		delete ($self->{PerlBean_Attribute_Single}{allow_rx}{$val});
		$del++;
	}
	return ($del);
}

sub existsAllowRx {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean_Attribute_Single}{allow_rx}{$val});
	}
	return ($count);
}

sub valuesAllowRx {
	my $self = shift;

	# Return all values
	return (values (%{$self->{PerlBean_Attribute_Single}{allow_rx}}));
}

sub setAllowValue {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_value', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::setAllowValue, one or more specified value(s) '@_' is/are not allowed.");

	# Empty list
	$self->{PerlBean_Attribute_Single}{allow_value} = {};

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_value}{$val} = $val;
	}
}

sub addAllowValue {
	my $self = shift;

	# Check if isas/refs/rxs/values are allowed
	&valueIsAllowed ('allow_value', @_) || throw Error::Simple ("ERROR: PerlBean::Attribute::Single::addAllowValue, one or more specified value(s) '@_' is/are not allowed.");

	# Add values
	foreach my $val (@_) {
		$self->{PerlBean_Attribute_Single}{allow_value}{$val} = $val;
	}
}

sub deleteAllowValue {
	my $self = shift;

	# Delete values
	my $del = 0;
	foreach my $val (@_) {
		exists ($self->{PerlBean_Attribute_Single}{allow_value}{$val}) || next;
		delete ($self->{PerlBean_Attribute_Single}{allow_value}{$val});
		$del++;
	}
	return ($del);
}

sub existsAllowValue {
	my $self = shift;

	# Count occurences
	my $count = 0;
	foreach my $val (@_) {
		$count += exists ($self->{PerlBean_Attribute_Single}{allow_value}{$val});
	}
	return ($count);
}

sub valuesAllowValue {
	my $self = shift;

	# Return all values
	return (values (%{$self->{PerlBean_Attribute_Single}{allow_value}}));
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

sub escQuoteL {
	my $self = shift;

	my @in = @_;
	my @el = ();
	foreach my $el (@in) {
		$el = $self->escQuote ($el);
		push (@el, $el);
	}
	return (@el);
}

sub writeSetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $an_esc = $self->escQuote ($an);
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();
	my $pkg_us = $self->getPackageUS ();


	# Method head
	$fh->print (<<EOF);
$SUB set$mb {
	my \$self = shift;
	my \$val = shift;

EOF

	# Check if value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# Value for $an_esc is not allowed to be empty
	defined (\$val) || throw $ec ("ERROR: ${pkg}::set$mb, value may not be empty.");

EOF
	}

	# Check if isa/ref/rx/value is allowed
	$fh->print (<<EOF);
	# Check if isa/ref/rx/value is allowed
	\&valueIsAllowed ($an_esc, \$val) || throw $ec ("ERROR: ${pkg}::set$mb, the specified value '\$val' is not allowed.");

EOF

	# Assignment and method tail
	$fh->print (<<EOF);
	# Assignment
	\$self->{$pkg_us}{$an} = \$val;
}

EOF
}

sub writeSetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . $self->getDefaultValue () . '>.' : '';
	my $empt = $self->isAllowEmpty () ? '' : ' C<VALUE> may not be C<undef>.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';
	my $attr_overl = $self->getOverloadedAttribute ();
	my $overl = defined ($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->getPackage () .'>.': '';

	$fh->print (<<EOF);
\=item set${mb} (VALUE)

Set ${desc}. C<VALUE> is the value.${def}${empt}${exc}${overl}

EOF

	$self->writeDocClauses ($fh);
}

sub writeGetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB get$mb {
	my \$self = shift;

	return (\$self->{$pkg_us}{$an});
}

EOF
}

sub writeGetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item get${mb} ()

Returns ${desc}.

EOF
}

sub writeDocClausesAllowIsa {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowIsa ()));

	$fh->print (<<EOF);
\=item VALUE must be a (sub)class of:

\=over

EOF

	foreach my $class (sort ($self->valuesAllowIsa ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowRef {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowRef ()));
	my $or = scalar ($self->valuesAllowIsa ()) ? 'Or, ' : '';

	$fh->print (<<EOF);
\=item ${or}VALUE must be a reference of:

\=over

EOF

	foreach my $class (sort ($self->valuesAllowRef ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowRx {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowRx ()));
	my $or = scalar ($self->valuesAllowIsa () || $self->valuesAllowRef ()) ? 'Or, ' : '';

	$fh->print (<<EOF);
\=item ${or}VALUE must match regular expression:

\=over

EOF

	foreach my $class (sort ($self->valuesAllowRx ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

sub writeDocClausesAllowValue {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowValue ()));
	my $or = scalar ($self->valuesAllowIsa () || $self->valuesAllowRef () || $self->valuesAllowRx ()) ? 'Or, ' : '';

	$fh->print (<<EOF);
\=item ${or}VALUE must be a one of:

\=over

EOF

	foreach my $class (sort ($self->valuesAllowValue ())) {
		$fh->print (<<EOF);
\=item ${class}

EOF
	}

	$fh->print (<<EOF);
\=back

EOF
}

