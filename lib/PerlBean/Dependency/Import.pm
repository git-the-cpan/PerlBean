package PerlBean::Dependency::Import;

use 5.005;
use base qw( PerlBean::Dependency );
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);

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
);

# Package version
our ($VERSION) = '$Revision: 0.8 $' =~ /\$Revision:\s+([^\s]+)/;

1;

__END__

=head1 NAME

PerlBean::Dependency::Import - Import dependency in a Perl bean

=head1 SYNOPSIS

TODO.n
=head1 ABSTRACT

Import dependency in a Perl bean

=head1 DESCRIPTION

C<PerlBean::Dependency::Import> is a class to express C<import> dependencies to classes/modules/files in a C<PerlBean>.

=head1 CONSTRUCTOR

=over

=item new( [ OPT_HASH_REF ] )

Creates a new C<PerlBean::Dependency::Import> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<import_list>>

Passed to L<set_import_list()>. Must be an C<ARRAY> reference.

=back

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Dependency>> may include:

=over

=item B<C<dependency_name>>

Passed to L<set_dependency_name()>.

=back

=back

=head1 METHODS

=over

=item write(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Dependency'>. Writes code for the dependency. C<FILEHANDLE> is an C<IO::Handle> object.

=item set_import_list(ARRAY)

Set the list after the C<dependency_name> absolutely. C<ARRAY> is the list value. On error an exception C<Error::Simple> is thrown.

=item set_idx_import_list( INDEX, VALUE )

Set value in the list after the C<dependency_name>. C<INDEX> is the integer index which is greater than or equal to C<0>. C<VALUE> is the value.

=item set_num_import_list( NUMBER, VALUE )

Set value in the list after the C<dependency_name>. C<NUMBER> is the integer index which is greater than C<0>. C<VALUE> is the value.

=item push_import_list(ARRAY)

Push additional values on the list after the C<dependency_name>. C<ARRAY> is the list value. On error an exception C<Error::Simple> is thrown.

=item pop_import_list()

Pop and return an element off the list after the C<dependency_name>. On error an exception C<Error::Simple> is thrown.

=item shift_import_list()

Shift and return an element off the list after the C<dependency_name>. On error an exception C<Error::Simple> is thrown.

=item unshift_import_list(ARRAY)

Unshift additional values on the list after the C<dependency_name>. C<ARRAY> is the list value. On error an exception C<Error::Simple> is thrown.

=item exists_import_list(ARRAY)

Returns the count of items in C<ARRAY> that are in the list after the C<dependency_name>.

=item get_import_list( [ INDEX_ARRAY ] )

Returns an C<ARRAY> containing the list after the C<dependency_name>. C<INDEX_ARRAY> is an optional list of indexes which when specified causes only the indexed elements in the ordered list to be returned. If not specified, all elements are returned.

=back

=head1 INHERITED METHODS FROM PerlBean::Dependency

=over

=item To access attribute named B<C<dependency_name>>:

set_dependency_name(), get_dependency_name()

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
L<PerlBean::Collection>,
L<PerlBean::Dependency>,
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

First development: March 2003

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

sub _initialize {
    my $self = shift;
    my $opt = defined($_[0]) ? shift : {};

    # Check $opt
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::Dependency::Import::_initialize, first argument must be 'HASH' reference.");

    # import_list, MULTI
    if ( exists( $opt->{import_list} ) ) {
        ref( $opt->{import_list} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::Dependency::Import::_initialize, specified value for option 'import_list' must be an 'ARRAY' reference.");
        $self->set_import_list( @{ $opt->{import_list} } );
    }
    else {
        $self->set_import_list();
    }

    # Call the superclass' _initialize
    $self->SUPER::_initialize($opt);

    # Return $self
    return($self);
}

sub write {
    my $self = shift;
    my $fh = shift;

    my $dn = $self->get_dependency_name();
    my $tail ='';

    if ( $self->get_import_list() ) {
        $tail .= ' ';
        $tail .= join( ', ', $self->get_import_list() );
    }
    $fh->print( "import $dn$tail;\n" )
}

sub set_import_list {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'import_list', @_ ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::set_import_list, one or more specified value(s) '@_' is/are not allowed.");

    # Set the list
    @{ $self->{PerlBean_Dependency_Import}{import_list} } = @_;
}

sub set_idx_import_list {
    my $self = shift;
    my $idx = shift;
    my $val = shift;

    # Check if index is a positive integer or zero
    ( $idx == int($idx) ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::set_idx_import_list, the specified index '$idx' is not an integer.");
    ( $idx >= 0 ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::set_idx_import_list, the specified index '$idx' is not a positive integer or zero.");

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'import_list', $val ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::set_idx_import_list, one or more specified value(s) '@_' is/are not allowed.");

    # Set the value in the list
    $self->{PerlBean_Dependency_Import}{import_list}[$idx] = $val;
}

sub set_num_import_list {
    my $self = shift;
    my $num = shift;

    # Check if index is an integer
    ( $num == int($num) ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::set_num_import_list, the specified number '$num' is not an integer.");

    # Call set_idx_import_list
    $self->set_idx_import_list( $num - 1,  );
}

sub push_import_list {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'import_list', @_ ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::push_import_list, one or more specified value(s) '@_' is/are not allowed.");

    # Push the list
    push( @{ $self->{PerlBean_Dependency_Import}{import_list} }, @_ );
}

sub pop_import_list {
    my $self = shift;

    # Pop an element from the list
    return( pop( @{ $self->{PerlBean_Dependency_Import}{import_list} } ) );
}

sub shift_import_list {
    my $self = shift;

    # Shift an element from the list
    return( shift( @{ $self->{PerlBean_Dependency_Import}{import_list} } ) );
}

sub unshift_import_list {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'import_list', @_ ) || throw Error::Simple("ERROR: PerlBean::Dependency::Import::unshift_import_list, one or more specified value(s) '@_' is/are not allowed.");

    # Unshift the list
    unshift( @{ $self->{PerlBean_Dependency_Import}{import_list} }, @_ );
}

sub exists_import_list {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val1 (@_) {
        foreach my $val2 ( @{ $self->{PerlBean_Dependency_Import}{import_list} } ) {
            ( $val1 eq $val2 ) && $count ++;
        }
    }
    return($count);
}

sub get_import_list {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $i (@_) {
            push( @ret, $self->{PerlBean_Dependency_Import}{import_list}[ int($i) ] );
        }
        return(@ret);
    }
    else {
        # Return the full list
        return( @{ $self->{PerlBean_Dependency_Import}{import_list} } );
    }
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

