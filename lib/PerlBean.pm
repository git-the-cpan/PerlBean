package PerlBean;

use 5.005;
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);
use PerlBean::Dependency::Require;
use PerlBean::Dependency::Use;
use PerlBean::Style qw(:codegen);
use PerlBean::Symbol;

# Variable to not confuse AutoLoader
our $END = '__END__';

# Variable to not confuse AutoLoader
our $PACKAGE = 'package';

# Variable to not confuse AutoLoader
our $SUB = 'sub';

# Used by _value_is_allowed
our %ALLOW_ISA = (
    'attribute' => [ 'PerlBean::Attribute' ],
    'collection' => [ 'PerlBean::Collection' ],
    'dependency' => [ 'PerlBean::Dependency' ],
    'export_tag_description' => [ 'PerlBean::Described::ExportTag' ],
    'method' => [ 'PerlBean::Method' ],
    'symbol' => [ 'PerlBean::Symbol' ],
);

# Used by _value_is_allowed
our %ALLOW_REF = (
);

# Used by _value_is_allowed
our %ALLOW_RX = (
    'abstract' => [ '^.*$' ],
    'base' => [ '^\S+$' ],
    'license' => [ '.*' ],
    'synopsis' => [ '.*' ],
    'use_perl_version' => [ '^v?\d+(\.[\d_]+)*' ],
);

# Used by _value_is_allowed
our %ALLOW_VALUE = (
);

# Used by _value_is_allowed
our %DEFAULT_VALUE = (
    '_has_exports_' => 0,
    'autoloaded' => 1,
    'exception_class' => 'Error::Simple',
    'package' => 'main',
    'short_description' => 'NO DESCRIPTION AVAILABLE',
    'singleton' => 0,
    'use_perl_version' => $],
);

# Package version
our ($VERSION) = '$Revision: 0.7 $' =~ /\$Revision:\s+([^\s]+)/;

# Month names array
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

=item B<C<autoloaded>>

Passed to L<set_autoloaded()>. Defaults to B<1>.

=item B<C<base>>

Passed to L<set_base()>. Must be an C<ARRAY> reference.

=item B<C<collection>>

Passed to L<set_collection()>.

=item B<C<dependency>>

Passed to L<set_dependency()>. Must be an C<ARRAY> reference. Defaults to a set of C<PerlBean::Dependency> objects that yields to:

 use strict;
 use warnings;
 use Error qw(:try);

=item B<C<description>>

Passed to L<set_description()>.

=item B<C<exception_class>>

Passed to L<set_exception_class()>. Defaults to B<'Error::Simple'>.

=item B<C<export_tag_description>>

Passed to L<set_export_tag_description()>. Must be an C<ARRAY> reference.

=item B<C<license>>

Passed to L<set_license()>.

=item B<C<method>>

Passed to L<set_method()>. Must be an C<ARRAY> reference.

=item B<C<package>>

Passed to L<set_package()>. Defaults to B<'main'>.

=item B<C<short_description>>

Passed to L<set_short_description()>. Defaults to B<'NO DESCRIPTION AVAILABLE'>.

=item B<C<singleton>>

Passed to L<set_singleton()>. Defaults to B<0>.

=item B<C<symbol>>

Passed to L<set_symbol()>. Must be an C<ARRAY> reference.

=item B<C<synopsis>>

Passed to L<set_synopsis()>.

=item B<C<use_perl_version>>

Passed to L<set_use_perl_version()>. Defaults to B<$]>.

=back

=back

=head1 METHODS

=over

=item write(FILEHANDLE)

Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

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

=item set_autoloaded(VALUE)

State that the methods in the PerlBean are autoloaded. C<VALUE> is the value. Default value at initialization is C<1>. On error an exception C<Error::Simple> is thrown.

=item is_autoloaded()

Returns whether the methods in the PerlBean are autoloaded or not.

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

=item set_dependency( [ VALUE ... ] )

Set the list of 'PerlBean::Dependency' objects absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<get_dependency_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.
Defaults value at initialization is a set of C<PerlBean::Dependency> objects that yields to:

 use strict;
 use warnings;
 use Error qw(:try);

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Dependency

=back

=back

=item add_dependency( [ VALUE ... ] )

Add additional values on the list of 'PerlBean::Dependency' objects. Each C<VALUE> is an object out of which the id is obtained through method C<get_dependency_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Dependency

=back

=back

=item delete_dependency(ARRAY)

Delete elements from the list of 'PerlBean::Dependency' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_dependency(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of 'PerlBean::Dependency' objects.

=item keys_dependency()

Returns an C<ARRAY> containing the keys of the list of 'PerlBean::Dependency' objects.

=item values_dependency( [ KEY_ARRAY ] )

Returns an C<ARRAY> containing the values of the list of 'PerlBean::Dependency' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

=item set_description(VALUE)

Set the PerlBean description. C<VALUE> is the value. On error an exception C<Error::Simple> is thrown.

=item get_description()

Returns the PerlBean description.

=item set_exception_class(VALUE)

Set class to throw when exception occurs. C<VALUE> is the value. Default value at initialization is C<'Error::Simple'>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=item get_exception_class()

Returns class to throw when exception occurs.

=item set_export_tag_description( [ VALUE ... ] )

Set the list of 'PerlBean::Described::ExportTag' objects absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<get_export_tag_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Described::ExportTag

=back

=back

=item add_export_tag_description( [ VALUE ... ] )

Add additional values on the list of 'PerlBean::Described::ExportTag' objects. Each C<VALUE> is an object out of which the id is obtained through method C<get_export_tag_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Described::ExportTag

=back

=back

=item delete_export_tag_description(ARRAY)

Delete elements from the list of 'PerlBean::Described::ExportTag' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_export_tag_description(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of 'PerlBean::Described::ExportTag' objects.

=item keys_export_tag_description()

Returns an C<ARRAY> containing the keys of the list of 'PerlBean::Described::ExportTag' objects.

=item values_export_tag_description( [ KEY_ARRAY ] )

Returns an C<ARRAY> containing the values of the list of 'PerlBean::Described::ExportTag' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

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

=item set_singleton(VALUE)

State that the package is a singleton and an C<instance()> method is implemented. C<VALUE> is the value. Default value at initialization is C<0>. On error an exception C<Error::Simple> is thrown.

=item is_singleton()

Returns whether the package is a singleton and an C<instance()> method is implemented or not.

=item set_symbol( [ VALUE ... ] )

Set the list of 'PerlBean::Symbol' objects absolutely using values. Each C<VALUE> is an object out of which the id is obtained through method C<get_symbol_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Symbol

=back

=back

=item add_symbol( [ VALUE ... ] )

Add additional values on the list of 'PerlBean::Symbol' objects. Each C<VALUE> is an object out of which the id is obtained through method C<get_symbol_name()>. The obtained B<key> is used to store the value and may be used for deletion and to fetch the value. 0 or more values may be supplied. Multiple occurences of the same key yield in the last occuring key to be inserted and the rest to be ignored. Each key of the specified values is allowed to occur only once. On error an exception C<Error::Simple> is thrown.

=over

=item The values in C<ARRAY> must be a (sub)class of:

=over

=item PerlBean::Symbol

=back

=back

=item delete_symbol(ARRAY)

Delete elements from the list of 'PerlBean::Symbol' objects. Returns the number of deleted elements. On error an exception C<Error::Simple> is thrown.

=item exists_symbol(ARRAY)

Returns the count of items in C<ARRAY> that are in the list of 'PerlBean::Symbol' objects.

=item keys_symbol()

Returns an C<ARRAY> containing the keys of the list of 'PerlBean::Symbol' objects.

=item values_symbol( [ KEY_ARRAY ] )

Returns an C<ARRAY> containing the values of the list of 'PerlBean::Symbol' objects. If C<KEY_ARRAY> contains one or more C<KEY>s the values related to the C<KEY>s are returned. If no C<KEY>s specified all values are returned.

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

=item set_use_perl_version(VALUE)

Set the Perl version to use. C<VALUE> is the value. Default value at initialization is C<'$]'>. C<VALUE> may not be C<undef>. On error an exception C<Error::Simple> is thrown.

=over

=item VALUE must match regular expression:

=over

=item ^v?\d+(\.[\d_]+)*

=back

=back

=item get_use_perl_version()

Returns the Perl version to use.

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
    ref($opt) eq 'HASH' || throw Error::Simple("ERROR: PerlBean::_initialize, first argument must be 'HASH' reference.");

    # _export_tag_, MULTI
    if ( exists( $opt->{_export_tag_} ) ) {
        ref( $opt->{_export_tag_} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option '_export_tag_' must be an 'ARRAY' reference.");
        $self->set__export_tag_( @{ $opt->{_export_tag_} } );
    }
    else {
        $self->set__export_tag_();
    }

    # _has_exports_, BOOLEAN, with default value
    $self->set__has_exports_( exists( $opt->{_has_exports_} ) ? $opt->{_has_exports_} : $DEFAULT_VALUE{_has_exports_} );

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

    # autoloaded, BOOLEAN, with default value
    $self->set_autoloaded( exists( $opt->{autoloaded} ) ? $opt->{autoloaded} : $DEFAULT_VALUE{autoloaded} );

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

    # dependency, MULTI, with default value
    if ( exists( $opt->{dependency} ) ) {
        ref( $opt->{dependency} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'dependency' must be an 'ARRAY' reference.");
        $self->set_dependency( @{ $opt->{dependency} } );
    }
    else {

        # Empty the dependency list
        $self->set_dependency();

        # Add 'use strict'
        $self->add_dependency( PerlBean::Dependency::Use->new( {
            dependency_name => 'strict',
        } ) );

        # Add 'use warnings'
        $self->add_dependency( PerlBean::Dependency::Use->new( {
            dependency_name => 'warnings',
        } ) );

        # Add 'use Error qw(:try)'
        $self->add_dependency( PerlBean::Dependency::Use->new( {
            dependency_name => 'Error',
            import_list => [ 'qw(:try)' ],
        } ) );

    }

    # description, SINGLE
    exists( $opt->{description} ) && $self->set_description( $opt->{description} );

    # exception_class, SINGLE, with default value
    $self->set_exception_class( exists( $opt->{exception_class} ) ? $opt->{exception_class} : $DEFAULT_VALUE{exception_class} );

    # export_tag_description, MULTI
    if ( exists( $opt->{export_tag_description} ) ) {
        ref( $opt->{export_tag_description} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'export_tag_description' must be an 'ARRAY' reference.");
        $self->set_export_tag_description( @{ $opt->{export_tag_description} } );
    }
    else {
        $self->set_export_tag_description();
    }

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

    # singleton, BOOLEAN, with default value
    $self->set_singleton( exists( $opt->{singleton} ) ? $opt->{singleton} : $DEFAULT_VALUE{singleton} );

    # symbol, MULTI
    if ( exists( $opt->{symbol} ) ) {
        ref( $opt->{symbol} ) eq 'ARRAY' || throw Error::Simple("ERROR: PerlBean::_initialize, specified value for option 'symbol' must be an 'ARRAY' reference.");
        $self->set_symbol( @{ $opt->{symbol} } );
    }
    else {
        $self->set_symbol();
    }

    # synopsis, SINGLE
    exists( $opt->{synopsis} ) && $self->set_synopsis( $opt->{synopsis} );

    # use_perl_version, SINGLE, with default value
    $self->set_use_perl_version( exists( $opt->{use_perl_version} ) ? $opt->{use_perl_version} : $DEFAULT_VALUE{use_perl_version} );

    # Return $self
    return($self);
}

sub write {
    my $self = shift;
    my $fh = shift;

    # Finalize the package
    $self->finalize();

    # Package heading
    $self->write_package_head($fh);

    # Dependencies
    $self->write_dependencies($fh);

    # Declared symbols
    $self->write_declared_symbols($fh);

    # End of preloaded methods
    $self->write_preloaded_end($fh);

    # Start pod documentation
    $self->write_doc_head($fh);

    # Write EXPORT documentation
    $self->write_doc_export($fh);

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
    $self->write_value_allowed_method($fh);

    # End of file
    $self->write_file_end($fh);
}

sub set__export_tag_ {
    my $self = shift;

    # Separate keys/values
    my @key = ();
    my @value = ();
    while ( my $key = shift(@_) ) {
        push( @key, $key );
        push( @value, shift(@_) );
    }

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( '_export_tag_', @value ) || throw Error::Simple("ERROR: PerlBean::set__export_tag_, one or more specified value(s) '@value' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{_export_tag_} = {};

    # Add keys/values
    foreach my $key (@key) {
        $self->{PerlBean}{_export_tag_}{$key} = shift(@value);
    }
}

sub add__export_tag_ {
    my $self = shift;

    # Separate keys/values
    my @key = ();
    my @value = ();
    while ( my $key = shift(@_) ) {
        push( @key, $key );
        push( @value, shift(@_) );
    }

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( '_export_tag_', @value ) || throw Error::Simple("ERROR: PerlBean::add__export_tag_, one or more specified value(s) '@value' is/are not allowed.");

    # Add keys/values
    foreach my $key (@key) {
        $self->{PerlBean}{_export_tag_}{$key} = shift(@value);
    }
}

sub delete__export_tag_ {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{_export_tag_}{$val} ) || next;
        delete( $self->{PerlBean}{_export_tag_}{$val} );
        $del ++;
    }
    return($del);
}

sub exists__export_tag_ {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{_export_tag_}{$val} );
    }
    return($count);
}

sub keys__export_tag_ {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{_export_tag_} } ) );
}

sub values__export_tag_ {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{_export_tag_}{$key} ) && push( @ret, $self->{PerlBean}{_export_tag_}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{_export_tag_} } ) );
    }
}

sub set__has_exports_ {
    my $self = shift;

    if (shift) {
        $self->{PerlBean}{_has_exports_} = 1;
    }
    else {
        $self->{PerlBean}{_has_exports_} = 0;
    }
}

sub is__has_exports_ {
    my $self = shift;

    if ( $self->{PerlBean}{_has_exports_} ) {
        return(1);
    }
    else {
        return(0);
    }
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

sub set_autoloaded {
    my $self = shift;

    if (shift) {
        $self->{PerlBean}{autoloaded} = 1;
    }
    else {
        $self->{PerlBean}{autoloaded} = 0;
    }
}

sub is_autoloaded {
    my $self = shift;

    if ( $self->{PerlBean}{autoloaded} ) {
        return(1);
    }
    else {
        return(0);
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

sub set_dependency {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'dependency', @_ ) || throw Error::Simple("ERROR: PerlBean::set_dependency, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{dependency} = {};

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{dependency}{ $val->get_dependency_name() } = $val;
    }
}

sub add_dependency {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'dependency', @_ ) || throw Error::Simple("ERROR: PerlBean::add_dependency, one or more specified value(s) '@_' is/are not allowed.");

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{dependency}{ $val->get_dependency_name() } = $val;
    }
}

sub delete_dependency {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{dependency}{$val} ) || next;
        delete( $self->{PerlBean}{dependency}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_dependency {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{dependency}{$val} );
    }
    return($count);
}

sub keys_dependency {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{dependency} } ) );
}

sub values_dependency {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{dependency}{$key} ) && push( @ret, $self->{PerlBean}{dependency}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{dependency} } ) );
    }
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

sub set_export_tag_description {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'export_tag_description', @_ ) || throw Error::Simple("ERROR: PerlBean::set_export_tag_description, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{export_tag_description} = {};

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{export_tag_description}{ $val->get_export_tag_name() } = $val;
    }
}

sub add_export_tag_description {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'export_tag_description', @_ ) || throw Error::Simple("ERROR: PerlBean::add_export_tag_description, one or more specified value(s) '@_' is/are not allowed.");

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{export_tag_description}{ $val->get_export_tag_name() } = $val;
    }
}

sub delete_export_tag_description {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{export_tag_description}{$val} ) || next;
        delete( $self->{PerlBean}{export_tag_description}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_export_tag_description {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{export_tag_description}{$val} );
    }
    return($count);
}

sub keys_export_tag_description {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{export_tag_description} } ) );
}

sub values_export_tag_description {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{export_tag_description}{$key} ) && push( @ret, $self->{PerlBean}{export_tag_description}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{export_tag_description} } ) );
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

sub set_singleton {
    my $self = shift;

    if (shift) {
        $self->{PerlBean}{singleton} = 1;
    }
    else {
        $self->{PerlBean}{singleton} = 0;
    }
}

sub is_singleton {
    my $self = shift;

    if ( $self->{PerlBean}{singleton} ) {
        return(1);
    }
    else {
        return(0);
    }
}

sub set_symbol {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'symbol', @_ ) || throw Error::Simple("ERROR: PerlBean::set_symbol, one or more specified value(s) '@_' is/are not allowed.");

    # Empty list
    $self->{PerlBean}{symbol} = {};

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{symbol}{ $val->get_symbol_name() } = $val;
    }
}

sub add_symbol {
    my $self = shift;

    # Check if isas/refs/rxs/values are allowed
    &_value_is_allowed( 'symbol', @_ ) || throw Error::Simple("ERROR: PerlBean::add_symbol, one or more specified value(s) '@_' is/are not allowed.");

    # Add keys/values
    foreach my $val (@_) {
        $self->{PerlBean}{symbol}{ $val->get_symbol_name() } = $val;
    }
}

sub delete_symbol {
    my $self = shift;

    # Delete values
    my $del = 0;
    foreach my $val (@_) {
        exists( $self->{PerlBean}{symbol}{$val} ) || next;
        delete( $self->{PerlBean}{symbol}{$val} );
        $del ++;
    }
    return($del);
}

sub exists_symbol {
    my $self = shift;

    # Count occurences
    my $count = 0;
    foreach my $val (@_) {
        $count += exists( $self->{PerlBean}{symbol}{$val} );
    }
    return($count);
}

sub keys_symbol {
    my $self = shift;

    # Return all keys
    return( keys( %{ $self->{PerlBean}{symbol} } ) );
}

sub values_symbol {
    my $self = shift;

    if ( scalar(@_) ) {
        my @ret = ();
        foreach my $key (@_) {
            exists( $self->{PerlBean}{symbol}{$key} ) && push( @ret, $self->{PerlBean}{symbol}{$key} );
        }
        return(@ret);
    }
    else {
        # Return all values
        return( values( %{ $self->{PerlBean}{symbol} } ) );
    }
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

sub set_use_perl_version {
    my $self = shift;
    my $val = shift;

    # Value for 'use_perl_version' is not allowed to be empty
    defined($val) || throw Error::Simple("ERROR: PerlBean::set_use_perl_version, value may not be empty.");

    # Check if isa/ref/rx/value is allowed
    &_value_is_allowed( 'use_perl_version', $val ) || throw Error::Simple("ERROR: PerlBean::set_use_perl_version, the specified value '$val' is not allowed.");

    # Assignment
    $self->{PerlBean}{use_perl_version} = $val;
}

sub get_use_perl_version {
    my $self = shift;

    return( $self->{PerlBean}{use_perl_version} );
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

sub finalize {
    my $self = shift;

    # Check if exporter is needed
    $self->mk_has_exports_();

    # Finalize singleton
    $self->finalize_singleton();

    # Finalize autoload
    $self->finalize_autoload();

    # Finalize allowed
    $self->finalize_allowed();

    # Finalize 'use base'
    $self->finalize_use_base();

    # Finalize exports
    $self->finalize_exports();

    # Finalize version
    $self->finalize_version();
}

sub finalize_allowed {
    my $self = shift;

    # Delete the allow symbols
    $self->delete_symbol( qw( %ALLOW_ISA %ALLOW_REF %ALLOW_RX %ALLOW_VALUE
                                                            %DEFAULT_VALUE ) );

    # Finish if no attributes
    $self->keys_attribute() || return;

    # %ALLOW_ISA symbol
    my $aia = "(\n";
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ($self->values_attribute($name))[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $aia .= $attribute->write_allow_isa();
    }
    $aia .= ");\n";
    my $ai = PerlBean::Symbol->new( {
        symbol_name => '%ALLOW_ISA',
        assignment => $aia,
        comment => "# Used by _value_is_allowed\n",
    } );
    $self->add_symbol($ai);

    # %ALLOW_REF symbol
    my $ara = "(\n";
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $ara .= $attribute->write_allow_ref();
    }
    $ara .= ");\n";
    my $ar = PerlBean::Symbol->new( {
        symbol_name => '%ALLOW_REF',
        assignment => $ara,
        comment => "# Used by _value_is_allowed\n",
    } );
    $self->add_symbol($ar);

    # %ALLOW_RX symbol
    my $arxa = "(\n";
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $arxa .= $attribute->write_allow_rx();
    }
    $arxa .= ");\n";
    my $arx = PerlBean::Symbol->new( {
        symbol_name => '%ALLOW_RX',
        assignment => $arxa,
        comment => "# Used by _value_is_allowed\n",
    } );
    $self->add_symbol($arx);

    # %ALLOW_VALUE symbol
    my $ava = "(\n";
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        next if ( $attribute->isa('PerlBean::Attribute::Boolean') );
        $ava .= $attribute->write_allow_value();
    }
    $ava .= ");\n";
    my $av = PerlBean::Symbol->new( {
        symbol_name => '%ALLOW_VALUE',
        assignment => $ava,
        comment => "# Used by _value_is_allowed\n",
    } );
    $self->add_symbol($av);

    # %DEFAULT_VALUE symbol
    my $dva = "(\n";
    foreach my $name ( sort( $self->keys_attribute() ) ) {
        my $attribute = ( $self->values_attribute($name) )[0];
        $dva .= $attribute->write_default_value();
    }
    $dva .= ");\n";
    my $dv = PerlBean::Symbol->new( {
        symbol_name => '%DEFAULT_VALUE',
        assignment => $dva,
        comment => "# Used by _value_is_allowed\n",
    } );
    $self->add_symbol($dv);
}

sub finalize_version {
    my $self = shift;

    # Make the $VERSION symbol if not already made
    if ( ! $self->exists_symbol('$VERSION') &&
            ! $self->exists_symbol('($VERSION)') ) {

        # make the version assignement
        my $va = '\'$';
        $va .= 'Revision: 0.0.0.0';
        $va .= "\$'${AO}=~${AO}/\\\$";
        $va .= 'Revision:\\s+([^\\s]+)/;';
        $va .= "\n";

        # Add the ($VERSION) symbol
        my $v = PerlBean::Symbol->new( {
            symbol_name => '($VERSION)',
            assignment => $va,
            comment => "# Package version\n",
        } );
        $self->add_symbol($v);
    }
}

sub finalize_autoload {
    my $self = shift;

    $self->delete_dependency('AutoLoader');

    $self->is_autoloaded() || return;

    if ( ! $self->exists_dependency('AutoLoader') ) {
        # use AutoLoader qw(AUTOLOAD);
        my $a = PerlBean::Dependency::Use->new( {
            dependency_name => 'AutoLoader',
            import_list => [ 'qw(AUTOLOAD)' ],
        } );
        $self->add_dependency($a);
    }
}

sub finalize_exports {
    my $self = shift;

    $self->is__has_exports_() || return;

    # require Exporter
    my $dep = PerlBean::Dependency::Require->new( {
        dependency_name => 'Exporter',
    } );
    $self->add_dependency($dep);

    # Delete the export symbols
    $self->delete_symbol( qw( %EXPORT_TAGS @EXPORT_OK @EXPORT ) );

    # Get all export tags
    #my %TAG = ();
    $self->set__export_tag_();
    foreach my $sym ( $self->values_symbol() ) {
        foreach my $tag ( $sym->values_export_tag() ) {
            #$TAG{$tag} ||= [];
            #push( @{ $TAG{$tag} }, $sym );
            $self->exists__export_tag_($tag) ||
                                            $self->add__export_tag_($tag, []);
            push( @{ ( $self->values__export_tag_($tag) )[0] }, $sym );
        }
    }

    # The %EXPORT_TAGS assignement head
    my $ETA = "(\n";

    # Fill $ETA
    foreach my $tag ( sort( $self->keys__export_tag_() ) ) {

        # The %EXPORT_TAGS assignement head for this tag
        $ETA .= "${IND}'$tag' => [ qw(\n";

        # Fill out the lines alphabetically
        foreach my $name ( sort( $self->keys_symbol() ) ) {

             # Get the symbol
             my $sym = ( $self->values_symbol($name) )[0];

             # Skip if not in tag
             $sym->exists_export_tag($tag) || next;

             # Add the line
             $ETA .= "${IND}${IND}$name\n";
        }

        # The %EXPORT_TAGS assignement tail for this tag
        $ETA .= "${IND}) ],\n";
    }

    # The %EXPORT_TAGS assignement tail
    $ETA .= ");\n";

    # The @EXPORT_OK assignement head
    my $EOA = "qw(\n";

    # The @EXPORT assignement head
    my $EA = "qw(\n";

    # Fill $EOA and $EA
    foreach my $name ( sort( $self->keys_symbol() ) ) {
         # Get the symbol
         my $sym = ( $self->values_symbol($name) )[0];

         # Next if no tag
         $sym->values_export_tag() || next;

         # Add the line to $EOA
         $EOA .= "${IND}$name\n";

         # Next if no default tag
         $sym->exists_export_tag('default') || next;

         # Add the line to $EA
         $EA .= "${IND}$name\n";

    }

    # The @EXPORT_OK assignement tail
    $EOA .= ");\n";

    # The @EXPORT assignement tail
    $EA .= ");\n";

    # Make and add the symbols %EXPORT_TAGS
    my $et = PerlBean::Symbol->new( {
        symbol_name => '%EXPORT_TAGS',
        assignment => $ETA,
        comment => "# Exporter variable\n",
    } );
    $self->add_symbol($et);

    # Make and add the symbols @EXPORT_OK
    my $eo = PerlBean::Symbol->new( {
        symbol_name => '@EXPORT_OK',
        assignment => $EOA,
        comment => "# Exporter variable\n",
    } );
    $self->add_symbol($eo);

    # Make and add the symbols @EXPORT
    my $e = PerlBean::Symbol->new( {
        symbol_name => '@EXPORT',
        assignment => $EA,
        comment => "# Exporter variable\n",
    } );
    $self->add_symbol($e);
}

sub finalize_singleton {
    my $self = shift;

    $self->is_singleton() || return;

    # Symbol
    if ( ! $self->exists_symbol('$SINGLETON') ) {

        # Make the $SINGLETON symbol
        my $s = PerlBean::Symbol->new( {
            symbol_name => '$SINGLETON',
            assignment => "undef;\n",
            comment => "# Singleton variable\n",
        } );
        $self->add_symbol($s);
    }

    # Method
    if ( ! $self->exists_method('instance') ) {

        # Package name
        my $pkg = $self->get_package();

        # Make the instance() method
        my $i = PerlBean::Method->new( {
            method_name => 'instance',
            parameter_description => ' [ CONSTR_OPT ] ',
            description => <<EOF,
Always returns the same C<${pkg}> -singleton- object instance. The first time it is called, parameters C<CONSTR_OPT> -if specified- are passed to the constructor.
EOF
                body => <<EOF,
${IND}# Allow calls like:
${IND}# - ${pkg}::instance()
${IND}# - ${pkg}->instance()
${IND}# - \$variable->instance()
${IND}if${BCP}(${ACS}ref${BFP}(\$_[0])${AO}&&${AO}&UNIVERSAL::isa(${ACS}\$_[0], '${pkg}'${ACS})${ACS}) {
${IND}${IND}shift;
${IND}}${PBCC[1]}elsif${BCP}(${ACS}!${AO}ref${BFP}(\$_[0])${AO}&&${AO}\$_[0]${AO}eq${AO}'${pkg}'${ACS})${PBOC[1]}{
${IND}${IND}shift;
${IND}}

${IND}# If \$SINGLETON is defined return it
${IND}defined${BFP}(\$SINGLETON) && return${BFP}(\$SINGLETON);

${IND}# Create the object and set \$SINGLETON
${IND}\$SINGLETON${AO}=${AO}${pkg}->new${BFP}();

${IND}# Initialize the object separately as the initialization might
${IND}# depend on \$SINGLETON being set.
${IND}\$SINGLETON->_initialize${BFP}(\@_);

${IND}# Return \$SINGLETON
${IND}return${BFP}(\$SINGLETON);
EOF
        } );
        $self->add_method($i);
    }
}

sub finalize_use_base {
    my $self = shift;

    my @base = $self->get_base();
    $self->is__has_exports_() && push( @base, 'Exporter' );
    if ( scalar(@base) ) {
        my $dep = PerlBean::Dependency::Use->new( {
            dependency_name => 'base',
            import_list => [ "qw( @base )" ],
        } );
        $self->add_dependency($dep);
    }
}

sub mk_has_exports_ {
    my $self = shift;

    # Check all symbols
    foreach my $sym ( $self->values_symbol() ) {

        # But discard the export symbols
        if ( $sym->get_symbol_name() eq '%EXPORT_TAGS' ||
                $sym->get_symbol_name() eq '@EXPORT_OK' ||
                $sym->get_symbol_name() eq '@EXPORT' ) {
            next;
        }

        # Check if the symbol is exported
        if ( scalar( $sym->values_export_tag() ) ) {
            $self->set__has_exports_(1);
            return;
        }
    }

    # Nothing found to export
    $self->set__has_exports_(0);
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

sub write_declared_symbols {
    my $self = shift;
    my $fh = shift;

    foreach my $name ( sort( $self->keys_symbol() ) ) {
        my $symbol = ( $self->values_symbol($name) )[0];

        $symbol->write($fh);
    }
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

sub write_file_end {
    my $self = shift;
    my $fh = shift;

    # Close the file with a '1;' only if not autoloaded
    $self->is_autoloaded() && return;

    $fh->print("1;\n");
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

sub write_doc_export {
    my $self = shift;
    my $fh = shift;

    # Stop if no exports
    $self->is__has_exports_() || return;

    $fh->print( "=head1 EXPORT\n\n" );

    if ( ! $self->exists_export_tag_description('default') ) {
        $fh->print( "By default nothing is exported.\n\n" );
    }

    foreach my $tag ( sort( $self->keys__export_tag_() ) ) {

        $fh->print( "=head2 $tag\n\n" );

        if ( $self->exists_export_tag_description($tag) ) {
            my $tdesc = ( $self->values_export_tag_description($tag) )[0];
            $fh->print( $tdesc->get_description(), "\n" );
        } else {
            $fh->print( "TODO\n\n" );
        }

        $fh->print( "=over\n\n" );

        foreach my $name ( sort( $self->keys_symbol() ) ) {

             # Get the symbol
             my $sym = ( $self->values_symbol($name) )[0];

             # Skip if not in tag
             $sym->exists_export_tag($tag) || next;

             # Add the lines
             $fh->print( "=item $name\n\n" );

             $fh->print( $sym->get_description(), "\n" );
        }

        $fh->print( "=back\n\n" );
    }
}

sub write_doc_head {
    my $self = shift;
    my $fh = shift;

    my $pkg = $self->get_package();
    my $sdesc = $self->get_short_description();

    my $desc = defined($self->get_description()) ?
                            $self->get_description() : "C<$pkg> TODO\n";

    my $syn = defined($self->get_synopsis()) ?
                            $self->get_synopsis() : " TODO\n";

    my $abs = defined($self->get_abstract()) ?
                            $self->get_abstract() : 'TODO';

    $fh->print( "=head1 NAME\n\n" );
    $fh->print( "${pkg} - ${sdesc}\n\n" );

    $fh->print( "=head1 SYNOPSIS\n\n" );
    $fh->print( "${syn}\n" );

    $fh->print( "=head1 ABSTRACT\n\n" );
    $fh->print( "${abs}\n\n" );

    $fh->print( "=head1 DESCRIPTION\n\n" );
    $fh->print( "${desc}\n" );
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

    if ( scalar( $self->values_attribute() ) || scalar( $self->keys_method() )) {
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

sub write_dependencies {
    my $self = shift;
    my $fh = shift;

    # Perl version
    my $pv = $self->get_use_perl_version();
    $fh->print("use $pv;\n");

    # Write PerlBean::Dependency::Use
    foreach my $dependency_name ( sort {&by_pragma}
                                            ( $self->keys_dependency() ) ) {
        my $dep = ( $self->values_dependency($dependency_name) )[0];

        $dep->isa('PerlBean::Dependency::Use') || next;

        $dep->write($fh);
    }

    # Write PerlBean::Dependency::Require
    foreach my $dependency_name ( sort {&by_pragma}
                                            ( $self->keys_dependency() ) ) {
        my $dep = ( $self->values_dependency($dependency_name) )[0];

        $dep->isa('PerlBean::Dependency::Require') || next;

        $dep->write($fh);
    }

    # Write PerlBean::Dependency::Import
    foreach my $dependency_name ( sort {&by_pragma}
                                            ( $self->keys_dependency() ) ) {
        my $dep = ( $self->values_dependency($dependency_name) )[0];

        $dep->isa('PerlBean::Dependency::Import') || next;

        $dep->write($fh);
    }

    $fh->print("\n");
}

sub write_package_head {
    my $self = shift;
    my $fh = shift;

    my $pkg = $self->get_package();
    $fh->print("$PACKAGE $pkg;\n\n");
}


sub fooooooo {
    # base
    if (scalar($self->get_base())) {
        my @base = $self->get_base();
        $fh->print(<<EOF);
use base qw${BFP}(@base);

EOF
    }
    elsif ( 0 ) {
        $fh->print(<<EOF);
our \@ISA${AO}=${AO}qw${BFP}(Exporter);

EOF
    }

    if ( 0 ) {
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
}

sub by_pragma {
    if ($a =~ /^[a-z]/ && $b !~ /^[a-z]/ ) {
        return(-1);
    }
    elsif ($a !~ /^[a-z]/ && $b =~ /^[a-z]/ ) {
        return(1);
    }
    else {
        return($a cmp $b );
    }
}

sub write_preloaded_end {
    my $self = shift;
    my $fh = shift;

    # End preload only for non autoloaded beans
    $self->is_autoloaded() || return;

    $fh->print(<<EOF);
1;

$END

EOF
}

sub write_value_allowed_method {
    my $self = shift;
    my $fh = shift;

    scalar( $self->values_attribute() ) || return;

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

