package PerlBean::Attribute::Boolean;

use 5.005;
use strict;
use warnings;
use Error qw(:try);
use AutoLoader qw(AUTOLOAD);
use PerlBean::Style qw(:codegen);

use base qw(PerlBean::Attribute);

our ($VERSION) = '$Revision: 0.6 $' =~ /\$Revision:\s+([^\s]+)/;

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Boolean - contains BOOLEAN bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Boolean;
 my $attr = PerlBean::Attribute::Boolean->new( {
     attribute_name => 'true',
     short_description => 'something is true',
 } );
 
 use IO::File;
 -d 'tmp' || mkdir('tmp');
 my $fh = IO::File->new('> tmp/PerlBean_Attribute_Boolean.pl.out');
 $attr->write_methods($fh);
 $attr->write_doc_methods($fh);

=head1 ABSTRACT

BOOLEAN bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Boolean> contains BOOLEAN bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code generation and documentation methods are implemented.

=head1 CONSTRUCTOR

=over

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Boolean> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Attribute>> may include:

=over

=item B<C<attribute_name>>

Passed to L<set_attribute_name()>. Mandatory option.

=item B<C<default_value>>

Passed to L<set_default_value()>.

=item B<C<exception_class>>

Passed to L<set_exception_class()>. Defaults to B<'Error::Simple'>.

=item B<C<mandatory>>

Passed to L<set_mandatory()>. Defaults to B<0>.

=item B<C<method_base>>

Passed to L<set_method_base()>.

=item B<C<perl_bean>>

Passed to L<set_perl_bean()>.

=item B<C<short_description>>

Passed to L<set_short_description()>.

=back

=back

=head1 METHODS

=over

=item get_overloaded_attribute()

This method is inherited from package C<'PerlBean::Attribute'>. Searches superclass packages for an identically named C<PerlBean::Attribute>. If found it is returned otherwise C<undef> is returned.

=item get_package()

This method is inherited from package C<'PerlBean::Attribute'>. Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.

=item get_package_us()

This method is inherited from package C<'PerlBean::Attribute'>. Calls C<get_package()> and replaces C<:+> with C <_>.

=item type()

This method is inherited from package C<'PerlBean::Attribute'>. Determins and returns the type of the attribute. The type is either C<BOOLEAN>, C<SINGLE> or C<MULTI>.

=item write_default_value(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_clauses(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_inherit_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item write_doc_init(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item write_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...> and B<is...>.

=item write_opt_init(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=back

=head1 INHERITED METHODS FROM PerlBean::Attribute

=over

=item To access attribute named B<C<attribute_name>>:

set_attribute_name(), get_attribute_name()

=item To access attribute named B<C<default_value>>:

set_default_value(), get_default_value()

=item To access attribute named B<C<exception_class>>:

set_exception_class(), get_exception_class()

=item To access attribute named B<C<mandatory>>:

set_mandatory(), is_mandatory()

=item To access attribute named B<C<method_base>>:

set_method_base(), get_method_base()

=item To access attribute named B<C<perl_bean>>:

set_perl_bean(), get_perl_bean()

=item To access attribute named B<C<short_description>>:

set_short_description(), get_short_description()

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
L<PerlBean::Method>,
L<PerlBean::Method::Constructor>,
L<PerlBean::Style>

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

sub write_default_value {
    my $self = shift;
    my $fh = shift;

    defined( $self->get_default_value() ) || return;

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my $dv = '0';
    if ( $self->get_default_value() ) {
        $dv = 1;
    }
    $fh->print(<<EOF);
${IND}$an${AO}=>${AO}$dv,
EOF
}

sub write_doc_inherit_methods {
    my $self = shift;
    my $fh = shift;

    my $mb = $self->get_method_base();

    my @meth = ();
    foreach my $lop ( qw(set is) ) {
        my $op = &{$MOF}($lop);
        push( @meth, "$op$mb${BFP}()" );
    }
    my $meth = join( ', ', @meth );

    $fh->print(<<EOF);
$meth

EOF
}

sub write_doc_init {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $mb = $self->get_method_base();
    my $mand = $self->is_mandatory() ? ' Mandatory option.' : '';
    my $def = '';
    if ( defined( $self->get_default_value() ) ) {
        $def = ' Defaults to B<' . $self->esc_aq( $self->get_default_value() ) . '>.';
    }

    $fh->print(<<EOF);
\=item B<C<$an>>

Passed to L<set$mb${BFP}()>.${mand}${def}

EOF
}

sub write_doc_methods {
    my $self = shift;
    my $fh = shift;

    $self->write_doc_set_method($fh);
    $self->write_doc_is_method($fh);
}

sub write_methods {
    my $self = shift;
    my $fh = shift;

    $self->write_set_method($fh);
    $self->write_is_method($fh);
}

sub write_opt_init {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_package();

    # Comment
    $fh->print( "${IND}# $an, ", $self->type() );
    $self->is_mandatory() && $fh->print( ', mandatory' );
    defined( $self->get_default_value() ) && $fh->print(', with default value');
    $fh->print("\n");

    # is_mandatory check
    if ($self->is_mandatory()) {
        $fh->print(<<EOF);
${IND}exists${BFP}(${ACS}\$opt->{$an}${ACS})${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::_initialize, option '$an' is mandatory.");
EOF
    }

    if ( $self->is_mandatory() ) {
        $fh->print(<<EOF);
${IND}\$self->set$mb${BFP}(${ACS}\$opt->{$an}${ACS});
EOF
    }
    else {
        if ( defined( $self->get_default_value () ) ) {
        $fh->print(<<EOF);
${IND}\$self->set$mb${BFP}(${ACS}exists${BFP}(${ACS}\$opt->{$an}${ACS})${AO}?${AO}\$opt->{$an}${AO}:${AO}\$DEFAULT_VALUE{$an}${ACS});
EOF
        }
        else {
        $fh->print(<<EOF);
${IND}exists${BFP}(${ACS}\$opt->{$an}${ACS})${AO}&&${AO}\$self->set$mb${BFP}(${ACS}\$opt->{$an}${ACS});
EOF
        }
    }

    # Empty line
    $fh->print("\n");
}

sub write_set_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $pkg_us = $self->get_package_us();

    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

${IND}if${BCP}(shift)${PBOC[1]}{
${IND}${IND}\$self->{$pkg_us}{$an}${AO}=${AO}1;
${IND}}${PBCC[1]}else${PBOC[1]}{
${IND}${IND}\$self->{$pkg_us}{$an}${AO}=${AO}0;
${IND}}
}

EOF
}

sub write_doc_set_method {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';
    my $def = defined( $self->get_default_value() ) ? ' Default value at initialization is C<' . $self->esc_aq( $self->get_default_value() ) . '>.' : '';
    my $exc = ' On error an exception C<' . $self->get_exception_class() . '> is thrown.';
    my $attr_overl = $self->get_overloaded_attribute();
    my $overl = defined($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->get_perl_bean()->get_package() .'>.': '';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(VALUE)

State that ${desc}. C<VALUE> is the value.${def}${empt}${exc}${overl}

EOF
}

sub write_is_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $op = &{$MOF}('is');
    my $mb = $self->get_method_base();
    my $pkg_us = $self->get_package_us();

    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

${IND}if${BCP}(${ACS}\$self->{$pkg_us}{$an}${ACS})${PBOC[1]}{
${IND}${IND}return${BFP}(1);
${IND}}${PBCC[1]}else${PBOC[1]}{
${IND}${IND}return${BFP}(0);
${IND}}
}

EOF
}

sub write_doc_is_method {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('is');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}()

Returns whether ${desc} or not.

EOF
}

