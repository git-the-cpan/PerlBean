package PerlBean::Style;

use 5.005;
use strict;
use warnings;
use Error qw(:try);
use AutoLoader qw(AUTOLOAD);

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = (
    'all' => [
        qw(),
    ],
    'codegen' => [
        qw($AN2MBF $MOF $IND $AC $ACS $AO $BCP $BFP @PBCC @PBOC),
    ],
);

our @EXPORT_OK = (
    @{ $EXPORT_TAGS{'all'} },
    @{ $EXPORT_TAGS{'codegen'} },
);

our @EXPORT = qw(
);

our ($VERSION) = '$Revision: 0.6 $' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
);
our %ALLOW_REF = (
    'attribute_name_to_method_base_filter' => {
        'CODE' => 1,
    },
    'method_operation_filter' => {
        'CODE' => 1,
    },
);
our %ALLOW_RX = (
    'indent' => [ '.*' ],
    'str_after_comma' => [ '.*' ],
    'str_around_complex_subscripts' => [ '.*' ],
    'str_around_operators' => [ '.*' ],
    'str_between_conditional_and_parenthesis' => [ '.*' ],
    'str_between_function_and_parenthesis' => [ '.*' ],
    'str_post_block_close_curl' => [ '.*' ],
    'str_pre_block_open_curl' => [ '.*' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
    'attribute_name_to_method_base_filter' => \&default_attribute_name_to_method_base_filter,
    'indent' => '    ',
    'method_operation_filter' => \&default_method_operation_filter,
    'str_after_comma' => ' ',
    'str_around_complex_subscripts' => ' ',
    'str_around_operators' => ' ',
    'str_between_conditional_and_parenthesis' => ' ',
    'str_between_function_and_parenthesis' => '',
    'str_post_block_close_curl' => "\n__IND_BLOCK__",
    'str_pre_block_open_curl' => ' ',
);

our $SINGLETON = undef;

our ($AN2MBF, $MOF, $IND, $AC, $ACS, $AO, $BCP, $BFP, @PBCC, @PBOC);

&instance();

1;

__END__

=head1 NAME

PerlBean::Style - contains PerlBean code style information

=head1 SYNOPSIS

 TODO

=head1 ABSTRACT

PerlBean code style information

=head1 DESCRIPTION

C<PerlBean::Style> class for code generation style

=head1 EXPORT

By default nothing is exported.

=head2 codegen

This tag contains variables usefull for the actual code generation. You should not need to use this tag.

=over

=item $AN2MBF

The value which would be obtained through the singleton object's C<get_attribute_name_to_method_base_filter()> method.

=item $MOF

The value which would be obtained through the singleton object's C<get_method_operation_filter()> method.

=item $IND

The value which would be obtained through the singleton object's C<get_indent()> method.

=item $AC

The value which would be obtained through the singleton object's C<get_str_after_comma()> method.

=item $ACS

The value which would be obtained through the singleton object's C<get_str_around_complex_subscripts()> method.

=item $AO

The value which would be obtained through the singleton object's C<get_str_around_operators()> method.

=item $BCP

The value which would be obtained through the singleton object's C<get_str_between_conditional_and_parenthesis()> method.

=item $BFP

The value which would be obtained through the singleton object's C<get_str_between_function_and_parenthesis()> method.

=item @PBCC

The values which would be obtained through the singleton object's C<get_str_post_block_close_curl()> method and the replacement of C<__IND_BLOCK__> with the correct indentation. The ARRAY's index is the level of indentation. C<10>(!) levels of indentation are available.

=item @PBOC

The values which would be obtained through the singleton object's C<get_str_pre_block_open_curl()> method and the replacement of C<__IND_BLOCK__> with the correct indentation. The ARRAY's index is the level of indentation. C<10>(!) levels of indentation are available.

=back

=head1 CONSTRUCTOR

=over

=item new( [ OPT_HASH_REF ] )

Creates a new C<PerlBean::Style> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<attribute_name_to_method_base_filter>>

Passed to L<set_attribute_name_to_method_base_filter()>. Defaults to B<\&default_attribute_name_to_method_base_filter>.

=item B<C<indent>>

Passed to L<set_indent()>. Defaults to B<'    '>.

=item B<C<method_operation_filter>>

Passed to L<set_method_operation_filter()>. Defaults to B<\&default_method_operation_filter>.

=item B<C<str_after_comma>>

Passed to L<set_str_after_comma()>. Defaults to B<' '>.

=item B<C<str_around_complex_subscripts>>

Passed to L<set_str_around_complex_subscripts()>. Defaults to B<' '>.

=item B<C<str_around_operators>>

Passed to L<set_str_around_operators()>. Defaults to B<' '>.

=item B<C<str_between_conditional_and_parenthesis>>

Passed to L<set_str_between_conditional_and_parenthesis()>. Defaults to B<' '>.

=item B<C<str_between_function_and_parenthesis>>

Passed to L<set_str_between_function_and_parenthesis()>. Defaults to B<''>.

=item B<C<str_post_block_close_curl>>

Passed to L<set_str_post_block_close_curl()>. Defaults to B<"\n__IND_BLOCK__">.

=item B<C<str_pre_block_open_curl>>

Passed to L<set_str_pre_block_open_curl()>. Defaults to B<' '>.

=back

=back

=head1 METHODS

=over

=item default_attribute_name_to_method_base_filter(ATTRIBUTE)

Class method. Default attribute name to method filter. C<ATTRIBUTE> is the attribute name. This method adds a C<_> character to C<ATTRIBUTE> and returns it.

=item default_method_operation_filter(OPERATION)

Class method. Default method operation filter. C<OPERATION> is the operation name. This method plainly returns the C<OPERATION>.

=item instance([OPT_HASH_REF])

Always returns the same C<PerlBean::Style> -singleton- object instance. The forst time it is called, parameter C<OPT_HASH_REF> -if specified- is passed to the constructor.

=item set_attribute_name_to_method_base_filter(VALUE)

Set the subroutine that converts an attribute name to the method base. C<VALUE> is the value. Default value at initialization is C<\&default_attribute_name_to_method_base_filter>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a reference of:

=over

=item CODE

=back

=back

=item get_attribute_name_to_method_base_filter()

Returns the subroutine that converts an attribute name to the method base.

=item set_indent(VALUE)

Set the string used for ONE indentation. C<VALUE> is the value. Default value at initialization is C<'    '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_indent()

Returns the string used for ONE indentation.

=item set_method_operation_filter(VALUE)

Set the subroutine that formats the method operation. C<VALUE> is the value. Default value at initialization is C<\&default_method_operation_filter>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a reference of:

=over

=item CODE

=back

=back

=item get_method_operation_filter()

Returns the subroutine that formats the method operation.

=item set_str_after_comma(VALUE)

Set the string after each comma. C<VALUE> is the value. Default value at initialization is C<' '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_after_comma()

Returns the string after each comma.

=item set_str_around_complex_subscripts(VALUE)

Set the string around "complex" subscripts(inside brackets). C<VALUE> is the value. Default value at initialization is C<' '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_around_complex_subscripts()

Returns the string around "complex" subscripts(inside brackets).

=item set_str_around_operators(VALUE)

Set the string around most operators. C<VALUE> is the value. Default value at initialization is C<' '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_around_operators()

Returns the string around most operators.

=item set_str_between_conditional_and_parenthesis(VALUE)

Set the string between condiftionals (C<for>, C<if>, C<while>...) and parenthesis. C<VALUE> is the value. Default value at initialization is C<' '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_between_conditional_and_parenthesis()

Returns the string between condiftionals (C<for>, C<if>, C<while>...) and parenthesis.

=item set_str_between_function_and_parenthesis(VALUE)

Set the string between function name and its opening parenthesis. C<VALUE> is the value. Default value at initialization is C<''>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_between_function_and_parenthesis()

Returns the string between function name and its opening parenthesis.

=item set_str_post_block_close_curl(VALUE)

Set the string printed after the closing curly of a multi-line BLOCK. Any string C<__IND_BLOCK__> in the value is replaced with the correct block indentation. C<VALUE> is the value. Default value at initialization is C<"\n__IND_BLOCK__">. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_post_block_close_curl()

Returns the string printed after the closing curly of a multi-line BLOCK. Any string C<__IND_BLOCK__> in the value is replaced with the correct block indentation.

=item set_str_pre_block_open_curl(VALUE)

Set the string printed before the opening curly of a multi-line BLOCK. Any string C<__IND_BLOCK__> in the value is replaced with the correct block indentation. C<VALUE> is the value. Default value at initialization is C<' '>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_str_pre_block_open_curl()

Returns the string printed before the opening curly of a multi-line BLOCK. Any string C<__IND_BLOCK__> in the value is replaced with the correct block indentation.

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
L<PerlBean::Method>,
L<PerlBean::Method::Constructor>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: January 2003

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
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::Style::_initialize, first argument must be 'HASH' reference.");

    # attribute_name_to_method_base_filter, SINGLE, with default value
    $self->set_attribute_name_to_method_base_filter( exists( $opt->{attribute_name_to_method_base_filter} ) ? $opt->{attribute_name_to_method_base_filter} : $DEFAULT_VALUE{attribute_name_to_method_base_filter} );

    # indent, SINGLE, with default value
    $self->set_indent( exists( $opt->{indent} ) ? $opt->{indent} : $DEFAULT_VALUE{indent} );

    # method_operation_filter, SINGLE, with default value
    $self->set_method_operation_filter( exists( $opt->{method_operation_filter} ) ? $opt->{method_operation_filter} : $DEFAULT_VALUE{method_operation_filter} );

    # str_after_comma, SINGLE, with default value
    $self->set_str_after_comma( exists( $opt->{str_after_comma} ) ? $opt->{str_after_comma} : $DEFAULT_VALUE{str_after_comma} );

    # str_around_complex_subscripts, SINGLE, with default value
    $self->set_str_around_complex_subscripts( exists( $opt->{str_around_complex_subscripts} ) ? $opt->{str_around_complex_subscripts} : $DEFAULT_VALUE{str_around_complex_subscripts} );

    # str_around_operators, SINGLE, with default value
    $self->set_str_around_operators( exists( $opt->{str_around_operators} ) ? $opt->{str_around_operators} : $DEFAULT_VALUE{str_around_operators} );

    # str_between_conditional_and_parenthesis, SINGLE, with default value
    $self->set_str_between_conditional_and_parenthesis( exists( $opt->{str_between_conditional_and_parenthesis} ) ? $opt->{str_between_conditional_and_parenthesis} : $DEFAULT_VALUE{str_between_conditional_and_parenthesis} );

    # str_between_function_and_parenthesis, SINGLE, with default value
    $self->set_str_between_function_and_parenthesis( exists( $opt->{str_between_function_and_parenthesis} ) ? $opt->{str_between_function_and_parenthesis} : $DEFAULT_VALUE{str_between_function_and_parenthesis} );

    # str_post_block_close_curl, SINGLE, with default value
    $self->set_str_post_block_close_curl( exists( $opt->{str_post_block_close_curl} ) ? $opt->{str_post_block_close_curl} : $DEFAULT_VALUE{str_post_block_close_curl} );

    # str_pre_block_open_curl, SINGLE, with default value
    $self->set_str_pre_block_open_curl( exists( $opt->{str_pre_block_open_curl} ) ? $opt->{str_pre_block_open_curl} : $DEFAULT_VALUE{str_pre_block_open_curl} );

    # Return $self
    return($self);
}

sub default_attribute_name_to_method_base_filter {
    return( '_' . shift );
}

sub default_method_operation_filter {
    return(shift);
}

sub instance {
    # If $SINGLETON is defined return it
    defined($SINGLETON) && return($SINGLETON);

    $SINGLETON = PerlBean::Style->new();
    $SINGLETON->_initialize(@_);
    return($SINGLETON);
}

sub set_attribute_name_to_method_base_filter {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'attribute_name_to_method_base_filter', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_attribute_name_to_method_base_filter, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{attribute_name_to_method_base_filter} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $AN2MBF
    $AN2MBF = $val;
}

sub get_attribute_name_to_method_base_filter {
    my $self = shift;

    return( $self->{PerlBean_Style}{attribute_name_to_method_base_filter} );
}

sub set_indent {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'indent', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_indent, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{indent} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $IND and call set_str_post_block_close_curl and
    # set_str_pre_block_open_curl to (re)make @PBCC and @PBOC
    $IND = $val;
    $self->set_str_post_block_close_curl ( $self->get_str_post_block_close_curl() );
    $self->set_str_pre_block_open_curl ( $self->get_str_pre_block_open_curl() );
}

sub get_indent {
    my $self = shift;

    return( $self->{PerlBean_Style}{indent} );
}

sub set_method_operation_filter {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'method_operation_filter', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_method_operation_filter, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{method_operation_filter} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $MOF
    $MOF = $val;
}

sub get_method_operation_filter {
    my $self = shift;

    return( $self->{PerlBean_Style}{method_operation_filter} );
}

sub set_str_after_comma {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_after_comma', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_after_comma, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_after_comma} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $AC
    $AC = $val;
}

sub get_str_after_comma {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_after_comma} );
}

sub set_str_around_complex_subscripts {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_around_complex_subscripts', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_around_complex_subscripts, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_around_complex_subscripts} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $ACS
    $ACS = $val;
}

sub get_str_around_complex_subscripts {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_around_complex_subscripts} );
}

sub set_str_around_operators {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_around_operators', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_around_operators, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_around_operators} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $AO
    $AO = $val;
}

sub get_str_around_operators {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_around_operators} );
}

sub set_str_between_conditional_and_parenthesis {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_between_conditional_and_parenthesis', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_between_conditional_and_parenthesis, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_between_conditional_and_parenthesis} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $BCP
    $BCP = $val;
}

sub get_str_between_conditional_and_parenthesis {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_between_conditional_and_parenthesis} );
}

sub set_str_between_function_and_parenthesis {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_between_function_and_parenthesis', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_between_function_and_parenthesis, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_between_function_and_parenthesis} = $val;

    # Set export value only for the singleton object instance
    return if ($self != $SINGLETON);

    # Set $BFP
    $BFP = $val;
}

sub get_str_between_function_and_parenthesis {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_between_function_and_parenthesis} );
}

sub set_str_post_block_close_curl {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_post_block_close_curl', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_post_block_close_curl, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_post_block_close_curl} = $val;

    # Make @PBCC
    for (my $i = 0; $i < 10; $i++) {
        $PBCC[$i] = $val;
        my $ind_block = $IND x $i;
        $PBCC[$i] =~ s/__IND_BLOCK__/$ind_block/g;
    }
}

sub get_str_post_block_close_curl {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_post_block_close_curl} );
}

sub set_str_pre_block_open_curl {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'str_pre_block_open_curl', $val ) || throw Error::Simple("ERROR: PerlBean::Style::set_str_pre_block_open_curl, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean_Style}{str_pre_block_open_curl} = $val;

    # Make @PBOC
    for (my $i = 0; $i < 10; $i++) {
        $PBOC[$i] = $val;
        my $ind_block = $IND x $i;
        $PBOC[$i] =~ s/__IND_BLOCK__/$ind_block/g;
    }
}

sub get_str_pre_block_open_curl {
    my $self = shift;

    return( $self->{PerlBean_Style}{str_pre_block_open_curl} );
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

