use strict;

use PerlBean::Style qw(:codegen);

push(@::bean_desc, {
    bean_opt => {
        abstract => 'Code generation for bean like Perl modules',
        package => 'PerlBean',
        use_perl_version => 5.005,
        description => <<EOF,
C<PerlBean> generates bean like Perl packages. That is, it generates code with for a module with attributes(properties) and the attribute's access methods (B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<has>, B<get> or B<is>, depending on the type of attribute). The attribute base types are B<BOOLEAN>, B<SINGLE> and B<MULTI>. B<BOOLEAN> attributes may be set to C<0> or C<1>. B<SINGLE> attributes may contain any scalar. B<MULTI> attributes contain a set of values(ordered/not ordered and unique/not unique).

The attribute insertion methods (C<set_attribute()>, C<push_attribute()> and unshift_attribute()) accept C<PerlBean::Attribute> objects. However, C<PerlBean::Attribute> are best generated using C<PerlBean::Attribute::Factory>. See the sample in the B<SYNOPSIS> section.

Finaly, the actual bean code is written using the C<write()> method.

The generated code should be free of syntax errors. It's intended to be mixed with the application logic you intend to write yourself.

Background information: Of course the attribute code in C<PerlBean> and C<PerlBean::Attribute> are actually generated using this method.
EOF
        short_description => 'Package to generate bean like Perl modules',
        synopsis => &get_syn(),
    },
    attr_opt => [
        {
            attribute_name => 'abstract',
            type => 'SINGLE',
            allow_rx => [qw(^.*$)],
            short_description => 'the PerlBean\'s abstract (a one line description of the module)',
        },
        {
            attribute_name => 'attribute',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_attribute_name',
            short_description => 'the list of \'PerlBean::Attribute\' objects',
            allow_isa => [ qw( PerlBean::Attribute ) ],
        },
        {
            attribute_name => 'base',
            type => 'MULTI',
            unique => 1,
            ordered => 1,
            short_description => 'the list of class names in use base',
            allow_rx => [qw(^\S+$)],
        },
        {
            attribute_name => 'collection',
            allow_isa => [qw(PerlBean::Collection)],
            short_description => 'class to throw when exception occurs',
        },
        {
            attribute_name => 'description',
            short_description => 'the PerlBean description',
        },
        {
            attribute_name => 'exception_class',
            allow_empty => 0,
            default_value => 'Error::Simple',
            short_description => 'class to throw when exception occurs',
        },
        {
            attribute_name => 'autoloaded',
            type => 'BOOLEAN',
            short_description => 'the methods in the PerlBean are autoloaded',
            default_value => 1,
        },
        {
            attribute_name => 'dependency',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_dependency_name',
            short_description => 'the list of \'PerlBean::Dependency\' objects',
            allow_isa => [ qw( PerlBean::Dependency ) ],
            default_value => [ 'XXXX' ],
        },
        {
            attribute_name => 'export_tag_description',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_export_tag_name',
            short_description => 'the list of \'PerlBean::Described::ExportTag\' objects',
            allow_isa => [ qw( PerlBean::Described::ExportTag ) ],
        },
        {
            attribute_name => 'singleton',
            type => 'BOOLEAN',
            short_description => 'the package is a singleton and an C<instance()> method is implemented',
            default_value => 0,
        },
        {
            attribute_name => 'license',
            type => 'SINGLE',
            allow_rx => [qw(.*)],
            short_description => 'the software license for the PerlBean',
        },
        {
            attribute_name => 'symbol',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_symbol_name',
            short_description => 'the list of \'PerlBean::Symbol\' objects',
            allow_isa => [qw(PerlBean::Symbol)],
        },
        {
            attribute_name => 'method',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_method_name',
            short_description => 'the list of \'PerlBean::Method\' objects',
            allow_isa => [qw(PerlBean::Method)],
        },
        {
            attribute_name => 'package',
            allow_empty => 0,
            default_value => 'main',
            short_description => 'package name',
        },
        {
            attribute_name => 'use_perl_version',
            allow_empty => 0,
            default_value => '$]',
            allow_rx => [ qw( ^v?\d+\(\.[\d_]+\)* ) ],
            short_description => 'the Perl version to use',
        },
        {
            attribute_name => 'short_description',
            short_description => 'the short PerlBean description',
            default_value => 'NO DESCRIPTION AVAILABLE',
        },
        {
            attribute_name => 'synopsis',
            type => 'SINGLE',
            allow_rx => [qw(.*)],
            short_description => 'the synopsis for the PerlBean',
        },
        {
            attribute_name => '_has_exports_',
            type => 'BOOLEAN',
            documented => 0,
            default_value => 0,
        },
        {
            attribute_name => '_export_tag_',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            documented => 0,
        },
    ],
    meth_opt => [
        {
            method_name => 'write',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.
EOF
        },
    ],
    sym_opt => [
        {
            symbol_name => '$END',
            comment => <<EOF,
# Variable to not confuse AutoLoader
EOF
            assignment => "'__END__';\n",
        },
        {
            symbol_name => '$SUB',
            comment => <<EOF,
# Variable to not confuse AutoLoader
EOF
            assignment => "'sub';\n",
        },
        {
            symbol_name => '$PACKAGE',
            comment => <<EOF,
# Variable to not confuse AutoLoader
EOF
            assignment => "'package';\n",
        },
        {
            symbol_name => '@MON',
            comment => <<EOF,
# Month names array
EOF
            assignment => <<EOF,
qw(
${IND}January
${IND}February
${IND}March
${IND}April
${IND}May
${IND}June
${IND}July
${IND}August
${IND}September
${IND}October
${IND}November
${IND}December
);
EOF
        },
    ],
    use_opt => [
        {
            dependency_name => 'PerlBean::Style',
            import_list => [ 'qw(:codegen)' ],
        },
        {
            dependency_name => 'PerlBean::Symbol',
        },
        {
            dependency_name => 'PerlBean::Dependency::Require',
        },
        {
            dependency_name => 'PerlBean::Dependency::Use',
        },
    ],
} );

sub get_syn {
    use IO::File;
    my $fh = IO::File->new('< syn-PerlBean.pl');
    $fh = IO::File->new('< gen/syn-PerlBean.pl') if (! defined($fh));
    my $syn = '';
    my $prev_line = $fh->getline ();
    while (my $line = $fh->getline ()) {
        $syn .= ' ' . $prev_line;
        $prev_line = $line;
    }
    return($syn);
}

1;
