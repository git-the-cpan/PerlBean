use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'Abstract PerlBean attribute information',
        package => 'PerlBean::Attribute',
        use_perl_version => 5.005,
        description => <<EOF,
C<PerlBean::Attribute> abstract class for bean attribute information. Attribute access methods are implemented and code and documentation generation interface methods are defined.
EOF
        short_description => 'contains bean attribute information',
        synopsis => "None. This is an abstract class.\n",
    },
    attr_opt => [
        {
            attribute_name => 'attribute_name',
            type => 'SINGLE',
            mandatory => 1,
            allow_empty => 0,
            allow_rx => [qw(^\w+$)],
            short_description => 'attribute\'s name',
        },
        {
            attribute_name => 'default_value',
            type => 'SINGLE',
            short_description => 'attribute\'s default value',
        },
        {
            attribute_name => 'documented',
            type => 'BOOLEAN',
            default_value => 1,
            short_description => 'the attribute is documented',
        },
        {
            attribute_name => 'exception_class',
            type => 'SINGLE',
            allow_empty => 0,
            default_value => 'Error::Simple',
            short_description => 'the class to throw when an exception occurs',
        },
        {
            attribute_name => 'mandatory',
            type => 'BOOLEAN',
            default_value => 0,
            short_description => 'the attribute is mandatory for construction',
        },
        {
            attribute_name => 'method_base',
            type => 'SINGLE',
            short_description => 'the method base name',
        },
        {
            attribute_name => 'perl_bean',
            type => 'SINGLE',
            allow_isa => [qw(PerlBean)],
            short_description => 'the PerlBean to which this attribute belongs',
        },
        {
            attribute_name => 'short_description',
            type => 'SINGLE',
            short_description => 'the attribute description',
        },
    ],
    meth_opt => [
        {
            method_name => 'get_package',
            description => <<EOF,
Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.
EOF
        },
        {
            method_name => 'get_package_us',
            description => <<EOF,
Calls C<get_package()> and replaces C<:+> with C <_>.
EOF
        },
        {
            method_name => 'write_methods',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
            interface => 1,
        },
        {
            method_name => 'write_doc_methods',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
            interface => 1,
        },
        {
            method_name => 'write_doc_inherit_methods',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
            interface => 1,
        },
        {
            method_name => 'write_default_value',
            description => <<EOF,
Returns a C<\%DEFAULT_VALUE> line string for the attribute.
EOF
            interface => 1,
        },
        {
            method_name => 'write_opt_init',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes C<_initialize()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
            interface => 1,
        },
        {
            method_name => 'write_doc_init',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes documentation for C<_initialize()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
            interface => 1,
        },
        {
            method_name => 'get_overloaded_attribute',
            description => <<EOF,
Searches superclass packages for an identically named C<PerlBean::Attribute>. If found it is returned otherwise C<undef> is returned.
EOF
        },
        {
            method_name => 'type',
            description => <<EOF,
Determins and returns the type of the attribute. The type is either C<BOOLEAN>, C<SINGLE> or C<MULTI>.
EOF
        },
        {
            method_name => 'write_doc_clauses',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.
EOF
        },
    ],
    use_opt => [
        {
            dependency_name => 'PerlBean::Style',
            import_list => [ 'qw(:codegen)' ],
        },
    ],
} );

1;
