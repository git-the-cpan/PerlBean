use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'Import dependency in a Perl bean',
        package => 'PerlBean::Dependency::Import',
        use_perl_version => 5.005,
        base => [ qw( PerlBean::Dependency ) ],
        description => <<EOF,
C<PerlBean::Dependency::Import> is a class to express C<import> dependencies to classes/modules/files in a C<PerlBean>.
EOF
        short_description => 'Import dependency in a Perl bean',
        synopsis => "TODO.n",
    },
    attr_opt => [
        {
            attribute_name => 'import_list',
            type => 'MULTI',
            orderen => 1,
            short_description => 'the list after the C<dependency_name>',
        },
    ],
    meth_opt => [
        {
            method_name => 'write',
        },
    ],
} );

1;
