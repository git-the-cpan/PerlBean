package PerlBean::Attribute;

use 5.005;
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);
use PerlBean::Style qw(:codegen);

# Used by _value_is_allowed
our %ALLOW_ISA = (
    'perl_bean' => [ 'PerlBean' ],
);

# Used by _value_is_allowed
our %ALLOW_REF = (
);

# Used by _value_is_allowed
our %ALLOW_RX = (
    'attribute_name' => [ '^\w+$' ],
);

# Used by _value_is_allowed
our %ALLOW_VALUE = (
);

# Used by _value_is_allowed
our %DEFAULT_VALUE = (
    'documented' => 1,
    'exception_class' => 'Error::Simple',
    'mandatory' => 0,
);

# Package version
our ($VERSION) = '$Revision: 0.7 $' =~ /\$Revision:\s+([^\s]+)/;

1;

__END__

=head1 NAME

PerlBean::Attribute - contains bean attribute information

=head1 SYNOPSIS

None. This is an abstract class.

=head1 ABSTRACT

Abstract PerlBean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute> abstract class for bean attribute information. Attribute access methods are implemented and code and documentation generation interface methods are defined.

=head1 CONSTRUCTOR

=over

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Attribute> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

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

Searches superclass packages for an identically named C<PerlBean::Attribute>. If found it is returned otherwise C<undef> is returned.

=item get_package()

Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.

=item get_package_us()

Calls C<get_package()> and replaces C<:+> with C <_>.

=item type()

Determins and returns the type of the attribute. The type is either C<BOOLEAN>, C<SINGLE> or C<MULTI>.

=item write_default_value()

This is an interface method. Returns a C<\%DEFAULT_VALUE> line string for the attribute.

=item write_doc_clauses(FILEHANDLE)

Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_inherit_methods(FILEHANDLE)

This is an interface method. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_init(FILEHANDLE)

This is an interface method. Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_methods(FILEHANDLE)

This is an interface method. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_methods(FILEHANDLE)

This is an interface method. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_opt_init(FILEHANDLE)

This is an interface method. Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item set_attribute_name(VALUE)

Set attribute's name. C<VALUE> is the value. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^\w+$

=back

=back

=item get_attribute_name()

Returns attribute's name.

=item set_default_value(VALUE)

Set attribute's default value. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item get_default_value()

Returns attribute's default value.

=item set_documented(VALUE)

State that the attribute is documented. C<VALUE> is the value. Default value at initialization is C<1>. On error an exception C<Error::Simple> is thrown.

=item is_documented()

Returns whether the attribute is documented or not.

=item set_exception_class(VALUE)

Set the class to throw when an exception occurs. C<VALUE> is the value. Default value at initialization is C<'Error::Simple'>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item get_exception_class()

Returns the class to throw when an exception occurs.

=item set_mandatory(VALUE)

State that the attribute is mandatory for construction. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item is_mandatory()

Returns whether the attribute is mandatory for construction or not.

=item set_method_base(VALUE)

Set the method base name. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item get_method_base()

Returns the method base name.

=item set_perl_bean(VALUE)

Set the PerlBean to which this attribute belongs. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a (sub)class of:

=over

=item PerlBean

=back

=back

=item get_perl_bean()

Returns the PerlBean to which this attribute belongs.

=item set_short_description(VALUE)

Set the attribute description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item get_short_description()

Returns the attribute description.

=back

=head1 SEE ALSO

L<PerlBean>,
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

sub new {
    my $class = shift;

    my $self = {};
    bless( $self, ( ref($class) || $class ) );
    return( $self->_initialize(@_) );
}

sub _initialize {
    my $self = shift;
    my $opt = defined($_[0]) ? shift : {};

    # Check $opt
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::Attribute::_initialize, first argument must be 'HASH' reference.");

    # attribute_name, SINGLE, mandatory
    exists( $opt->{attribute_name} ) || throw Error::Simple("ERROR: PerlBean::Attribute::_initialize, option 'attribute_name' is mandatory.");
    $self->set_attribute_name( $opt->{attribute_name} );

    # default_value, SINGLE
    exists( $opt->{default_value} ) && $self->set_default_value( $opt->{default_value} );

    # documented, BOOLEAN, with default value
    $self->set_documented( exists( $opt->{documented} ) ? $opt->{documented} : $DEFAULT_VALUE{documented} );

    # exception_class, SINGLE, with default value
    $self->set_exception_class( exists( $opt->{exception_class} ) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class} );

    # mandatory, BOOLEAN, with default value
    $self->set_mandatory( exists( $opt->{mandatory} ) ? $opt->{mandatory} : $DEFAULT_VALUE{mandatory} );

    # method_base, SINGLE
    exists( $opt->{method_base} ) && $self->set_method_base( $opt->{method_base} );

    # perl_bean, SINGLE
    exists( $opt->{perl_bean} ) && $self->set_perl_bean( $opt->{perl_bean} );

    # short_description, SINGLE
    exists( $opt->{short_description} ) && $self->set_short_description( $opt->{short_description} );

    # Return $self
    return($self);
}

sub get_overloaded_attribute {
    my $self = shift;

    # No attribute found if no collection defined
    defined( $self->get_perl_bean() ) || return(undef);
    defined( $self->get_perl_bean()->get_collection() ) || return(undef);

    # Look for the attribute in super classes
    foreach my $super_pkg ( $self->get_perl_bean()->get_base() ) {
        # Get the super class bean
        my $super_bean = ( $self->get_perl_bean()->get_collection()->values_perl_bean($super_pkg) )[0];

        # If the super class bean has no bean in the collection then no attribute is found
        defined($super_bean) || return(undef);

        # See if the super class bean has an attribute
        my $attr_over = $super_bean->get_overloaded_attribute( $self, {
            $self->get_perl_bean()->get_package() => 1,
        } );

        # Return the overloaded bean if found
        defined($attr_over) && return($attr_over);
    }

    # Nothing found
    return(undef);
}

sub get_package {
    my $self = shift;

    defined( $self->get_perl_bean() ) && return( $self->get_perl_bean()->get_package() );
    return('main');
}

sub get_package_us {
    my $self = shift;

    my $pkg = $self->get_package();
    $pkg =~ s/:+/_/g;
    return($pkg);
}

sub type {
    my $self = shift;

    $self->isa('PerlBean::Attribute::Boolean') && return('BOOLEAN');
    $self->isa('PerlBean::Attribute::Multi') && return('MULTI');
    $self->isa('PerlBean::Attribute::Single') && return('SINGLE');
}

sub write_default_value {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_default_value, call this method in a subclass that has implemented it.");
}

sub write_doc_clauses {
    my $self = shift;
    my $fh = shift;

    return if ( ! scalar( $self->values_allow_isa() ) && ! scalar( $self->values_allow_ref() ) && ! scalar( $self->values_allow_rx() ) && ! scalar( $self->values_allow_value() ) );

    $fh->print(<<EOF);
\=over

EOF

    $self->write_doc_clauses_allow_isa($fh, @_);
    $self->write_doc_clauses_allow_ref($fh, @_);
    $self->write_doc_clauses_allow_rx($fh, @_);
    $self->write_doc_clauses_allow_value($fh, @_);

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_inherit_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_doc_inherit_methods, call this method in a subclass that has implemented it.");
}

sub write_doc_init {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_doc_init, call this method in a subclass that has implemented it.");
}

sub write_doc_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_doc_methods, call this method in a subclass that has implemented it.");
}

sub write_methods {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_methods, call this method in a subclass that has implemented it.");
}

sub write_opt_init {
    throw Error::Simple("ERROR: PerlBean::Attribute::write_opt_init, call this method in a subclass that has implemented it.");
}

sub set_attribute_name {
    my $self = shift;
    my $val = shift;

    # Value for 'attribute_name' is not allowed to be empty
    defined($val) || throw Error::Simple("ERROR: PerlBean::Attribute::set_attribute_name, value may not be empty.");

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'attribute_name', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_attribute_name, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{attribute_name} = $val;
}

sub get_attribute_name {
    my $self = shift;

    return( $self->{PerlBean_Attribute}{attribute_name} );
}

sub set_default_value {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'default_value', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_default_value, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{default_value} = $val;
}

sub get_default_value {
    my $self = shift;

    return( $self->{PerlBean_Attribute}{default_value} );
}

sub set_documented {
    my $self = shift;

    if (shift) {
        $self->{PerlBean_Attribute}{documented} = 1;
    }
    else {
        $self->{PerlBean_Attribute}{documented} = 0;
    }
}

sub is_documented {
    my $self = shift;

    if ( $self->{PerlBean_Attribute}{documented} ) {
        return(1);
    }
    else {
        return(0);
    }
}

sub set_exception_class {
    my $self = shift;
    my $val = shift;

    # Value for 'exception_class' is not allowed to be empty
    defined($val) || throw Error::Simple("ERROR: PerlBean::Attribute::set_exception_class, value may not be empty.");

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'exception_class', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_exception_class, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{exception_class} = $val;
}

sub get_exception_class {
    my $self = shift;

    return( $self->{PerlBean_Attribute}{exception_class} );
}

sub set_mandatory {
    my $self = shift;

    if (shift) {
        $self->{PerlBean_Attribute}{mandatory} = 1;
    }
    else {
        $self->{PerlBean_Attribute}{mandatory} = 0;
    }
}

sub is_mandatory {
    my $self = shift;

    if ( $self->{PerlBean_Attribute}{mandatory} ) {
        return(1);
    }
    else {
        return(0);
    }
}

sub set_method_base {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'method_base', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_method_base, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{method_base} = $val;
}

sub get_method_base {
    my $self = shift;

    defined( $self->{PerlBean_Attribute}{method_base} ) && return( $self->{PerlBean_Attribute}{method_base} );

    my $style = PerlBean::Style->instance();
    return( &{$AN2MBF}( $self->get_attribute_name() ) );
}

sub set_perl_bean {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'perl_bean', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_perl_bean, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{perl_bean} = $val;
}

sub get_perl_bean {
    my $self = shift;

    return( $self->{PerlBean_Attribute}{perl_bean} );
}

sub set_short_description {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'short_description', $val ) || throw Error::Simple("ERROR: PerlBean::Attribute::set_short_description, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Attribute}{short_description} = $val;
}

sub get_short_description {
    my $self = shift;

    return( $self->{PerlBean_Attribute}{short_description} );
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

sub esc_apos {
    my $self = shift;

    my @in = @_;
    my @el = ();
    foreach my $el (@in) {
        if ( $el =~ /^[+-]?\d+$/ ) {
            $el = ( int($el) );
        }
        else {
            $el =~ s/'/\\'/g;
            $el = '\'' . $el . '\'';
        }
        push( @el, $el );
    }
    if (wantarray) {
        return(@el);
    }
    else {
        return( join( ', ', @el ) );
    }
}

sub esc_aq {
    my $self = shift;

    my $do_quote = 0;
    foreach my $el (@_) {
        if ($el =~ /[\n\r\t\f\a\e]/) {
            $do_quote = 1;
            last;
        }
    }

    if (wantarray) {
        return ( $do_quote ? ( $self->esc_quote(@_) ) : ( $self->esc_apos(@_) ) );
    }
    else {
        return ( $do_quote ? scalar( $self->esc_quote(@_) ) : scalar($self->esc_apos(@_) ) );
    }
}

sub esc_quote {
    my $self = shift;

    my @in = @_;
    my @el = ();
    foreach my $el (@in) {
        if ( $el =~ /^[+-]?\d+$/ ) {
            $el = ( int($el) );
        }
        else {
            $el =~ s/\\/\\\\/g;
            $el =~ s/\n/\\n/g;
            $el =~ s/\r/\\r/g;
            $el =~ s/\t/\\t/g;
            $el =~ s/\f/\\f/g;
            $el =~ s/\a/\\a/g;
            $el =~ s/\e/\\e/g;
            $el =~ s/([\$\@\%"])/\\$1/g;
            $el = '"' . $el . '"';
        }
        push( @el, $el );
    }
    if (wantarray) {
        return(@el);
    }
    else {
        return( join( ', ', @el ) );
    }
}

