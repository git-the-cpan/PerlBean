package PerlBean::Attribute::Multi;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

use base qw (PerlBean::Attribute::Single);

our ( $VERSION ) = '$Revision: 0.5 $ ' =~ /\$Revision:\s+([^\s]+)/;

1;

__END__

=head1 NAME

PerlBean::Attribute::Multi - contains MULTI bean attribute information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

MULTI bean attribute abstraction

=head1 DESCRIPTION

C<PerlBean::Attribute::Multi> is a subclass of C<PerlBean::Attribute> and it's only function is to group the MULTI attribute classes.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Multi> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

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

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocClauses (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInheritMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.

=item writeDocInit (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.

=item writeMethods (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.

=item writeOptInit (FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

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
L<PerlBean::Attribute::Multi::Ordered>,
L<PerlBean::Attribute::Multi::Unique>,
L<PerlBean::Attribute::Multi::Unique::Associative>,
L<PerlBean::Attribute::Multi::Unique::Associative::MethodKey>,
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

sub writeDefaultValue {
	my $self = shift;
	my $fh = shift;

	defined ($self->getDefaultValue ()) || return;

	my $an = $self->escQuote( $self->getAttributeName ());
	my $dv = $self->escQuote (@{$self->getDefaultValue ()});
	$fh->print (<<EOF);
\t$an => [ $dv ],
EOF
}

sub writeDocInheritMethods {
	my $self = shift;

	throw Error::Simple ("ERROR: PerlBean::Attribute::Multi::writeDocInheritMethods, call this method in a subclass that has implemented it.");
}

sub writeDocInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $mand = $self->isMandatory () ? ' Mandatory option.' : '';
	my $multi = ($self->isa ('PerlBean::Attribute::Multi')) ? ' Must be an C<ARRAY> reference.' : '';
	my $def = '';
	if (defined ($self->getDefaultValue ())) {
		my $list = join ('> , B<', $self->escQuoteL (@{$self->getDefaultValue ()}));
		$def = ' Defaults to B<[> B<' . $list . '> B<]>.';
	}

	$fh->print (<<EOF);
\=item B<C<$an>>

Passed to L<set$mb ()>.${multi}${mand}${def}

EOF
}

sub writeDocMethods {
	my $self = shift;

	throw Error::Simple ("ERROR: PerlBean::Attribute::Multi::writeDocMethods, call this method in a subclass that has implemented it.");
}

sub writeMethods {
	my $self = shift;

	throw Error::Simple ("ERROR: PerlBean::Attribute::Multi::writeMethods, call this method in a subclass that has implemented it.");
}

sub writeOptInit {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $ec = $self->getExceptionClass ();
	my $pkg = $self->getPerlBean ()->getPackage ();

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

	my $pre = '';
	if (! $self->isMandatory ()) {
		$pre .= "\t";
		$fh->print (<<EOF);
	if (exists (\$opt->{$an})) {
EOF
	}
	$fh->print (<<EOF);
	${pre}ref (\$opt->{$an}) eq 'ARRAY' || throw $ec ("ERROR: ${pkg}::_initialize, specified value for option '$an' must be an 'ARRAY' reference.");
	${pre}\$self->set$mb (\@{\$opt->{$an}});
EOF
	# default value
	if (! $self->isMandatory ()) {
		if (defined ($self->getDefaultValue ())) {
			$fh->print (<<EOF);
	} else {
		\$self->set$mb (\@{\$DEFAULT_VALUE{$an}});
EOF
		} else {
			$fh->print (<<EOF);
	} else {
		\$self->set$mb ();
EOF
			}
		}
	if (! $self->isMandatory ()) {
		$fh->print (<<EOF);
	}
EOF
	}

	# Empty line
	$fh->print ("\n");
}


sub writeDocClausesAllowIsa {
	my $self = shift;
	my $fh = shift;

	return if (!scalar ($self->valuesAllowIsa ()));

	$fh->print (<<EOF);
\=item The values in C<ARRAY> must be a (sub)class of:

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
	my $or = scalar ($self->valuesAllowIsa ()) ? 'Or, the' : 'The';

	$fh->print (<<EOF);
\=item ${or} values in C<ARRAY> must be a reference of:

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
	my $or = scalar ($self->valuesAllowIsa () || $self->valuesAllowRef ()) ? 'Or, the' : 'The';

	$fh->print (<<EOF);
\=item ${or} values in C<ARRAY> must match regular expression:

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
	my $or = scalar ($self->valuesAllowIsa () || $self->valuesAllowRef () || $self->valuesAllowRx ()) ? 'Or, the' : 'The';

	$fh->print (<<EOF);
\=item ${or} values in C<ARRAY> must be a one of:

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

