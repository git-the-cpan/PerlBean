package PerlBean::Attribute::Multi;

use 5.005;
use base qw( PerlBean::Attribute::Single );
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);
use PerlBean::Style qw(:codegen);

# Package version
our ($VERSION) = '$Revision: 0.8 $' =~ /\$Revision:\s+([^\s]+)/;

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

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Multi> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Attribute>> may include:

=over

=item B<C<attribute_name>>

Passed to L<set_attribute_name()>. Mandatory option.

=item B<C<default_value>>

Passed to L<set_default_value()>.

=item B<C<documented>>

Passed to L<set_documented()>. Defaults to B<1>.

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

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Attribute::Single>> may include:

=over

=item B<C<allow_empty>>

Passed to L<set_allow_empty()>. Defaults to B<1>.

=item B<C<allow_isa>>

Passed to L<set_allow_isa()>. Must be an C<ARRAY> reference.

=item B<C<allow_ref>>

Passed to L<set_allow_ref()>. Must be an C<ARRAY> reference.

=item B<C<allow_rx>>

Passed to L<set_allow_rx()>. Must be an C<ARRAY> reference.

=item B<C<allow_value>>

Passed to L<set_allow_value()>. Must be an C<ARRAY> reference.

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

=item write_allow_isa()

This method is inherited from package C<'PerlBean::Attribute::Single'>. Returns a C<%ALLOW_ISA> line string for the attribute.

=item write_allow_ref()

This method is inherited from package C<'PerlBean::Attribute::Single'>. Returns a C<%ALLOW_REF> line string for the attribute.

=item write_allow_rx()

This method is inherited from package C<'PerlBean::Attribute::Single'>. Returns a C<%ALLOW_RX> line string for the attribute.

=item write_allow_value()

This method is inherited from package C<'PerlBean::Attribute::Single'>. Returns a C<%ALLOW_VALUE> line string for the attribute.

=item write_default_value()

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Returns a C<%DEFAULT_VALUE> line string for the attribute.

=item write_doc_clauses(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_inherit_methods(FILEHANDLE)

This is an interface method. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_init(FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_methods(FILEHANDLE)

This is an interface method. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_methods(FILEHANDLE)

This is an interface method. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_opt_init(FILEHANDLE)

This method is overloaded from package C<'PerlBean::Attribute::Single'>. Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=back

=head1 INHERITED METHODS FROM PerlBean::Attribute

=over

=item To access attribute named B<C<attribute_name>>:

set_attribute_name(), get_attribute_name()

=item To access attribute named B<C<default_value>>:

set_default_value(), get_default_value()

=item To access attribute named B<C<documented>>:

set_documented(), is_documented()

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

=head1 INHERITED METHODS FROM PerlBean::Attribute::Single

=over

=item To access attribute named B<C<allow_empty>>:

set_allow_empty(), is_allow_empty()

=item To access attribute named B<C<allow_isa>>:

set_allow_isa(), add_allow_isa(), delete_allow_isa(), exists_allow_isa(), values_allow_isa()

=item To access attribute named B<C<allow_ref>>:

set_allow_ref(), add_allow_ref(), delete_allow_ref(), exists_allow_ref(), values_allow_ref()

=item To access attribute named B<C<allow_rx>>:

set_allow_rx(), add_allow_rx(), delete_allow_rx(), exists_allow_rx(), values_allow_rx()

=item To access attribute named B<C<allow_value>>:

set_allow_value(), add_allow_value(), delete_allow_value(), exists_allow_value(), values_allow_value()

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
L<PerlBean::Dependency>,
L<PerlBean::Dependency::Import>,
L<PerlBean::Dependency::Require>,
L<PerlBean::Dependency::Use>,
L<PerlBean::Described>,
L<PerlBean::Described::ExportTag>,
L<PerlBean::Method>,
L<PerlBean::Method::Constructor>,
L<PerlBean::Style>,
L<PerlBean::Symbol>

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

    defined( $self->get_default_value() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my $dv = $self->esc_aq( @{ $self->get_default_value() } );

    return( "${IND}$an${AO}=>${AO}[$dv],\n" );
}

sub write_doc_inherit_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::Multi::write_doc_inherit_methods, call this method in a subclass that has implemented it.");
}

sub write_doc_init {
    my $self = shift;
    my $fh = shift;

    $self->is_documented() || return;

    my $an = $self->get_attribute_name();
    my $mb = $self->get_method_base();
    my $mand = $self->is_mandatory() ? ' Mandatory option.' : '';
    my $multi = ( $self->isa('PerlBean::Attribute::Multi') ) ? ' Must be an C<ARRAY> reference.' : '';
    my $def = '';
    if ( defined( $self->get_default_value() ) ) {
        my $list = join( '> , B<', $self->esc_aq( @{ $self->get_default_value() } ) );
        $def = ' Defaults to B<[> B<' . $list . '> B<]>.';
    }

    $fh->print(<<EOF);
\=item B<C<$an>>

Passed to L<set$mb${BFP}()>.${multi}${mand}${def}

EOF
}

sub write_doc_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::Multi::write_doc_methods, call this method in a subclass that has implemented it.");
}

sub write_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::Multi::write_methods, call this method in a subclass that has implemented it.");
}

sub write_opt_init {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_perl_bean()->get_package();

    # Comment
    $fh->print( "${IND}# $an, ", $self->type() );
    $self->is_mandatory() && $fh->print(', mandatory');
    defined( $self->get_default_value() ) && $fh->print(', with default value');
    $fh->print("\n");

    # is_mandatory check
    if ( $self->is_mandatory() ) {
        $fh->print(<<EOF);
${IND}exists${BFP}(${ACS}\$opt->{$an}${ACS})${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::_initialize, option '$an' is mandatory.");
EOF
    }

    my $pre = '';
    if ( ! $self->is_mandatory() ) {
        $pre .= "${IND}";
        $fh->print(<<EOF);
${IND}if${BCP}(${ACS}exists${BFP}(${ACS}\$opt->{$an}${ACS})${ACS})${PBOC[1]}{
EOF
    }
    $fh->print(<<EOF);
${IND}${pre}ref${BFP}(${ACS}\$opt->{$an}${ACS})${AO}eq${AO}'ARRAY'${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::_initialize, specified value for option '$an' must be an 'ARRAY' reference.");
${IND}${pre}\$self->set$mb${BFP}(${ACS}\@{${ACS}\$opt->{$an}${ACS}}${ACS});
EOF
    # default value
    if ( ! $self->is_mandatory() ) {
        if ( defined( $self->get_default_value() ) ) {
            $fh->print(<<EOF);
${IND}}${PBCC[1]}else${PBOC[1]}{
${IND}${IND}\$self->set$mb${BFP}(${ACS}\@{${ACS}\$DEFAULT_VALUE{$an}${ACS}}${ACS});
EOF
        }
        else {
            $fh->print(<<EOF);
${IND}}${PBCC[1]}else${PBOC[1]}{
${IND}${IND}\$self->set$mb${BFP}();
EOF
            }
        }
    if ( ! $self->is_mandatory()) {
        $fh->print(<<EOF);
${IND}}
EOF
    }

    # Empty line
    $fh->print("\n");
}


sub write_doc_clauses_allow_isa {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_isa() ) );

    $fh->print(<<EOF);
\=item The values in C<ARRAY> must be a (sub)class of:

\=over

EOF

    foreach my $class ( sort( $self->values_allow_isa() ) ) {
        $fh->print(<<EOF);
\=item ${class}

EOF
    }

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_clauses_allow_ref {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_ref() ) );
    my $or = scalar( $self->values_allow_isa() ) ? 'Or, the' : 'The';

    $fh->print(<<EOF);
\=item ${or} values in C<ARRAY> must be a reference of:

\=over

EOF

    foreach my $class ( sort( $self->values_allow_ref() ) ) {
        $fh->print(<<EOF);
\=item ${class}

EOF
    }

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_clauses_allow_rx {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_rx() ) );
    my $or = scalar( $self->values_allow_isa() || $self->values_allow_ref() ) ? 'Or, the' : 'The';

    $fh->print(<<EOF);
\=item ${or} values in C<ARRAY> must match regular expression:

\=over

EOF

    foreach my $class ( sort( $self->values_allow_rx() ) ) {
        $fh->print(<<EOF);
\=item ${class}

EOF
    }

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_clauses_allow_value {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_value() ) );
    my $or = scalar( $self->values_allow_isa() || $self->values_allow_ref() || $self->values_allow_rx() ) ? 'Or, the' : 'The';

    $fh->print(<<EOF);
\=item ${or} values in C<ARRAY> must be a one of:

\=over

EOF

    foreach my $val ( sort( $self->values_allow_value() ) ) {
        $fh->print(<<EOF);
\=item ${val}

EOF
    }

    $fh->print(<<EOF);
\=back

EOF
}

