package PerlBean::Attribute::Boolean;

use 5.005;
use strict;
use warnings;
use Error qw (:try);
use AutoLoader qw (AUTOLOAD);

use base qw (PerlBean::Attribute);

our ( $VERSION ) = '$Revision: 0.5 $ ' =~ /\$Revision:\s+([^\s]+)/;

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Boolean - contains BOOLEAN bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Boolean;
 my $attr = PerlBean::Attribute::Boolean->new ({
 	attribute_name => 'true',
 	short_description => 'something is true',
 });
 
 use IO::File;
 -d 'tmp' || mkdir ('tmp');
 my $fh = IO::File->new ('> tmp/PerlBean_Attribute_Boolean.pl.out');
 $attr->writeMethods ($fh);
 $attr->writeDocMethods ($fh);

=head1 ABSTRACT

BOOLEAN bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Boolean> contains BOOLEAN bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code generation and documentation methods are implemented.

=head1 CONSTRUCTOR

=over

=item new (OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Boolean> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

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

=item writeDefaultValue (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocClauses (FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocInheritMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item writeDocInit (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item writeDocMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item writeMethods (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item writeOptInit (FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

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
L<PerlBean::Attribute::Factory>,
L<PerlBean::Attribute::Multi>,
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
	my $dv = '0';
	if ($self->getDefaultValue ()) {
		$dv = 1;
	}
	$fh->print (<<EOF);
\t$an => $dv,
EOF
}

sub writeDocInheritMethods {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();

	my @meth = ();
	foreach my $op (qw (set is)) {
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

	$self->writeDocSetMethod ($fh);
	$self->writeDocIsMethod ($fh);
}

sub writeMethods {
	my $self = shift;
	my $fh = shift;

	$self->writeSetMethod ($fh);
	$self->writeIsMethod ($fh);
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

sub writeSetMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB set$mb {
	my \$self = shift;

	if (shift) {
		\$self->{$pkg_us}{$an} = 1;
	} else {
		\$self->{$pkg_us}{$an} = 0;
	}
}

EOF
}

sub writeDocSetMethod {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';
	my $def = defined ($self->getDefaultValue ()) ? ' Default value at initialization is C<' . $self->getDefaultValue () . '>.' : '';
	my $exc = ' On error an exception C<' . $self->getExceptionClass () . '> is thrown.';
	my $attr_overl = $self->getOverloadedAttribute ();
	my $overl = defined ($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->getPerlBean ()->getPackage () .'>.': '';

	$fh->print (<<EOF);
\=item set${mb} (VALUE)

State that ${desc}. C<VALUE> is the value.${def}${empt}${exc}${overl}

EOF
}

sub writeIsMethod {
	my $self = shift;
	my $fh = shift;

	my $an = $self->getAttributeName ();
	my $mb = $self->getMethodBase ();
	my $pkg_us = $self->getPackageUS ();

	$fh->print (<<EOF);
$SUB is$mb {
	my \$self = shift;

	if (\$self->{$pkg_us}{$an}) {
		return (1);
	} else {
		return (0);
	}
}

EOF
}

sub writeDocIsMethod {
	my $self = shift;
	my $fh = shift;

	my $mb = $self->getMethodBase ();
	my $desc = defined ($self->getShortDescription ()) ? $self->getShortDescription () : 'not described option';

	$fh->print (<<EOF);
\=item is${mb} ()

Returns whether ${desc} or not.

EOF
}

