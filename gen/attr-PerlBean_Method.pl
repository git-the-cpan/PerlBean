use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'Abstract PerlBean method information',
        package => 'PerlBean::Method',
        description => <<EOF,
C<PerlBean::Method> class for bean method information.
EOF
        short_description => 'contains bean method information',
        #synopsis => '???',
    },
    attr_opt => [
        {
            attribute_name => 'body',
            type => 'SINGLE',
            allow_rx => [qw(.*)],
            short_description => 'the method\'s body',
        },
        {
            attribute_name => 'exception_class',
            type => 'SINGLE',
            allow_empty => 0,
            default_value => 'Error::Simple',
            short_description => 'the class to throw in eventual interface inplementations',
        },
        {
            attribute_name => 'interface',
            type => 'BOOLEAN',
            short_description => 'the method is defined as interface',
        },
        {
            attribute_name => 'method_name',
            type => 'SINGLE',
            mandatory => 1,
            allow_empty => 0,
            allow_rx => [qw(^\w+$)],
            short_description => 'the method\'s name',
        },
        {
            attribute_name => 'parameter_description',
            type => 'SINGLE',
            short_description => 'the parameter description',
        },
        {
            attribute_name => 'perl_bean',
            type => 'SINGLE',
            allow_isa => [qw(PerlBean)],
            short_description => 'the PerlBean to which this method belongs',
        },
        {
            attribute_name => 'description',
            type => 'SINGLE',
            short_description => 'the method description',
        },
    ],
    meth_opt => [
        {
            method_name => 'write_code',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Write the code for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.
EOF
        },
        {
            method_name => 'write_pod',
            parameter_description => 'FILEHANDLE',
            description => <<EOF,
Write the documentation for the method to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.
EOF
        },
        {
            method_name => 'get_super_method',
            description => <<EOF,
Search the superclasses hierarchy for an identically named C<PerlBean::Method> and return it. If no method is found C<undef> is returned.
EOF
        },
        {
            method_name => 'get_package',
            description => <<EOF,
Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.
EOF
        },
    ],
} );

1;
