package PerlBean::Method::Constructor;

use 5.005;
use base qw( PerlBean::Method );
use strict;
use warnings;
use AutoLoader qw(AUTOLOAD);
use Error qw(:try);

# Package version
our ($VERSION) = '$Revision: 0.7 $' =~ /\$Revision:\s+([^\s]+)/;

1;

__END__

=head1 NAME

PerlBean::Method::Constructor - contains bean constructor method information

=head1 SYNOPSIS

 TODO

=head1 ABSTRACT

Abstract PerlBean method information

=head1 DESCRIPTION

C<PerlBean::Method> class for bean constructor method information. This is a subclass from C<PerlBean::Method> with the purpose to diferenciate beteen plain methods and constructors.

=head1 CONSTRUCTOR

=over

=item new(OPT_HASH_REF)

Creates a new C<PerlBean::Method::Constructor> object. C<OPT_HASH_REF> is a hash reference used to pass initialization options. C<OPT_HASH_REF> is mandatory. On error an exception C<Error::Simple> is thrown.

Options for C<OPT_HASH_REF> inherited through package B<C<PerlBean::Method>> may include:

=over

=item B<C<body>>

Passed to L<set_body()>.

=item B<C<description>>

Passed to L<set_description()>.

=item B<C<documented>>

Passed to L<set_documented()>. Defaults to B<1>.

=item B<C<exception_class>>

Passed to L<set_exception_class()>. Defaults to B<'Error::Simple'>.

=item B<C<interface>>

Passed to L<set_interface()>.

=item B<C<method_name>>

Passed to L<set_method_name()>. Mandatory option.

=item B<C<parameter_description>>

Passed to L<set_parameter_description()>.

=item B<C<perl_bean>>

Passed to L<set_perl_bean()>.

=back

=back

=head1 METHODS

=over

=item get_package()

This method is inherited from package C<'PerlBean::Method'>. Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.

=item get_super_method()

This method is inherited from package C<'PerlBean::Method'>. Search the superclasses hierarchy for an identically named C<PerlBean::Method> and return it. If no method is found C<undef> is returned.

=item write_code(FILEHANDLE)

This method is inherited from package C<'PerlBean::Method'>. Write the code for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=item write_pod(FILEHANDLE)

This method is inherited from package C<'PerlBean::Method'>. Write the documentation for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.

=back

=head1 INHERITED METHODS FROM PerlBean::Method

=over

=item To access attribute named B<C<body>>:

set_body(), get_body()

=item To access attribute named B<C<description>>:

set_description(), get_description()

=item To access attribute named B<C<documented>>:

set_documented(), is_documented()

=item To access attribute named B<C<exception_class>>:

set_exception_class(), get_exception_class()

=item To access attribute named B<C<interface>>:

set_interface(), is_interface()

=item To access attribute named B<C<method_name>>:

set_method_name(), get_method_name()

=item To access attribute named B<C<parameter_description>>:

set_parameter_description(), get_parameter_description()

=item To access attribute named B<C<perl_bean>>:

set_perl_bean(), get_perl_bean()

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
L<PerlBean::Dependency::Import>,
L<PerlBean::Dependency::Require>,
L<PerlBean::Dependency::Use>,
L<PerlBean::Described>,
L<PerlBean::Described::ExportTag>,
L<PerlBean::Method>,
L<PerlBean::Style>,
L<PerlBean::Symbol>

=head1 BUGS

None known (yet.)

=head1 HISTORY

First development: February 2003

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

