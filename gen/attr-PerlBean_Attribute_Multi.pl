use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'MULTI bean attribute abstraction',
        package => 'PerlBean::Attribute::Multi',
        use_perl_version => 5.005,
        base => [ qw(PerlBean::Attribute::Single)],
        description => <<EOF,
C<PerlBean::Attribute::Multi> is a subclass of C<PerlBean::Attribute> and it's only function is to group the MULTI attribute classes.
EOF
        short_description => 'contains MULTI bean attribute information',
        synopsis => "None. This is an abstract class.\n",
    },
    attr_opt => [
    ],
    meth_opt => [
        {
            method_name => 'write_doc_methods',
            interface => 1,
        },
        {
            method_name => 'write_methods',
            interface => 1,
        },
        {
            method_name => 'write_doc_inherit_methods',
            interface => 1,
        },
        {
            method_name => 'write_default_value',
        },
        {
            method_name => 'write_opt_init',
        },
        {
            method_name => 'write_doc_init',
        },
    ],
    sym_opt => [
    ],
    use_opt => [
        {
            dependency_name => 'PerlBean::Style',
            import_list => [ 'qw(:codegen)' ],
        },
    ],
} );

1;
