package PerlBean::Attribute::Multi::Unique::Associative::MethodKey;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

use base qw (PerlBean::Attribute::Multi);

our ( $VERSION ) = '$Revision: 0.5 $ ' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
	'id_method' => 'getId',
);

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Multi::Unique::Associative::MethodKey - contains unique associative MULTI bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Multi::Unique::Associative::MethodKey;
 my $attr = PerlBean::Attribute::Multi::Unique::Associative::MethodKey->new ({
 	attribute_name => 'ssns_i_know_from_people',
 	short_description => 'all SSNs I know from people',
 });
 
 use IO::File;
 -d 'tmp' || mkdir ('tmp');
 my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Multi_Unique_Associative_MethodKey.pl.out');
 $attr->writeMethods ($fh);
 $attr->writeDocMethods ($fh);

=head1 ABSTRACT

Unique, associative MULTI bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Multi::Unique::Associative::MethodKey> contains information on unique associative MULTI bean attribute that gets its key from an object method. It is a subclass of C<PerlBean::Attribute::Multi>. The code generation and documentation methods from C<PerlBean::Attribute> are implemented.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Multi::Unique::Associative::MethodKey> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<id_method>>

Passed to L<setIdMethod ()>. Defaults to B<getId>.

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

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Attribute::Single>> may include:

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

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_ISA> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowRef (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_REF> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowRx (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_RX> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeAllowValue (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDefaultValue (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocClauses (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInheritMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Multi'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.

=item writeDocInit (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Multi'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.

=item writeMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Multi'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.

=item writeOptInit (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item setIdMethod (VALUE)

Set the method to obtain the ID from the item in the list. C<VALUE> is the value. Default value at initialization is C<getId>. On error an exception C<Error::Simple> is thrown.

=item getIdMethod ()

Returns the method to obtain the ID from the item in the list.

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

=head1 INHERITED METHODS FROM PerlBean::Attribute::Single

=over

=item To access attribute named B<C<allow_empty>>:

setAllowEmpty (), isAllowEmpty ()

=item To access attribute named B<C<allow_isa>>:

setAllowIsa (), addAllowIsa (), deleteAllowIsa (), existsAllowIsa (), valuesAllowIsa ()

=item To access attribute named B<C<allow_ref>>:

setAllowRef (), addAllowRef (), deleteAllowRef (), existsAllowRef (), valuesAllowRef ()

=item To access attribute named B<C<allow_rx>>:

setAllowRx (), addAllowRx (), deleteAllowRx (), existsAllowRx (), valuesAllowRx ()

=item To access attribute named B<C<allow_value>>:

setAllowValue (), addAllowValue (), deleteAllowValue (), existsAllowValue (), valuesAllowValue ()

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
L<PerlBean::Attribute::Single>,
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
	ref ($opt) eq 'HASH' || throw Error::Simple ("ERROR: PerlBean::Attribute::Multi::Unique::Associative::MethodKey::_initialize, first argument must be 'HASH' reference.");

	# id_method, SINGLE, with default value
	$self->setIdMethod (exists ($opt->{id_method}) ? $opt->{id_method} : $DEFAULT_VALUE{id_method});

	# Call the superclass' _initialize
	$self->SUPER::_initialize ($opt);

	# Return $self
	return ($self);
}

sub writeDocInheritMethods {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();

	my @meth = ();
	foreach my $op (qw (set add delete exists keys values)) {
		push (@meth, "$op$mb ()");
	}
	my $meth = join (', ', @meth);

	$fh->print (<<EOF);
$meth

EOF
}

sub writeDocMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetDoc ($fh);
	$self->writeAddDoc ($fh);
	$self->writeDeleteDoc ($fh);
	$self->writeExistsDoc ($fh);
	$self->writeKeysDoc ($fh);
	$self->writeValuesDoc ($fh);
}

sub writeMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetMethod ($fh);
	$self->writeAddMethod ($fh);
	$self->writeDeleteMethod ($fh);
	$self->writeExistsMethod ($fh);
	$self->writeKeysMethod ($fh);
	$self->writeValuesMethod ($fh);
}

sub setIdMethod {
	my $self = shift;
	my $val = shift;

	# Check if isa/ref/rx/value is allowed
	&valueIsAllowed ('id_method', $val) || throw Error::Simple ("ERROR: PerlBean::Attribute::Multi::Unique::Associative::MethodKey::setIdMethod, the specified value '$val' is not allowed.");

	# Assignment
	$self->{PerlBean_Attribute_Multi_Unique_Associative_MethodKey}{id_method} = $val;
}

sub getIdMethod {
	my $self = shift;

	return ($self->{PerlBean_Attribute_Multi_Unique_Associative_MethodKey}{id_method});
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

sub writeSetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $an_esc = $self->escQuote ($an);
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();
	my $pkg_us = $self->getPackageUS ();
	my $idm = $self->getIdMethod ();

	# Method head
	$fh->print (<<EOF);
$SUB set$mb {
	my \$self = shift;

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	scalar (\@_) || throw $ec ("ERROR: ${pkg}::set$mb, list value may not be empty.");

EOF
	}

	# Check if isas/refs/rxs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/rxs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::set$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

	# Method tail
	$fh->print (<<EOF);
	# Empty list
	\$self->{$pkg_us}{$an} = {};

	# Add keys/values
	foreach my \$val (\@_) {
		\$self->{$pkg_us}{$an}{\$val->$idm ()} = \$val;
	}
}

EOF
}

sub writeSetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . join (', ', @{$self->getDefaultValue ()}) . '>.' : '';
	my $empt = $self->isAllowEmpty () ? '' : ' C<ARRAY> must at least have one element.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';
	my $attr_overl = $self->getOverloadedAttribute ();
	my $overl = defined ($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->getPackage () .'>.': '';
	my $idm = $self->getIdMethod ();

	$fh->print (<<EOF);
\=item set${mb} ([VALUE ...])

Set ${desc} absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<$idm ()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once.${def}${empt}${exc}${overl}

EOF

	$self->writeDocClauses ($fh);
}

sub writeAddMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $an_esc = $self->escQuote ($an);
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();
	my $pkg_us = $self->getPackageUS ();
	my $idm = $self->getIdMethod ();

	# Method head
	$fh->print (<<EOF);
$SUB add$mb {
	my \$self = shift;

EOF

	# Check if isas/refs/rxs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/rxs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::add$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

	# Method tail
	$fh->print (<<EOF);
	# Add keys/values
	foreach my \$val (\@_) {
		\$self->{$pkg_us}{$an}{\$val->$idm ()} = \$val;
	}
}

EOF
}

sub writeAddDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item add${mb} ([VALUE ...])

Add additional values on ${desc}. Each C<VALUE> is an object out of which the id is obtained through method C<$idm ()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once.${def}${empt}${exc}${overl}

EOF

	$self->writeDocClauses ($fh);
}

sub writeDeleteMethod {
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
$SUB delete$mb {
	my \$self = shift;

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	my \%would_delete = ();
	foreach my \$val (\@_) {
		\$would_delete{\$val} = \$val if (exists (\$self->{$pkg_us}{$an}{\$val}))
	}
	(scalar (keys (\%{\$self->{$pkg_us}{$an}})) == scalar (keys (\%would_delete))) && throw $ec ("ERROR: ${pkg}::delete$mb, list value may not be empty.");

EOF
	}

	# Method tail
	$fh->print (<<EOF);
	# Delete values
	my \$del = 0;
	foreach my \$val (\@_) {
		exists (\$self->{$pkg_us}{$an}{\$val}) || next;
		delete (\$self->{$pkg_us}{$an}{\$val});
		\$del++;
	}
	return (\$del);
}

EOF
}

sub writeDeleteDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $empt = $self->isAllowEmpty () ? '' : ' After deleting at least one element must remain.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item delete${mb} (ARRAY)

Delete elements from ${desc}.${empt} Returns the number of deleted elements.${exc}

EOF
}

sub writeExistsMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB exists$mb {
	my \$self = shift;

	# Count occurences
	my \$count = 0;
	foreach my \$val (\@_) {
		\$count += exists (\$self->{$pkg_us}{$an}{\$val});
	}
	return (\$count);
}

EOF
}

sub writeExistsDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item exists${mb} (ARRAY)

Returns the count of items in C<ARRAY> that are in ${desc}.

EOF
}

sub writeKeysMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB keys$mb {
	my \$self = shift;

	# Return all keys
	return (keys (\%{\$self->{$pkg_us}{$an}}));
}

EOF
}

sub writeKeysDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item keys${mb} ()

Returns an C<ARRAY> containing the keys of ${desc}.

EOF
}

sub writeValuesMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB values$mb {
	my \$self = shift;

	if (scalar (\@_)) {
		my \@ret = ();
		foreach my \$key (\@_) {
			exists (\$self->{$pkg_us}{$an}{\$key}) && push (\@ret, \$self->{$pkg_us}{$an}{\$key});
		}
		return (\@ret);
	} else {
		# Return all values
		return (values (\%{\$self->{$pkg_us}{$an}}));
	}
}

EOF
}

sub writeValuesDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item values${mb} ([KEY_ARRAY])

Returns an C<ARRAY> containing the values of ${desc}. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

EOF
}

