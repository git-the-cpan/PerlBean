package PerlBean;

use 5.005;
use strict;
use warnings;
use Error qw(:try);
use AutoLoader qw(AUTOLOAD);
use PerlBean::Style qw(:codegen);

our ( $VERSION ) = '$Revision: 0.6 $' =~ /\$Revision:\s+([^\s]+)/;

our %ALLOW_ISA = (
    'attribute' => [ 'PerlBean::Attribute' ],
    'collection' => [ 'PerlBean::Collection' ],
    'method' => [ 'PerlBean::Method' ],
);
our %ALLOW_REF = (
);
our %ALLOW_RX = (
    'abstract' => [ '^.*$' ],
    'base' => [ '^\S+$' ],
    'license' => [ '.*' ],
    'synopsis' => [ '.*' ],
);
our %ALLOW_VALUE = (
);
our %DEFAULT_VALUE = (
    'exception_class' => 'Error::Simple',
    'exported' => 0,
    'package' => 'main',
    'short_description' => 'NO DESCRIPTION AVAILABLE',
);

our @MON = qw(
    January
    February
    March
    April
    May
    June
    July
    August
    September
    October
    November
    December
);
our $PACKAGE = 'package';
our $SUB = 'sub';
our $END = '__END__';

1;

__END__

=head1 NAME

PerlBean - Package to generate bean like Perl modules

=head1 SYNOPSIS

 use strict;
 use PerlBean;
 use PerlBean::Attribute::Factory;
 
 my $bean = PerlBean->new();
 my $factory = PerlBean::Attribute::Factory->new();
 my $attr = $factory->create_attribute( {
     attribute_name => 'true',
     short_description => 'something is true',
 } );
 $bean->add_attribute($attr);
 
 use IO::File;
 -d 'tmp' || mkdir('tmp');
 my $fh = IO::File->new('> tmp/PerlBean.pl.out');
 $bean->write($fh);

=head1 ABSTRACT

Code generation for bean like Perl modules

=head1 DESCRIPTION

C<PerlBean> generates bean like Perl packages. That is, it generates code with for a module with attributes(properties) and the attribute's access methods (B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<has>, B<get> or B<is>, depending on the type of attribute). The attribute base types are B<BOOLEAN>, B<SINGLE> and B<MULTI>. B<BOOLEAN> attributes may be set to C<0> or C<1>. B<SINGLE> attributes may contain any scalar. B<MULTI> attributes contain a set of values(ordered/not ordered and unique/not unique).

The attribute insertion methods (C<set_attribute()>, C<push_attribute()> and unshift_attribute()) accept C<PerlBean::Attribute> objects. However, C<PerlBean::Attribute> are best generated using C<PerlBean::Attribute::Factory>. See the sample in the B<SYNOPSIS> section.

Finaly, the actual bean code is written using the C<write()> method.

The generated code should be free of syntax errors. It's intended to be mixed with the application logic you intend to write yourself.

Background information: Of course the attribute code in C<PerlBean> and C<PerlBean::Attribute> are actually generated using this method.

=head1 CONSTRUCTOR

=over

=item new( [ OPT_HASH_REF ] )

Creates a new C<PerlBean> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> may include:

=over

=item B<C<abstract>>

Passed to L<set_abstract()>.

=item B<C<attribute>>

Passed to L<set_attribute()>. Must be an C<ARRAY> reference.

=item B<C<base>>

Passed to L<set_base()>. Must be an C<ARRAY> reference.

=item B<C<collection>>

Passed to L<set_collection()>.

=item B<C<description>>

Passed to L<set_description()>.

=item B<C<exception_class>>

Passed to L<set_exception_class()>. Defaults to B<'Error::Simple'>.

=item B<C<exported>>

Passed to L<set_exported()>. Defaults to B<0>.

=item B<C<license>>

Passed to L<set_license()>.

=item B<C<method>>

Passed to L<set_method()>. Must be an C<ARRAY> reference.

=item B<C<package>>

Passed to L<set_package()>. Defaults to B<'main'>.

=item B<C<short_description>>

Passed to L<set_short_description()>. Defaults to B<'NO DESCRIPTION AVAILABLE'>.

=item B<C<synopsis>>

Passed to L<set_synopsis()>.

=back

=back

=head1 METHODS

=over

=item write(FILEHANDLE)

Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_allow_isa_hash(FILEHANDLE)

Write the C<%ALLOW_ISA> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_allow_ref_hash(FILEHANDLE)

Write the C<%ALLOW_REF> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_allow_rx_hash(FILEHANDLE)

Write the C<%ALLOW_RX> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_allow_value_hash(FILEHANDLE)

Write the C<%ALLOW_VALUE> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_default_value_hash(FILEHANDLE)

Write the C<%DEFAULT_VALUE> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item set_abstract(VALUE)

Set the PerlBean's abstract (a one line description of the module). C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^.*$

=back

=back

=item get_abstract()

Returns the PerlBean's abstract (a one line description of the module).

=item set_attribute( [ VALUE ... ] )

Set the list of 'PerlBean::Attribute' objects absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<get_attribute_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Attribute

=back

=back

=item add_attribute( [ VALUE ... ] )

Add additional values on the list of 'PerlBean::Attribute' objects. Each C<VALUE> is an object out of which the id is obtained through method C<get_attribute_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Attribute

=back

=back

=item delete_attribute(ARRAY)

Delete elements from the list of 'PerlBean::Attribute' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_attribute(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of 'PerlBean::Attribute' objects.

=item keys_attribute()

Returns an C<ARRAY> containing the keys of the list of 'PerlBean::Attribute' objects.

=item values_attribute( [ KEY_ARRAY ] )

Returns an C<ARRAY> containing the values of the list of 'PerlBean::Attribute' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

=item set_base(ARRAY)

Set the list of class names in use base absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the first occuring element to be inserted and the rest to be ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item push_base(ARRAY)

Push additional values on the list of class names in use base. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item pop_base()

Pop and return an element off the list of class names in use base. On error an exception C<Error::Simple> is thrown.

=item shift_base()

Shift and return an element off the list of class names in use base. On error an exception C<Error::Simple> is thrown.

=item unshift_base(ARRAY)

Unshift additional values on the list of class names in use base. C<ARRAY> is the list value. The push may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element are ignored. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must match regular expression:

=over

=item ^\S+$

=back

=back

=item exists_base(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of class names in use base.

=item get_base()

Returns an C<ARRAY> containing the list of class names in use base. C<INDEX_ARRAY> is an optional list of indexes which when specified causes only the indexed elements in the ordered list to be returned. If not specified, all elements are returned.

=item set_collection(VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must be a (sub)class of:

=over

=item PerlBean::Collection

=back

=back

=item get_collection()

Returns class to throw when exception occurs.

=item set_description(VALUE)

Set the PerlBean description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item get_description()

Returns the PerlBean description.

=item set_exception_class(VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. Default value at initialization is C<'Error::Simple'>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item get_exception_class()

Returns class to throw when exception occurs.

=item set_exported(VALUE)

State that the PerlBean must contain code for exporter. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item is_exported()

Returns whether the PerlBean must contain code for exporter or not.

=item set_license(VALUE)

Set the software license for the PerlBean. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_license()

Returns the software license for the PerlBean.

=item set_method( [ VALUE ... ] )

Set the list of 'PerlBean::Method' objects absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<get_method_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Method

=back

=back

=item add_method( [ VALUE ... ] )

Add additional values on the list of 'PerlBean::Method' objects. Each C<VALUE> is an object out of which the id is obtained through method C<get_method_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Method

=back

=back

=item delete_method(ARRAY)

Delete elements from the list of 'PerlBean::Method' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_method(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of 'PerlBean::Method' objects.

=item keys_method()

Returns an C<ARRAY> containing the keys of the list of 'PerlBean::Method' objects.

=item values_method( [ KEY_ARRAY ] )

Returns an C<ARRAY> containing the values of the list of 'PerlBean::Method' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

=item set_package(VALUE)

Set package name. C<VALUE> is the value. Default value at initialization is C<'main'>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item get_package()

Returns package name.

=item set_short_description(VALUE)

Set the short PerlBean description. C<VALUE> is the value. Default value at initialization is C<'NO DESCRIPTION AVAILABLE'>. On error an exception C<Error::Simple> is thrown.

=item get_short_description()

Returns the short PerlBean description.

=item set_synopsis(VALUE)

Set the synopsis for the PerlBean. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item .*

=back

=back

=item get_synopsis()

Returns the synopsis for the PerlBean.

=back

=head1 SEE ALSO

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
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::_initialize, first argument must be 'HASH' reference.");

    # abstract, SINGLE
    exists( $opt->{abstract} ) && $self->set_abstract( $opt->{abstract} );

    # attribute, MULTI
    if ( exists( $opt->{attribute} ) ) {
        ref( $opt->{attribute} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'attribute' must be an 'ARRAY' reference.");
        $self->set_attribute( @{ $opt->{attribute} } );
    }
    else {
        $self->set_attribute();
    }

    # base, MULTI
    if ( exists( $opt->{base} ) ) {
        ref( $opt->{base} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'base' must be an 'ARRAY' reference.");
        $self->set_base( @{ $opt->{base} } );
    }
    else {
        $self->set_base();
    }

    # collection, SINGLE
    exists( $opt->{collection} ) && $self->set_collection( $opt->{collection} );

    # description, SINGLE
    exists( $opt->{description} ) && $self->set_description( $opt->{description} );

    # exception_class, SINGLE, with default value
    $self->set_exception_class( exists( $opt->{exception_class} ) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class} );

    # exported, BOOLEAN, with default value
    $self->set_exported( exists( $opt->{exported} ) ? $opt->{exported} : $DEFAULT_VALUE{exported} );

    # license, SINGLE
    exists( $opt->{license} ) && $self->set_license( $opt->{license} );

    # method, MULTI
    if ( exists( $opt->{method} ) ) {
        ref( $opt->{method} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'method' must be an 'ARRAY' reference.");
        $self->set_method( @{ $opt->{method} } );
    }
    else {
        $self->set_method();
    }

    # package, SINGLE, with default value
    $self->set_package( exists( $opt->{package} ) ? $opt->{package} : $DEFAULT_VALUE{package} );

    # short_description, SINGLE, with default value
    $self->set_short_description( exists( $opt->{short_description} ) ? $opt->{short_description} : $DEFAULT_VALUE{short_description} );

    # synopsis, SINGLE
    exists( $opt->{synopsis} ) && $self->set_synopsis( $opt->{synopsis} );

    # Return $self
    return($self);
}

sub write {
    my $self = shift;
    my $fh = shift;

    # Package heading
    $self->write_package_head($fh);

    # Allow vairables
    if ( scalar( $self->values_attribute() ) ) {
        $self->write_allow_isa_hash($fh);
        $self->write_allow_ref_hash($fh);
        $self->write_allow_rx_hash($fh);
        $self->write_allow_value_hash($fh);
        $self->write_default_value_hash($fh);
    }

    # End of preloaded methods
    $self->write_preloaded_end($fh);

    # Start pod documentation
    $self->write_doc_head($fh);


    # Get all methods that are callable from this package
    $self->get_callable_methods( \my %meth, {} );

    # As get_callable_methods() returns interface methods too,
    # check that no interface methods from other packages
    # are returned
    foreach my $name ( sort( keys(%meth) ) ) {
        ( $meth{$name}->get_package() eq $self->get_package() ) && next;
        throw Error::Simple(
            "ERROR: PerlBean::write, method '$name' which is defined as interface in package '" .
            $meth{$name}->get_package() . "' is not inplemented in subclass '" .
            $self->get_package() . "'"
        ) if ( $meth{$name}->is_interface() );
    }

    # Check for inherited methods and remember the package names
    #
    # %attr contains both the attributes defined in the class itself and
    # in its superclasses. The attribute objects are indexed by attribute
    # name.
    #
    # %pkg contains the packages from which attribute methods are inherited
    #
    # $do_inherited is set to 1 when attribute methods actually are inherited
    #
    $self->get_inherit_attributes(\my %attr, {});
    my %pkg = ();
    my $do_inherited = 0;
    foreach my $attr ( values(%attr) ) {
        $do_inherited = $do_inherited || ( $attr->get_perl_bean()->get_package() ne $self->get_package() );
        $pkg{ $attr->get_perl_bean()->get_package() } = 1;
    }

    # Constructor documentation
    $self->write_doc_constructor_head( $fh, \%attr );
    if (scalar($self->values_attribute())) {
        $self->write_doc_constructor_body($fh);
    }
    if ($do_inherited) {
        $self->write_doc_inherit_constructor_body( $fh, \%attr, \%pkg );
    }
    $self->write_doc_constructor_body_constructors( $fh, \%meth );
    $self->write_doc_constructor_tail($fh);

    # Methods documentation
    if ( scalar( $self->values_attribute() ) || scalar( keys(%meth) ) ) {
        $self->write_doc_methods_head($fh);
        $self->write_doc_methods_body( $fh, \%meth );
        $self->write_doc_methods_tail($fh);
    }

    # Inherited methods documentation
    $self->write_doc_inherit_methods( $fh, \%attr, \%pkg ) if ($do_inherited);

    # Finish pod documentation
    $self->write_doc_tail($fh);

    # The new method
    if (! $self->super_class_in_collection() ) {
        $self->write_new_method($fh);
    }

    # The _initialize method
    if ( scalar( $self->values_attribute() ) || scalar ( $self->get_base() ) > 1 || ! $do_inherited ) {
        $self->write_init_method_head($fh);
        $self->write_init_method_body($fh);
        $self->write_init_method_tail($fh);
    }

    # All methods from this bean
    my %all_meth_ref = ();
    foreach my $name ( sort( $self->keys_method() ) ) {
        my $method = ( $self->values_method($name) )[0];
        $method->write_code($fh);
        $all_meth_ref{$name} = $method;
    }

    # All attributes from this bean
    my %all_attr_ref = ();
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        $attribute->write_methods($fh);
        $all_attr_ref{$name} = $attribute;
    }

    # Allow method
    if ( scalar( $self->values_attribute() ) ) {
        $self->write_value_allowed_method($fh);
    }
}

sub write_allow_isa_hash {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
our \%ALLOW_ISA${AO}=${AO}(
EOF
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ($self->values_attribute($name))[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $attribute->write_allow_isa($fh);
    }
    $fh->print(<<EOF);
);
EOF

}

sub write_allow_ref_hash {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
our \%ALLOW_REF${AO}=${AO}(
EOF
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $attribute->write_allow_ref($fh);
    }
    $fh->print(<<EOF);
);
EOF

}

sub write_allow_rx_hash {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
our \%ALLOW_RX${AO}=${AO}(
EOF
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $attribute->write_allow_rx($fh);
    }
    $fh->print(<<EOF);
);
EOF

}

sub write_allow_value_hash {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
our \%ALLOW_VALUE${AO}=${AO}(
EOF
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $attribute->write_allow_value($fh);
    }
    $fh->print(<<EOF);
);
EOF

}

sub write_default_value_hash {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
our \%DEFAULT_VALUE${AO}=${AO}(
EOF
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        $attribute->write_default_value($fh);
    }
    $fh->print(<<EOF);
);

EOF

}

sub set_abstract {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'abstract', $val ) || throw Error::Simple("ERROR: PerlBean::set_abstract, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{abstract} = $val;
}

sub get_abstract {
    my $self = shift;

    return( $self->{PerlBean}{abstract} );
}

sub set_attribute {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'attribute', @_ ) || throw Error::Simple("ERROR: PerlBean::set_attribute, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{attribute} = {};

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{attribute}{ $val->get_attribute_name() } = $val;
        $val->set_perl_bean($self);
    }
}

sub add_attribute {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'attribute', @_ ) || throw Error::Simple("ERROR: PerlBean::add_attribute, one or more specified value(s) '@_' is/are not allowed.");

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{attribute}{ $val->get_attribute_name() } = $val;
        $val->set_perl_bean($self);
    }
}

sub delete_attribute {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{attribute}{$val} ) || next;
        delete( $self->{PerlBean}{attribute}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_attribute {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{attribute}{$val} );
    }
    return($count);
}

sub keys_attribute {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{attribute} } ) );
}

sub values_attribute {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{attribute}{$key} ) && push( @ret, $self->{PerlBean}{attribute}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{attribute} } ) );
    }
}

sub set_base {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'base', @_ ) || throw Error::Simple("ERROR: PerlBean::set_base, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{base}{ARRAY} = [];
    $self->{PerlBean}{base}{HASH} = {};

    # Push values
    foreach my $val (@_) {
        next if ( exists( $self->{PerlBean}{base}{HASH}{$val} ) );
        push( @{ $self->{PerlBean}{base}{ARRAY} }, $val );
        $self->{PerlBean}{base}{HASH}{$val} = $val;
    }
}

sub push_base {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'base', @_ ) || throw Error::Simple("ERROR: PerlBean::push_base, one or more specified value(s) '@_' is/are not allowed.");

    # Push values
    foreach my $val (@_) {
        next if ( exists( $self->{PerlBean}{base}{HASH}{$val} ) );
        push( @{ $self->{PerlBean}{base}{ARRAY} }, $val );
        $self->{PerlBean}{base}{HASH}{$val} = $val;
    }
}

sub pop_base {
    my $self = shift;

    # Pop value
    my $val = pop( @{ $self->{PerlBean}{base}{ARRAY} } );
    delete( $self->{PerlBean}{base}{HASH}{$val} );
    return($val);
}

sub shift_base {
    my $self = shift;

    # Shift value
    my $val = shift( @{ $self->{PerlBean}{base}{ARRAY} } );
    delete( $self->{PerlBean}{base}{HASH}{$val} );
    return($val);
}

sub unshift_base {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'base', @_ ) || throw Error::Simple("ERROR: PerlBean::unshift_base, one or more specified value(s) '@_' is/are not allowed.");

    # Unshift values
    foreach my $val ( reverse(@_) ) {
        next if ( exists( $self->{PerlBean}{base}{HASH}{$val} ) );
        unshift( @{ $self->{PerlBean}{base}{ARRAY} }, $val );
        $self->{PerlBean}{base}{HASH}{$val} = $val;
    }
}

sub exists_base {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{base}{HASH}{$val} );
    }
    return($count);
}

sub get_base {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $i (@_) {
            push( @ret, $self->{PerlBean}{base}{ARRAY}[ int($i) ] );
        }
        return(@ret);
    }
    else {
        # Return the list
        return( @{ $self->{PerlBean}{base}{ARRAY} } );
    }
}

sub set_collection {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'collection', $val ) || throw Error::Simple("ERROR: PerlBean::set_collection, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{collection} = $val;
}

sub get_collection {
    my $self = shift;

    return( $self->{PerlBean}{collection} );
}

sub set_description {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'description', $val ) || throw Error::Simple("ERROR: PerlBean::set_description, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{description} = $val;
}

sub get_description {
    my $self = shift;

    return( $self->{PerlBean}{description} );
}

sub set_exception_class {
    my $self = shift;
    my $val = shift;

    # Value for 'exception_class' is not allowed to be empty
    defined($val) || throw Error::Simple("ERROR: PerlBean::set_exception_class, value may not be empty.");

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'exception_class', $val ) || throw Error::Simple("ERROR: PerlBean::set_exception_class, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{exception_class} = $val;
}

sub get_exception_class {
    my $self = shift;

    return( $self->{PerlBean}{exception_class} );
}

sub set_exported {
    my $self = shift;

    if (shift) {
        $self->{PerlBean}{exported} = 1;
    }
    else {
        $self->{PerlBean}{exported} = 0;
    }
}

sub is_exported {
    my $self = shift;

    if ( $self->{PerlBean}{exported} ) {
        return(1);
    }
    else {
        return(0);
    }
}

sub set_license {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'license', $val ) || throw Error::Simple("ERROR: PerlBean::set_license, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{license} = $val;
}

sub get_license {
    my $self = shift;

    return( $self->{PerlBean}{license} );
}

sub set_method {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'method', @_ ) || throw Error::Simple("ERROR: PerlBean::set_method, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{method} = {};

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{method}{ $val->get_method_name() } = $val;
        $val->set_perl_bean($self);
    }
}

sub add_method {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'method', @_ ) || throw Error::Simple("ERROR: PerlBean::add_method, one or more specified value(s) '@_' is/are not allowed.");

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{method}{ $val->get_method_name() } = $val;
        $val->set_perl_bean($self);
    }
}

sub delete_method {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{method}{$val} ) || next;
        delete( $self->{PerlBean}{method}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_method {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{method}{$val} );
    }
    return($count);
}

sub keys_method {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{method} } ) );
}

sub values_method {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{method}{$key} ) && push( @ret, $self->{PerlBean}{method}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{method} } ) );
    }
}

sub set_package {
    my $self = shift;
    my $val = shift;

    # Value for 'package' is not allowed to be empty
    defined($val) || throw Error::Simple("ERROR: PerlBean::set_package, value may not be empty.");

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'package', $val ) || throw Error::Simple("ERROR: PerlBean::set_package, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{package} = $val;
}

sub get_package {
    my $self = shift;

    return( $self->{PerlBean}{package} );
}

sub set_short_description {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'short_description', $val ) || throw Error::Simple("ERROR: PerlBean::set_short_description, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{short_description} = $val;
}

sub get_short_description {
    my $self = shift;

    return( $self->{PerlBean}{short_description} );
}

sub set_synopsis {
    my $self = shift;
    my $val = shift;

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'synopsis', $val ) || throw Error::Simple("ERROR: PerlBean::set_synopsis, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{synopsis} = $val;
}

sub get_synopsis {
    my $self = shift;

    return( $self->{PerlBean}{synopsis} );
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

sub get_overloaded_attribute {
    my $self = shift;
    my $match_attr = shift;
    my $loop_stop = shift;

    # Check for a loop
    my $pkg = $self->get_package();
    exists( $loop_stop->{$pkg} ) && throw Error::Simple("ERROR: PerlBean::get_overloaded_attribute, loop detected in inheritance at bean '$pkg'.");
    $loop_stop->{$pkg} = 1;

    # Check and return attribute if found in this bean
    my $found_attr = ( $self->values_attribute( $match_attr->get_attribute_name() ) )[0];
    if ( defined($found_attr) ) {
        # Get the reference type of the attribute to match
        my $match_attr_ref = ref($match_attr);

        # Get the reference type of the found attribute
        my $found_attr_ref = ref($found_attr);

        # Match found if the reference types of the attribute to match and the found attribute are identical.
        ( $match_attr_ref eq $found_attr_ref ) && return($found_attr);

        # The reference types of the attribute to match and the found attribute are different. Throw a usable exception.
        my $name = $found_attr->get_attribute_name();
        my $match_attr_pkg = $match_attr->get_perl_bean()->get_package();
        throw Error::Simple("ERROR: PerlBean::get_overloaded_attribute, found an attribute named '$name' in package '$pkg' but the reference type '$found_attr_ref' was not as in package '$match_attr_pkg' ($match_attr_ref).");
    }

    # Check super classes
    foreach my $super_pkg ($self->get_base()) {
        # Get the super class bean
        my $super_bean = ( $self->get_collection()->values_perl_bean($super_pkg) )[0];

        # If the super class bean has no bean in the collection then no attribute is found
        defined($super_bean) || return(undef);

        # See if the super class bean has an attribute
        my $attr_over = $super_bean->get_overloaded_attribute( $match_attr, $loop_stop );

        # Return the overloaded bean if found
        defined($attr_over) && return($attr_over);
    }

    # Nothing found
    return(undef);
}

sub get_super_method {
    my $self = shift;
    my $match_meth = shift;
    my $loop_stop = shift;

    # Check for a loop
    my $pkg = $self->get_package();
    exists( $loop_stop->{$pkg} ) && throw Error::Simple("ERROR: PerlBean::get_super_method, loop detected in inheritance at bean '$pkg'.");
    $loop_stop->{$pkg} = 1;

    # Check and return method if found in this bean
    my $found_meth = ( $self->values_method( $match_meth->get_method_name() ) )[0];
    defined($found_meth) && return($found_meth);

    # Check super classes
    foreach my $super_pkg ($self->get_base()) {
        # Get the super class bean
        my $super_bean = ( $self->get_collection()->values_perl_bean($super_pkg) )[0];

        # If the super class bean has no bean in the collection then no method is found
        defined($super_bean) || return(undef);

        # See if the super class bean has the method
        my $found_meth = $super_bean->get_super_method( $match_meth, $loop_stop );

        # Return the overloaded bean if found
        defined($found_meth) && return($found_meth);
    }

    # Nothing found
    return(undef);
}

sub get_inherit_attributes {
    my $self = shift;
    my $done = shift;
    my $loop_stop = shift;

    # Check for a loop
    my $pkg = $self->get_package();
    exists( $loop_stop->{$pkg} ) && throw Error::Simple("ERROR: PerlBean::get_inherit_attributes, loop detected for bean '$pkg'.");
    $loop_stop->{$pkg} = 1;

    # Add own attributes
    foreach my $attr ( $self->values_attribute() ) {
        exists( $done->{ $attr->get_attribute_name() } ) && next;
        $done->{ $attr->get_attribute_name() } = $attr;
    }

    # Add attributes from super classes
    foreach my $super_pkg ($self->get_base()) {
        # Get the super class bean
        my $super_bean = ($self->get_collection()->values_perl_bean($super_pkg))[0];

        # If the super package is not in the collection, well too bad (for now anyway)
        defined($super_bean) || next;

        # See if the super class bean has an attribute
        $super_bean->get_inherit_attributes( $done, $loop_stop );
    }
}

sub get_callable_methods {
    my $self = shift;
    my $meth_found = shift;
    my $loop_stop = shift;

    # Check for a loop
    my $pkg = $self->get_package();
    exists( $loop_stop->{$pkg} ) && throw Error::Simple("ERROR: PerlBean::get_callable_methods, loop detected for bean '$pkg'.");
    $loop_stop->{$pkg} = 1;

    # Add own methods
    foreach my $meth ( $self->values_method() ) {
        exists( $meth_found->{ $meth->get_method_name() } ) && next;
        $meth_found->{ $meth->get_method_name() } = $meth;
    }

    # End if collection not set
    defined( $self->get_collection() ) || return;

    # Add methods from super classes
    foreach my $super_pkg ( $self->get_base() ) {
        # Get the super class bean
        my $super_bean = ( $self->get_collection()->values_perl_bean($super_pkg) )[0];

        # If the super package is not in the collection, well too bad (for now anyway)
        defined($super_bean) || next;

        # See if the super class bean has an attribute
        $super_bean->get_callable_methods( $meth_found, $loop_stop );
    }
}

sub super_class_in_collection {
    my $self = shift;

    # Fail if this is not a subclass
    scalar( $self->get_base() ) || return(0);

    # Fail if the collection is not set
    $self->get_collection() || return(0);

    # Get the first super class package
    my $super_pkg = ( $self->get_base() )[0];

    # Get the super class bean
    my $super_bean = ( $self->get_collection()->values_perl_bean($super_pkg) )[0];

    # Succeed if the superclass package is in the collection
    return( defined($super_bean) );
}

sub write_doc_constructor_body {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
Options for C<OPT_HASH_REF> may include:

\=over

EOF
    foreach my $name (sort($self->keys_attribute())) {
        my $attribute = ($self->values_attribute($name))[0];
        $attribute->write_doc_init($fh);
    }

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_constructor_body_constructors {
    my $self = shift;
    my $fh = shift;
    my $meth = shift;

    foreach my $name (sort(keys(%{$meth}))) {
        $meth->{$name}->isa('PerlBean::Method::Constructor') || next;
        $meth->{$name}->write_pod($fh, $self->get_package());
    }
}

sub write_doc_inherit_constructor_body {
    my $self = shift;
    my $fh = shift;
    my $attr = shift;
    my $pkg = shift;

    

    foreach my $pkg_name (sort(keys(%{$pkg}))) {
        next if ($self->get_package() eq $pkg_name);

        $fh->print(<<EOF);
Options for C<OPT_HASH_REF> inherited through package B<C<$pkg_name>> may include:

\=over

EOF
        foreach my $attr_name (sort(keys(%{$attr}))) {
            next if ($attr->{$attr_name}->get_perl_bean()->get_package() ne $pkg_name);
            $attr->{$attr_name}->write_doc_init($fh);
        }

    $fh->print(<<EOF);
\=back

EOF
    }
}

sub write_doc_constructor_head {
    my $self = shift;
    my $fh = shift;
    my $attr = shift;

    my $pkg = $self->get_package();
    my $ec = $self->get_exception_class();
    my $mand = '';
    my $pre = "${ACS}[${ACS}";
    my $post = "${ACS}]${ACS}";
    foreach my $name ($self->keys_attribute()) {
        my $attribute = ($self->values_attribute($name))[0];
        if ($attribute->is_mandatory()) {
            $pre = '';
            $post = '';
            $mand = ' C<OPT_HASH_REF> is mandatory.';
            last;
        }
    }

    if (! $mand) {
        foreach my $name (keys(%{$attr})) {
            my $attribute = $attr->{$name};
            if ($attribute->is_mandatory()) {
                $pre = '';
                $post = '';
                $mand = ' C<OPT_HASH_REF> is mandatory.';
                last;
            }
        }
    }

    $fh->print(<<EOF);
\=head1 CONSTRUCTOR

\=over

EOF

    $fh->print(<<EOF);
\=item new${BFP}(${pre}OPT_HASH_REF${post})

Creates a new C<$pkg> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options.${mand} On error an exception C<$ec> is thrown.

EOF
}

sub write_doc_constructor_tail {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_head {
    my $self = shift;
    my $fh = shift;

    my $pkg = $self->get_package();
    my $sdesc = $self->get_short_description();

    my $desc = defined($self->get_description()) ? $self->get_description() : "C<$pkg> TODO\n";

    my $syn = defined($self->get_synopsis()) ? $self->get_synopsis() : " TODO\n";

    my $abs = defined($self->get_abstract()) ? $self->get_abstract() : "TODO\n";

    $fh->print(<<EOF);
\=head1 NAME

${pkg} - ${sdesc}

\=head1 SYNOPSIS

$syn
\=head1 ABSTRACT

$abs

\=head1 DESCRIPTION

${desc}
EOF

    if ($self->is_exported()) {
        $fh->print(<<EOF);
\=head1 EXPORT

TODO

EOF
    }
}

sub write_doc_methods_body {
    my $self = shift;
    my $fh = shift;
    my $meth = shift;

    foreach my $name (sort(keys(%{$meth}))) {
        $meth->{$name}->isa('PerlBean::Method::Constructor') && next;
        $meth->{$name}->write_pod($fh, $self->get_package());
    }
    foreach my $name (sort($self->keys_attribute())) {
        my $attribute = ($self->values_attribute($name))[0];
        $attribute->write_doc_methods($fh);
    }
}

sub write_doc_methods_head {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
\=head1 METHODS

\=over

EOF
}

sub write_doc_methods_tail {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
\=back

EOF
}

sub write_doc_tail {
    my $self = shift;
    my $fh = shift;

    my $m = $MON[(localtime())[4]];
    my $y = (localtime())[5] + 1900;
    my $p = (getpwuid($>))[6];

    my $also = 'TODO';
    if (defined($self->get_collection())) {
        $also = '';
        foreach my $pkg (sort($self->get_collection()->keys_perl_bean())) {
            next if ($pkg eq $self->get_package());
            $also .= "L<$pkg>,\n";
        }
        chop($also);
        chop($also);
        $also = $also ? $also : 'NONE';
    }

    my $lic = 'TODO';
    if (defined($self->get_license())) {
        $lic = $self->get_license();
    }
    elsif (defined($self->get_collection()) && defined($self->get_collection()->get_license())) {
        $lic = $self->get_collection()->get_license();
    }

    $fh->print(<<EOF);
\=head1 SEE ALSO

$also

\=head1 BUGS

None known (yet.)

\=head1 HISTORY

First development: ${m} ${y}

\=head1 AUTHOR

${p}

\=head1 COPYRIGHT

Copyright ${y} by ${p}

\=head1 LICENSE

$lic

\=cut

EOF
}

sub write_doc_inherit_methods {
    my $self = shift;
    my $fh = shift;
    my $attr = shift;
    my $pkg = shift;

    foreach my $pkg_name (sort(keys(%{$pkg}))) {
        next if ($self->get_package() eq $pkg_name);

        $self->write_doc_inherit_methods_head($fh, $pkg_name);

        $self->write_doc_inherit_methods_body($fh, $attr, $pkg_name);

        $self->write_doc_inherit_methods_tail($fh);
    }
}

sub write_doc_inherit_methods_body {
    my $self = shift;
    my $fh = shift;
    my $attr = shift;
    my $pkg = shift;

    foreach my $attr_name (sort(keys(%{$attr}))) {
        next if ($attr->{$attr_name}->get_perl_bean()->get_package() ne $pkg);
        $fh->print(<<EOF);
\=item To access attribute named B<C<$attr_name>>:

EOF
        $attr->{$attr_name}->write_doc_inherit_methods($fh);
    }
}

sub write_doc_inherit_methods_head {
    my $self = shift;
    my $fh = shift;
    my $pkg = shift;

    $fh->print(<<EOF);
\=head1 INHERITED METHODS FROM $pkg

\=over

EOF
}

sub write_doc_inherit_methods_tail {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
\=back

EOF
}

sub write_init_method_body {
    my $self = shift;
    my $fh = shift;

    foreach my $name (sort($self->keys_attribute())) {
        my $attribute = ($self->values_attribute($name))[0];
        $attribute->write_opt_init($fh);
    }
}

sub write_init_method_head {
    my $self = shift;
    my $fh = shift;

    my $pkg = $self->get_package();
    my $ec = $self->get_exception_class();

    $fh->print(<<EOF);
$SUB _initialize${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;
EOF

    if ( scalar( $self->values_attribute() ) ) {
        $fh->print(<<EOF);
${IND}my \$opt${AO}=${AO}defined${BFP}(\$_[0])${AO}?${AO}shift${AO}:${AO}{};

${IND}# Check \$opt
${IND}ref${BFP}(\$opt)${AO}eq${AO}'HASH'${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::_initialize, first argument must be 'HASH' reference.");
EOF
    }

    $fh->print(<<EOF);

EOF
}

sub write_init_method_tail {
    my $self = shift;
    my $fh = shift;

    if ( scalar ( $self->get_base() ) == 1 && scalar ( $self->values_attribute() ) ) {
        $fh->print(<<EOF);
${IND}# Call the superclass' _initialize
${IND}\$self->SUPER::_initialize${BFP}(\$opt);

EOF
    }

    elsif ( scalar ( $self->get_base() ) == 1 && ! scalar ( $self->values_attribute() ) ) {
        $fh->print(<<EOF);
${IND}# Call the superclass' _initialize
${IND}\$self->SUPER::_initialize${BFP}(\@_);

EOF
    }

    elsif ( scalar ( $self->get_base() ) > 1 ) {
        $fh->print(<<EOF);
${IND}# Call the superclasses' _initialize
EOF

        foreach my $super ( $self->get_base() ) {

            $fh->print(<<EOF);
${IND}\$self->${super}::_initialize${BFP}(\$opt);
EOF
        }

        $fh->print(<<EOF);

EOF
    }

    $fh->print(<<EOF);
${IND}# Return \$self
${IND}return${BFP}(\$self);
}

EOF
}

sub write_new_method {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
$SUB new${PBOC[0]}{
${IND}my \$class${AO}=${AO}shift;

${IND}my \$self${AO}=${AO}{};
${IND}bless${BFP}(${ACS}\$self,${AC}(${ACS}ref${BFP}(\$class)${AO}||${AO}\$class${ACS})${ACS});
${IND}return${BFP}(${ACS}\$self->_initialize${BFP}(\@_)${ACS});
}

EOF
}

sub write_package_head {
    my $self = shift;
    my $fh = shift;

    my $pkg = $self->get_package();
    $fh->print(<<EOF);
$PACKAGE $pkg;

use $];
use strict;
use warnings;
use Error qw${BFP}(:try);
use AutoLoader qw${BFP}(AUTOLOAD);

EOF

    if ($self->is_exported()) {
        $fh->print(<<EOF);
require Exporter;

EOF
    }

    # base
    if (scalar($self->get_base())) {
        my @base = $self->get_base();
        $self->is_exported() && push(@base, qw(Exporter));
        $fh->print(<<EOF);
use base qw${BFP}(@base);

EOF
    }
    elsif ($self->is_exported()) {
        $fh->print(<<EOF);
our \@ISA${AO}=${AO}qw${BFP}(Exporter);

EOF
    }

    if ($self->is_exported()) {
        $fh->print(<<EOF);
our \%EXPORT_TAGS${AO}=${AO}(
${IND}'all'${AO}=>${AO}[
${IND}${IND}qw${BFP}(),
${IND}],
);

our \@EXPORT_OK${AO}=${AO}(${ACS}\@{${ACS}\$EXPORT_TAGS{'all'}${ACS}}${ACS});

our \@EXPORT${AO}=${AO}qw${BFP}(
);

EOF
    }

    my $version = "our (\$VERSION)${AO}=${AO}'\$";
    $version .= 'Revision: 0.0.0.0';
    $version .= "\$'${AO}=~${AO}/\\\$";
    $version .= 'Revision:\\s+([^\\s]+)/;';
    $fh->print(<<EOF);
${version}

EOF
}

sub write_preloaded_end {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
1;

$END

EOF
}

sub write_value_allowed_method {
    my $self = shift;
    my $fh = shift;

    $fh->print(<<EOF);
$SUB _value_is_allowed${PBOC[0]}{
${IND}my \$name${AO}=${AO}shift;

${IND}# Value is allowed if no ALLOW clauses exist for the named attribute
${IND}if${BCP}(${ACS}!${AO}exists${BFP}(${ACS}\$ALLOW_ISA{\$name}${ACS})${AO}&&${AO}!${AO}exists${BFP}(${ACS}\$ALLOW_REF{\$name}${ACS})${AO}&&${AO}!${AO}exists${BFP}(${ACS}\$ALLOW_RX{\$name}${ACS})${AO}&&${AO}!${AO}exists${BFP}(${ACS}\$ALLOW_VALUE{\$name}${ACS})${ACS})${PBOC[1]}{
${IND}${IND}return${BFP}(1);
${IND}}

${IND}# At this point, all values in \@_ must to be allowed
${IND}CHECK_VALUES:
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}# Check ALLOW_ISA
${IND}${IND}if${BCP}(${ACS}ref${BFP}(\$val)${AO}&&${AO}exists${BFP}(${ACS}\$ALLOW_ISA{\$name}${ACS})${ACS})${PBOC[2]}{
${IND}${IND}${IND}foreach my \$class (${ACS}\@{${ACS}\$ALLOW_ISA{\$name}${ACS}}${ACS})${PBOC[3]}{
${IND}${IND}${IND}${IND}&UNIVERSAL::isa${BFP}(${ACS}\$val,${AC}\$class${ACS})${AO}&&${AO}next CHECK_VALUES;
${IND}${IND}${IND}}
${IND}${IND}}

${IND}${IND}# Check ALLOW_REF
${IND}${IND}if${BCP}(${ACS}ref${BFP}(\$val)${AO}&&${AO}exists${BFP}(${ACS}\$ALLOW_REF{\$name}${ACS})${ACS})${PBOC[2]}{
${IND}${IND}${IND}exists${BFP}(${ACS}\$ALLOW_REF{\$name}{${ACS}ref${BFP}(\$val)${ACS}}${ACS})${AO}&&${AO}next CHECK_VALUES;
${IND}${IND}}

${IND}${IND}# Check ALLOW_RX
${IND}${IND}if${BCP}(${ACS}defined${BFP}(\$val)${AO}&&${AO}!${AO}ref${BFP}(\$val)${AO}&&${AO}exists${BFP}(${ACS}\$ALLOW_RX{\$name}${ACS})${ACS})${PBOC[2]}{
${IND}${IND}${IND}foreach my \$rx (${ACS}\@{${ACS}\$ALLOW_RX{\$name}${ACS}}${ACS})${PBOC[3]}{
${IND}${IND}${IND}${IND}\$val${AO}=~${AO}/\$rx/${AO}&&${AO}next CHECK_VALUES;
${IND}${IND}${IND}}
${IND}${IND}}

${IND}${IND}# Check ALLOW_VALUE
${IND}${IND}if${BCP}(${ACS}!${AO}ref${BFP}(\$val)${AO}&&${AO}exists${BFP}(${ACS}\$ALLOW_VALUE{\$name}${ACS})${ACS})${PBOC[2]}{
${IND}${IND}${IND}exists${BFP}(${ACS}\$ALLOW_VALUE{\$name}{\$val}${ACS})${AO}&&${AO}next CHECK_VALUES;
${IND}${IND}}

${IND}${IND}# We caught a not allowed value
${IND}${IND}return${BFP}(0);
${IND}}

${IND}# OK, all values are allowed
${IND}return${BFP}(1);
}

EOF
}

