package PerlBean::Attribute::Multi::Unique;

use 5.005;
use strict;
use warnings;
use Error qw(:try);
use AutoLoader qw(AUTOLOAD);
use PerlBean::Style qw(:codegen);

use base qw(PerlBean::Attribute::Multi);

our ($VERSION) = '$Revision: 0.6 $' =~ /\$Revision:\s+([^\s]+)/;

our $SUB = 'sub';

1;

__END__

=head1 NAME

PerlBean::Attribute::Multi::Unique - contains unique MULTI bean attribute information

=head1 SYNOPSIS

 use strict;
 use PerlBean::Attribute::Multi::Unique;
 my $attr = PerlBean::Attribute::Multi::Unique->new( {
     attribute_name => 'ssns_i_can_remember',
     short_description => 'all SSNs I can remember',
 } );
 
 use IO::File;
 -d 'tmp' || mkdir('tmp');
 my $fh = IO::File->new('> tmp/PerlBean_Attribute_Multi_Unique.pl.out');
 $attr->write_methods($fh);
 $attr->write_doc_methods($fh);

=head1 ABSTRACT

Unique MULTI bean attribute information

=head1 DESCRIPTION

C<PerlBean::Attribute::Multi::Unique> contains unique MULTI bean attribute information. It is a subclass of C<PerlBean::Attribute::Multi>. The code generation and documentation methods from C<PerlBean::Attribute> are implemented.

=head1 CONSTRUCTOR

=over

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Attribute::Multi::Unique> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

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

=item write_allow_isa(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_ISA> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_allow_ref(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_REF> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_allow_rx(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_RX> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_allow_value(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Single'>. Writes C<%ALLOW_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_default_value(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_clauses(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute'>. Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_inherit_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute::Multi'>. Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...> and B<values...>.

=item write_doc_init(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

=item write_doc_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute::Multi'>. Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...> and B<values...>.

=item write_methods(FILEHANDLE)

This method is an implementation from package C<'PerlBean::Attribute::Multi'>. Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object. Access methods are B<set...>, B<add...>, B<delete...>, B<exists...> and B<values...>.

=item write_opt_init(FILEHANDLE)

This method is inherited from package C<'PerlBean::Attribute::Multi'>. Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.

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
L<PerlBean::Attribute::Multi>,
L<PerlBean::Attribute::Multi::Ordered>,
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

sub write_doc_inherit_methods {
    my $self = shift;
    my $fh = shift;

    my $mb = $self->get_method_base();

    my @meth = ();
    foreach my $lop ( qw(set add delete exists values) ) {
        my $op = &{$MOF}($lop);
        push( @meth, "$op$mb${BFP}()" );
    }
    my $meth = join( ', ', @meth );

    $fh->print(<<EOF);
$meth

EOF
}

sub write_doc_methods {
    my $self = shift;
    my $fh = shift;

    $self->write_set_doc($fh);
    $self->write_add_doc($fh);
    $self->write_delete_doc($fh);
    $self->write_exists_doc($fh);
    $self->write_values_doc($fh);
}

sub write_methods {
    my $self = shift;
    my $fh = shift;

    $self->write_set_method($fh);
    $self->write_add_method($fh);
    $self->write_delete_method($fh);
    $self->write_exists_method($fh);
    $self->write_values_method($fh);
}

sub write_set_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $an_esc = $self->esc_apos($an);
    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_package();
    my $pkg_us = $self->get_package_us();

    # Method head
    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

EOF

    # Check if list value is allowed to be empty
    if ( ! $self->is_allow_empty() ) {
        $fh->print(<<EOF);
${IND}# List value for $an_esc is not allowed to be empty
${IND}scalar${BFP}(\@_)${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::set$mb, list value may not be empty.");

EOF
    }

    # Check if isas/refs/rxs/values are allowed
    $fh->print(<<EOF);
${IND}# Check if isas/refs/rxs/values are allowed
${IND}\&_value_is_allowed${BFP}(${ACS}$an_esc,${AC}\@_${ACS})${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::set$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

    # Method tail
    $fh->print(<<EOF);
${IND}# Empty list
${IND}\$self->{$pkg_us}{$an}${AO}=${AO}{};

${IND}# Add values
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}\$self->{$pkg_us}{$an}{\$val}${AO}=${AO}\$val;
${IND}}
}

EOF
}

sub write_set_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('set');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';
    my $def = defined( $self->get_default_value() ) ? ' Default value at initialization is C<' . join( ', ', $self->esc_aq ( @{ $self->get_default_value() } ) ) . '>.' : '';
    my $empt = $self->is_allow_empty() ? '' : ' C<ARRAY> must at least have one element.';
    my $exc = ' On error an exception C<' . $self->get_exception_class() . '> is thrown.';
    my $attr_overl = $self->get_overloaded_attribute();
    my $overl = defined($attr_overl) ? " B<NOTE:> Methods B<C<*$mb ()>> are overloaded from package C<". $attr_overl->get_package() .'>.': '';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(ARRAY)

Set ${desc} absolutely. C<ARRAY> is the list value. Each element in the list is allowed to occur only once. Multiple occurences of the same element yield in the last occuring element to be inserted and the rest to be ignored.${def}${empt}${exc}${overl}

EOF

    $self->write_doc_clauses($fh);
}

sub write_add_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $an_esc = $self->esc_apos($an);
    my $op = &{$MOF}('add');
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_package();
    my $pkg_us = $self->get_package_us();

    # Method head
    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

EOF

    # Check if isas/refs/rxs/values are allowed
    $fh->print(<<EOF);
${IND}# Check if isas/refs/rxs/values are allowed
${IND}\&_value_is_allowed${BFP}(${ACS}$an_esc,${AC}\@_${ACS})${AO}||${AO}throw $ec${BFP}("ERROR: ${pkg}::add$mb, one or more specified value(s) '\@_' is/are not allowed.");

EOF

    # Method tail
    $fh->print(<<EOF);
${IND}# Add values
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}\$self->{$pkg_us}{$an}{\$val}${AO}=${AO}\$val;
${IND}}
}

EOF
}

sub write_add_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('add');
    my $mb = $self->get_method_base();
    my $desc = defined($self->get_short_description()) ? $self->get_short_description() : 'not described option';
    my $exc = ' On error an exception C<' . $self->get_exception_class() . '> is thrown.';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(ARRAY)

Add additional values on ${desc}. C<ARRAY> is the list value. The addition may not yield to multiple identical elements in the list. Hence, multiple occurences of the same element cause the last occurence to be inserted.${exc}

EOF

    $self->write_doc_clauses($fh);
}

sub write_delete_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $an_esc = $self->esc_apos($an);
    my $op = &{$MOF}('delete');
    my $mb = $self->get_method_base();
    my $ec = $self->get_exception_class();
    my $pkg = $self->get_package();
    my $pkg_us = $self->get_package_us();

    # Method head
    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

EOF

    # Check if list value is allowed to be empty
    if ( ! $self->is_allow_empty() ) {
        $fh->print(<<EOF);
${IND}# List value for $an_esc is not allowed to be empty
${IND}my \%would_delete${AO}=${AO}();
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}\$would_delete{\$val}${AO}=${AO}\$val if${BCP}(${ACS}exists${BFP}(${ACS}\$self->{$pkg_us}{$an}{\$val}${ACS})${ACS});
${IND}}
${IND}(${ACS}scalar${BFP}(${ACS}keys${BFP}(${ACS}\%{${ACS}\$self->{$pkg_us}{$an}${ACS}}${ACS})${ACS})${AO}==${AO}scalar(${ACS}keys${BFP}(\%would_delete)${ACS})${ACS})${AO}&&${AO}throw $ec${BFP}("ERROR: ${pkg}::delete$mb, list value may not be empty.");

EOF
    }

    # Method tail
    $fh->print(<<EOF);
${IND}# Delete values
${IND}my \$del${AO}=${AO}0;
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}exists${BFP}(${ACS}\$self->{$pkg_us}{$an}{\$val}${ACS})${AO}||${AO}next;
${IND}${IND}delete${BFP}(${ACS}\$self->{$pkg_us}{$an}{\$val}${ACS});
${IND}${IND}\$del${AO}++;
${IND}}
${IND}return${BFP}(\$del);
}

EOF
}

sub write_delete_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('delete');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';
    my $empt = $self->is_allow_empty() ? '' : ' After deleting at least one element must remain.';
    my $exc = ' On error an exception C<' . $self->get_exception_class() . '> is thrown.';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(ARRAY)

Delete elements from ${desc}.${empt} Returns the number of deleted elements.${exc}

EOF
}

sub write_exists_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $op = &{$MOF}('exists');
    my $mb = $self->get_method_base();
    my $pkg_us = $self->get_package_us();

    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

${IND}# Count occurences
${IND}my \$count${AO}=${AO}0;
${IND}foreach my \$val (\@_)${PBOC[1]}{
${IND}${IND}\$count${AO}+=${AO}exists${BFP}(${ACS}\$self->{$pkg_us}{$an}{\$val}${ACS});
${IND}}
${IND}return${BFP}(\$count);
}

EOF
}

sub write_exists_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('exists');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}(ARRAY)

Returns the count of items in C<ARRAY> that are in ${desc}.

EOF
}

sub write_values_method {
    my $self = shift;
    my $fh = shift;

    my $an = $self->get_attribute_name();
    my $op = &{$MOF}('values');
    my $mb = $self->get_method_base();
    my $pkg_us = $self->get_package_us();

    $fh->print(<<EOF);
$SUB $op$mb${PBOC[0]}{
${IND}my \$self${AO}=${AO}shift;

${IND}# Return all values
${IND}return${BFP}(${ACS}values${BFP}(${ACS}\%{${ACS}\$self->{$pkg_us}{$an}${ACS}}${ACS})${ACS});
}

EOF
}

sub write_values_doc {
    my $self = shift;
    my $fh = shift;

    my $op = &{$MOF}('values');
    my $mb = $self->get_method_base();
    my $desc = defined( $self->get_short_description() ) ? $self->get_short_description() : 'not described option';

    $fh->print(<<EOF);
\=item $op${mb}${BFP}()

Returns an C<ARRAY> containing all values of ${desc}.

EOF
}

