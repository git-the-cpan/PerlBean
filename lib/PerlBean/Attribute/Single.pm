package PerlBean::Attribute::Single;

use 5.005;
use base qw( PerlBean::Attribute );
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);
use PerlBean::Style qw(:codegen);

# Variable to not confuse AutoLoader
our $SUB = 'sub';

# Used by _value_is_allowed
our %ALLOW_ISA = (
);

# Used by _value_is_allowed
our %ALLOW_REF = (
);

# Used by _value_is_allowed
our %ALLOW_RX = (
);

# Used by _value_is_allowed
our %ALLOW_VALUE = (
);

# Used by _value_is_allowed
our %DEFAULT_VALUE = (
    'allow_empty' => 1,
);

# Package version
our ($VERSION) = '$Revision: 0.7 $' =~ /\$Revision:\s+([^\s]+)/;

1;

__END__

=head1 NAME

PerlBean::Attribute::Single - contains SINGLE bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Single;
 my $attr = PerlBean::Attribute::Single->new( {
     attribute_name => 'name',
     short_description => 'my name',
 } );
 
 use IO::File;
 -d 'tmp' || mkdir('tmp');
 my $fh = IO::File->new('> tmp/PerlBean_Attribute_Single.pl.out');
 $attr->write_methods($fh);
 $attr->write_doc_methods($fh);

=head1 ABSTRACT

SINGLE bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Single> contains SINGLE bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code and documentation methods are implemented.

=head1 CONSTRUCTOR

=over

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Single> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

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

Returns a C<%ALLOW_ISA> line string for the attribute.

=item write_allow_ref()

Returns a C<%ALLOW_REF> line string for the attribute.

=item write_allow_rx()

Returns a C<%ALLOW_RX> line string for the attribute.

=item write_allow_value()

Returns a C<%ALLOW_VALUE> line string for the attribute.

=item write_default_value()

This method is an implementation from package C<'PerlBean::Attribute'>. Returns a C<%DEFAULT_VALUE> line string for the attribute.

=item write_doc_clauses(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_inherit_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_init(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_opt_init(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute'>. Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item set_allow_empty(VALUE)

State that the attribute is allowed to be empty. C<VALUE> is the value. Default value at initialization is C<1>. On error an exception C<Error::Simple> is thrown.

=item is_allow_empty()

Returns whether the attribute is allowed to be empty or not.

=item set_allow_isa(ARRAY)

Set the list of allowed classes absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item add_allow_isa(ARRAY)

Add additional values on the list of allowed classes. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item delete_allow_isa(ARRAY)

Delete elements from the list of allowed classes. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_allow_isa(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed classes.

=item values_allow_isa()

Returns an C<ARRAY> containing all values of the list of allowed classes.

=item set_allow_ref(ARRAY)

Set the list of allowed references absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item add_allow_ref(ARRAY)

Add additional values on the list of allowed references. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item delete_allow_ref(ARRAY)

Delete elements from the list of allowed references. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_allow_ref(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allowed references.

=item values_allow_ref()

Returns an C<ARRAY> containing all values of the list of allowed references.

=item set_allow_rx(ARRAY)

Set the list of allow regular expressions absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item add_allow_rx(ARRAY)

Add additional values on the list of allow regular expressions. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item delete_allow_rx(ARRAY)

Delete elements from the list of allow regular expressions. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_allow_rx(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of allow regular expressions.

=item values_allow_rx()

Returns an C<ARRAY> containing all values of the list of allow regular expressions.

=item set_allow_value(ARRAY)

Set allowed values absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=item add_allow_value(ARRAY)

Add additional values on allowed values. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted. On error an exception C<Error::Simple> is thrown.

=item delete_allow_value(ARRAY)

Delete elements from allowed values. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_allow_value(ARRAY)

Returns the count of items in C<ARRAY> that are in allowed values.

=item values_allow_value()

Returns an C<ARRAY> containing all values of allowed values.

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
L<PerlBean::Attribute::Boolean>,
L<PerlBean::Attribute::Factory>,
L<PerlBean::Attribute::Multi>,
L<PerlBean::Attribute::Multi::Ordered>,
L<PerlBean::Attribute::Multi::Unique>,
L<PerlBean::Attribute::Multi::Unique::Associative>,
L<PerlBean::Attribute::Multi::Unique::Associative::MethodKey>,
L<PerlBean::Attribute::Multi::Unique::Ordered>,
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

sub _initialize {
    my $self = shift;
    my $opt = defined($_[0]) ? shift : {};

    # Check $opt
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::Attribute::Single::_initialize, first argument must be 'HASH' reference.");

    # allow_empty, BOOLEAN, with default value
    $self->set_allow_empty( exists( $opt->{allow_empty} ) ? $opt->{allow_empty} : $DEFAULT_VALUE{allow_empty} );

    # allow_isa, MULTI
    if ( exists( $opt->{allow_isa} ) ) {
        ref( $opt->{allow_isa} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_isa' must be an 'ARRAY' reference.");
        $self->set_allow_isa( @{ $opt->{allow_isa} } );
    }
    else {
        $self->set_allow_isa();
    }

    # allow_ref, MULTI
    if ( exists( $opt->{allow_ref} ) ) {
        ref( $opt->{allow_ref} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_ref' must be an 'ARRAY' reference.");
        $self->set_allow_ref( @{ $opt->{allow_ref} } );
    }
    else {
        $self->set_allow_ref();
    }

    # allow_rx, MULTI
    if ( exists( $opt->{allow_rx} ) ) {
        ref( $opt->{allow_rx} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_rx' must be an 'ARRAY' reference.");
        $self->set_allow_rx( @{ $opt->{allow_rx} } );
    }
    else {
        $self->set_allow_rx();
    }

    # allow_value, MULTI
    if ( exists( $opt->{allow_value} ) ) {
        ref( $opt->{allow_value} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::Attribute::Single::_initialize, specified value for option 'allow_value' must be an 'ARRAY' reference.");
        $self->set_allow_value( @{ $opt->{allow_value} } );
    }
    else {
        $self->set_allow_value();
    }

    # Call the superclass' _initialize
    $self->SUPER::_initialize($opt);

    # Return $self
    return($self);
}

sub write_allow_isa {
    my $self = shift;

    scalar( $self->values_allow_isa() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my $dv = $self->esc_aq( sort( $self->values_allow_isa() ) );
    return( "${IND}$an${AO}=>${AO}[${ACS}$dv${ACS}],\n" );
}

sub write_allow_ref {
    my $self = shift;

    scalar( $self->values_allow_ref() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my @dv = sort( $self->esc_aq( $self->values_allow_ref() ) );

    my $ass = "${IND}$an${AO}=>${AO}{\n";
    foreach my $dv (@dv) {
        $ass .= "${IND}${IND}$dv${AO}=>${AO}1,\n";
    }
    $ass .= "${IND}},\n";

    return($ass);
}

sub write_allow_rx {
    my $self = shift;

    scalar( $self->values_allow_rx() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my $dv = $self->esc_aq( sort( $self->values_allow_rx() ) );
    return( "${IND}$an${AO}=>${AO}[${ACS}$dv${ACS}],\n" );
}

sub write_allow_value {
    my $self = shift;
    my $fh = shift;

    scalar( $self->values_allow_value() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my @dv = sort( $self->esc_aq( $self->values_allow_value() ) );

    my $ass = "${IND}$an${AO}=>${AO}{\n";
    foreach my $dv (@dv) {
        $ass .= "${IND}${IND}$dv${AO}=>${AO}1,\n";
    }
    $ass .= "${IND}},\n";
}

sub write_default_value {
    my $self = shift;
    my $fh = shift;

    defined( $self->get_default_value() ) || return('');

    my $an = $self->esc_aq( $self->get_attribute_name() );
    my $dv = $self->esc_aq( $self->get_default_value() );

    return( "${IND}$an${AO}=>${AO}$dv,\n" );
}

sub write_doc_inherit_methods {
    my $self = shift;
    my $fh = shift;

    my $mb = $self->get_method_base();

    my @meth = ();
    foreach my $lop ( qw(set get) ) {
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

    $self->is_documented() || return;

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

    $self->is_documented() || return;

    $self->write_set_doc($fh);
    $self->write_get_doc($fh);
}

sub write_methods {
    my $self = shift;
    my $fh = shift;

    $self->write_set_method($fh);
    $self->write_get_method($fh);

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
    $self->is_mandatory() && $fh->print(', mandatory');
    defined( $self->get_default_value() ) && $fh->print(', with default value');
    $fh->print("\n");

    # is_mandatory check
    if ( $self->is_mandatory() ) {
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
        if ( defined( $self->get_default_value() ) ) {
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

sub set_allow_empty {
    my $self = shift;

    if (shift) {
        $self->{PerlBean_Attribute_Single}{allow_empty} = 1;
    }
    else {
        $self->{PerlBean_Attribute_Single}{allow_empty} = 0;
    }
}

sub is_allow_empty {
    my $self = shift;

    if ( $self->{PerlBean_Attribute_Single}{allow_empty} ) {
        return(1);
    }
    else {
        return(0);
    }
}

sub set_allow_isa {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_isa', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::set_allow_isa, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean_Attribute_Single}{allow_isa} = {};

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_isa}{$val} = $val;
    }
}

sub add_allow_isa {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_isa', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::add_allow_isa, one or more specified value(s) '@_' is/are not allowed.");

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_isa}{$val} = $val;
    }
}

sub delete_allow_isa {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean_Attribute_Single}{allow_isa}{$val} ) || next;
        delete( $self->{PerlBean_Attribute_Single}{allow_isa}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_allow_isa {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean_Attribute_Single}{allow_isa}{$val} );
    }
    return($count);
}

sub values_allow_isa {
    my $self = shift;

    # Return all values
    return( values( %{ $self->{PerlBean_Attribute_Single}{allow_isa} } ) );
}

sub set_allow_ref {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_ref', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::set_allow_ref, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean_Attribute_Single}{allow_ref} = {};

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_ref}{$val} = $val;
    }
}

sub add_allow_ref {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_ref', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::add_allow_ref, one or more specified value(s) '@_' is/are not allowed.");

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_ref}{$val} = $val;
    }
}

sub delete_allow_ref {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean_Attribute_Single}{allow_ref}{$val} ) || next;
        delete( $self->{PerlBean_Attribute_Single}{allow_ref}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_allow_ref {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean_Attribute_Single}{allow_ref}{$val} );
    }
    return($count);
}

sub values_allow_ref {
    my $self = shift;

    # Return all values
    return( values( %{ $self->{PerlBean_Attribute_Single}{allow_ref} } ) );
}

sub set_allow_rx {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_rx', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::set_allow_rx, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean_Attribute_Single}{allow_rx} = {};

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_rx}{$val} = $val;
    }
}

sub add_allow_rx {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_rx', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::add_allow_rx, one or more specified value(s) '@_' is/are not allowed.");

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_rx}{$val} = $val;
    }
}

sub delete_allow_rx {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean_Attribute_Single}{allow_rx}{$val} ) || next;
        delete( $self->{PerlBean_Attribute_Single}{allow_rx}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_allow_rx {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean_Attribute_Single}{allow_rx}{$val} );
    }
    return($count);
}

sub values_allow_rx {
    my $self = shift;

    # Return all values
    return( values( %{ $self->{PerlBean_Attribute_Single}{allow_rx} } ) );
}

sub set_allow_value {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_value', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::set_allow_value, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean_Attribute_Single}{allow_value} = {};

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_value}{$val} = $val;
    }
}

sub add_allow_value {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'allow_value', @_ ) || throw Error::Simple("ERROR: PerlBean::Attribute::Single::add_allow_value, one or more specified value(s) '@_' is/are not allowed.");

    # Add values
    foreach my $val (@_) {
        $self->{PerlBean_Attribute_Single}{allow_value}{$val} = $val;
    }
}

sub delete_allow_value {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean_Attribute_Single}{allow_value}{$val} ) || next;
        delete( $self->{PerlBean_Attribute_Single}{allow_value}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_allow_value {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean_Attribute_Single}{allow_value}{$val} );
    }
    return($count);
}

sub values_allow_value {
    my $self = shift;

    # Return all values
    return( values( %{ $self->{PerlBean_Attribute_Single}{allow_value} } ) );
}

sub _value_is_allowed {
    my $name = shift;

    # Value is allowed if no ALLOW clauses exist for the named attribute
    if ( ! exists( $ALLOW_ISA{$name} ) && ! exists( $ALLOW_REF{$name} ) && ! exists( $ALLOW_RX{$name} ) && ! exists( $ALLOW_VALUE{$name} ) ) {
        return(1);
    }

    # At this point, all values in @_ must to be allowed
    CHECK_VALUES:
    foreach my $val (@_) {
        # Check ALLOW_ISA
        if ( ref($val) && exists( $ALLOW_ISA{$name} ) ) {
            foreach my $class ( @{ $ALLOW_ISA{$name} } ) {
                &UNIVERSAL::isa( $val, $class ) && next CHECK_VALUES;
            }
        }

        # Check ALLOW_REF
        if ( ref($val) && exists( $ALLOW_REF{$name} ) ) {
            exists( $ALLOW_REF{$name}{ ref($val) } ) && next CHECK_VALUES;
        }

        # Check ALLOW_RX
        if ( defined($val) && ! ref($val) && exists( $ALLOW_RX{$name} ) ) {
            foreach my $rx ( @{ $ALLOW_RX{$name} } ) {
                $val =~ /$rx/ && next CHECK_VALUES;
            }
        }

        # Check ALLOW_VALUE
        if ( ! ref($val) && exists( $ALLOW_VALUE{$name} ) ) {
            exists( $ALLOW_VALUE{$name}{$val} ) && next CHECK_VALUES;
        }

        # We caught a not allowed value
        return(0);
    }

    # OK, all values are allowed
    return(1);
}

sub write_set_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $an_esc = $self->esc_aq($an);
    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_package();
    my $pkg_us = $self->get_package_us();


    # Method head
    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;
${IND}my \$val${AO}=${AO}shift;

EOF

    # Check if value is allowed to be empty
    if ( ! $self->is_allow_empty() ) {
        $fh->print(<<EOF);
${IND}# Value for $an_esc is not allowed to be empty
${IND}defined${BFP}(\$val)${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::set$mb, value may not be empty.");

EOF
    }

    # Check if isa/ref/rx/value is allowed
    $fh->print(<<EOF);
${IND}# Check if isa/ref/rx/value is allowed
${IND}\&_value_is_allowed${BFP}(${ACS}$an_esc,${AC}\$val${ACS})${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::set$mb, the specified value '\$val' is not allowed.");

EOF

    # Assignment and method tail
    $fh->print(<<EOF);
${IND}# Assignment
${IND}\$self->{$pkg_us}{$an}${AO}=${AO}\$val;
}

EOF
}

sub write_set_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';
    my $def = defined( $self->get_default_value() ) ? ' Default value at initialization is C<' . $self->esc_aq( $self->get_default_value() ) . '>.' : '';
    my $empt = $self->is_allow_empty() ? '' : ' C<VALUE> may not be C<undef>.';
    my $exc = ' On error an exception C<' . $self->get_exception_class() . '> is thrown.';
    my $attr_overl = $self->get_overloaded_attribute();
    my $overl = defined($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->get_package() .'>.': '';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(VALUE)

Set ${desc}. C<VALUE> is the value.${def}${empt}${exc}${overl}

EOF

    $self->write_doc_clauses($fh);
}

sub write_get_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $op = &{$MOF}('get');
    my $mb = $self->get_method_base();
    my $pkg_us = $self->get_package_us();

    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

${IND}return${BFP}(${ACS}\$self->{$pkg_us}{$an}${ACS});
}

EOF
}

sub write_get_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('get');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}()

Returns ${desc}.

EOF
}

sub write_doc_clauses_allow_isa {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_isa() ) );

    $fh->print(<<EOF);
\=item VALUE must be a (sub)class of:

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
    my $or = scalar( $self->values_allow_isa() ) ? 'Or, ' : '';

    $fh->print(<<EOF);
\=item ${or}VALUE must be a reference of:

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
    my $or = scalar( $self->values_allow_isa() || $self->values_allow_ref() ) ? 'Or, ' : '';

    $fh->print(<<EOF);
\=item ${or}VALUE must match regular expression:

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
    my $or = scalar( $self->values_allow_isa() || $self->values_allow_ref() || $self->values_allow_rx() ) ? 'Or, ' : '';

    $fh->print(<<EOF);
\=item ${or}VALUE must be a one of:

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

