package PerlBean::Attribute::Multi::Ordered;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

use base qw (PerlBean::Attribute::Multi);

our ( $VERSION ) = '$Revision: 0.2.0.2 $ ' =~ /\$Revision:\s+([^\s]+)/;

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Multi::Ordered - contains ordered MULTI bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Multi::Ordered;
 my $attr = PerlBean::Attribute::Multi::Ordered->new ({
 	attribute_name => 'note_to_self',
 	short_description => 'my notes to self',
 });
 
 use IO::File;
 -d 'tmp' || mkdir ('tmp');
 my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Multi_Ordered.pl.out');
 $attr->writeMethods ($fh);
 $attr->writeDocMethods ($fh);

=head1 ABSTRACT

Ordered MULTI bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Multi::Ordered> contains ordered MULTI bean attribute information. It is a subclass of C<PerlBean::Attribute::Multi>. The code generation and documentation methods from C<PerlBean::Attribute> are implemented.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Multi::Ordered> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

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

Inherited/implemented from L<PerlBean::Attribute>.

=over

=item writeMethods (FILEHANDLE)

Writes code for B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<exists> and B<get> methods.

=item writeDocMethods (FILEHANDLE)

Writes documenation for B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<exists> and B<get> methods.

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

sub writeMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetMethod ($fh);
	$self->writeSetIdxMethod ($fh);
	$self->writeSetNumMethod ($fh);
	$self->writePushMethod ($fh);
	$self->writePopMethod ($fh);
	$self->writeShiftMethod ($fh);
	$self->writeUnshiftMethod ($fh);
	$self->writeExistsMethod ($fh);
	$self->writeGetMethod ($fh);
}

sub writeDocMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetDoc ($fh);
	$self->writeSetIdxDoc ($fh);
	$self->writeSetNumDoc ($fh);
	$self->writePushDoc ($fh);
	$self->writePopDoc ($fh);
	$self->writeShiftDoc ($fh);
	$self->writeUnshiftDoc ($fh);
	$self->writeExistsDoc ($fh);
	$self->writeGetDoc ($fh);
}

sub writeDocInheritMethods {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();

	my @meth = ();
	foreach my $op (qw (set setIdx setNum push pop shift unshift exists get)) {
		push (@meth, "$op$mb ()");
	}
	my $meth = join (', ', @meth);

	$fh->print (<<EOF);
$meth

EOF
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

	# Set the list
	$fh->print (<<EOF);
	# Set the list
	\@{\$self->{$pkg_us}{$an}} = \@_;
}

EOF
}

sub writeSetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . join (', ', @{$self->getDefaultValue ()}) . '>.' : '';
	my $empt = $self->isAllowEmpty () ? '' : ' It must at least have one element.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';
	my $attr_overl = $self->getOverloadedAttribute ();
	my $overl = defined ($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->getPackage () .'>.': '';

	$fh->print (<<EOF);
\=item set${mb} (ARRAY)

Set ${desc} absolutely. C<ARRAY> is the list value.${def}${empt}${exc}${overl}

EOF

	$self->writeDocClauses ($fh);
}

sub writeSetIdxMethod {
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
$SUB setIdx$mb {
	my \$self = shift;
	my \$idx = shift;
	my \$val = shift;

EOF

	# Check if index is a positive integer or zero
	$fh->print (<<EOF);
	# Check if index is a positive integer or zero
	(\$idx == int (\$idx)) || throw $ec ("ERROR: ${pkg}::setIdx$mb, the specified index '\$idx' is not an integer.");
	(\$idx >= 0) || throw $ec ("ERROR: ${pkg}::setIdx$mb, the specified index '\$idx' is not a positive integer or zero.");

EOF

	# Check if isas/refs/rxs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/rxs/values are allowed
	\&valueIsAllowed ($an_esc, \$val) || throw $ec ("ERROR: ${pkg}::setIdx$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

	# Set the value in the list
	$fh->print (<<EOF);
	# Set the value in the list
	\$self->{$pkg_us}{$an}[\$idx] = \$val;
}

EOF
}

sub writeSetIdxDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item setIdx${mb} (INDEX, VALUE)

Set value in $desc. C<INDEX> is the integer index which is greater than or equal to C<0>. C<VALUE> is the value.

EOF

	$self->writeDocClauses ($fh);
}

sub writeSetNumMethod {
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
$SUB setNum$mb {
	my \$self = shift;
	my \$num = shift;

EOF

	# Check if index is an integer
	$fh->print (<<EOF);
	# Check if index is an integer
	(\$num == int (\$num)) || throw $ec ("ERROR: ${pkg}::setNum$mb, the specified number '\$num' is not an integer.");

EOF

	# Call setIdx$mb
	$fh->print (<<EOF);
	# Call setIdx$mb
	\$self->setIdx$mb (\$num - 1, @_);
}
EOF
}

sub writeSetNumDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item setNum${mb} (NUMBER, VALUE)

Set value in $desc. C<NUMBER> is the integer index which is greater than C<0>. C<VALUE> is the value.

EOF

	$self->writeDocClauses ($fh);
}

sub writePushMethod {
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
$SUB push$mb {
	my \$self = shift;

EOF

	# Check if isas/refs/rxs/values are allowed
	$fh->print (<<EOF);
	# Check if isas/refs/rxs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::push$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

	$fh->print (<<EOF);
	# Push the list
	push (\@{\$self->{$pkg_us}{$an}}, \@_);
}

EOF
}

sub writePushDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item push${mb} (ARRAY)

Push additional values on ${desc}. C<ARRAY> is the list value.${exc}

EOF

	$self->writeDocClauses ($fh);
}

sub writePopMethod {
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
$SUB pop$mb {
	my \$self = shift;

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	(scalar (\@_) > 1) || throw $ec ("ERROR: ${pkg}::pop$mb, list value may not be empty.");

EOF
	}

	# Method tail
	$fh->print (<<EOF);
	# Pop an element from the list
	return (pop (\@{\$self->{$pkg_us}{$an}}));
}

EOF
}

sub writePopDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $empt = $self->isAllowEmpty () ? '' : ' After popping at least one element must remain.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item pop${mb} ()

Pop and return an element off ${desc}.${empt}${exc}

EOF
}

sub writeShiftMethod {
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
$SUB shift$mb {
	my \$self = shift;

EOF

	# Check if list value is allowed to be empty
	if (! $self->isAllowEmpty ()) {
		$fh->print (<<EOF);
	# List value for $an_esc is not allowed to be empty
	(scalar (\@_) > 1) || throw $ec ("ERROR: ${pkg}::shift$mb, list value may not be empty.");

EOF
	}

	# Method tail
	$fh->print (<<EOF);
	# Shift an element from the list
	return (shift (\@{\$self->{$pkg_us}{$an}}));
}

EOF
}

sub writeShiftDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $empt = $self->isAllowEmpty () ? '' : ' After shifting at least one element must remain.';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item shift${mb} ()

Shift and return an element off ${desc}.${empt}${exc}

EOF
}

sub writeUnshiftMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $an_esc = $self->escQuote ($an);
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPackage ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB unshift$mb {
	my \$self = shift;

	# Check if isas/refs/rxs/values are allowed
	\&valueIsAllowed ($an_esc, \@_) || throw $ec ("ERROR: ${pkg}::unshift$mb, one or more specified value(s) '\@_' is/are not allowed.");

	# Unshift the list
	unshift (\@{\$self->{$pkg_us}{$an}}, \@_);
}

EOF
}

sub writeUnshiftDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';

	$fh->print (<<EOF);
\=item unshift${mb} (ARRAY)

Unshift additional values on ${desc}. C<ARRAY> is the list value.${exc}

EOF

	$self->writeDocClauses ($fh);
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
	foreach my \$val1 (\@_) {
		foreach my \$val2 (\@{\$self->{$pkg_us}{$an}}) {
			(\$val1 eq \$val2) && \$count ++;
		}
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

sub writeGetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB get$mb {
	my \$self = shift;

	if (scalar (\@_)) {
		my \@ret = ();
		foreach my \$i (\@_) {
			push (\@ret, \$self->{$pkg_us}{$an}[int (\$i)]);
		}
		return (\@ret);
	} else {
		# Return the full list
		return (\@{\$self->{$pkg_us}{$an}});
	}
}

EOF
}

sub writeGetDoc {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item get${mb} ([INDEX_ARRAY])

Returns an C<ARRAY> containing ${desc}. C<INDEX_ARRAY> is an optional list of indexes which when specified causes only the indexed elements in the ordered list to be returned. If not specified, all elements are returned.

EOF
}

