use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'SINGLE bean attribute information',
        package => 'PerlBean::Attribute::Single',
        use_perl_version => 5.005,
        base => [ qw(PerlBean::Attribute)],
        description => <<EOF,
C<PerlBean::Attribute::Single> contains SINGLE bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code and documentation methods are implemented.
EOF
        short_description => 'contains SINGLE bean attribute information',
        synopsis => &get_syn(),
    },
    attr_opt => [
        {
            attribute_name => 'allow_empty',
            type => 'BOOLEAN',
            default_value => 1,
            short_description => 'the attribute is allowed to be empty',
        },
        {
            attribute_name => 'allow_isa',
            type => 'MULTI',
            unique => 1,
            short_description => 'the list of allowed classes',
        },
        {
            attribute_name => 'allow_ref',
            type => 'MULTI',
            unique => 1,
            short_description => 'the list of allowed references',
        },
        {
            attribute_name => 'allow_rx',
            type => 'MULTI',
            unique => 1,
            short_description => 'the list of allow regular expressions',
        },
        {
            attribute_name => 'allow_value',
            type => 'MULTI',
            unique => 1,
            short_description => 'allowed values',
        },
    ],
    meth_opt => [
        {
            method_name => 'write_doc_methods',
        },
        {
            method_name => 'write_methods',
        },
        {
            method_name => 'write_doc_inherit_methods',
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
        {
            method_name => 'write_allow_isa',
            description => <<EOF,
Returns a C<\%ALLOW_ISA> line string for the attribute.
EOF
        },
        {
            method_name => 'write_allow_ref',
            description => <<EOF,
Returns a C<\%ALLOW_REF> line string for the attribute.
EOF
        },
        {
            method_name => 'write_allow_rx',
            description => <<EOF,
Returns a C<\%ALLOW_RX> line string for the attribute.
EOF
        },
        {
            method_name => 'write_allow_value',
            description => <<EOF,
Returns a C<\%ALLOW_VALUE> line string for the attribute.
EOF
        },
    ],
    sym_opt => [
        {
            symbol_name => '$SUB',
            comment => <<EOF,
# Variable to not confuse AutoLoader
EOF
            assignment => "'sub';\n",
        },
    ],
    use_opt => [
        {
            dependency_name => 'PerlBean::Style',
            import_list => [ 'qw(:codegen)' ],
        },
    ],
} );

sub get_syn {
    use IO::File;
    my $fh = IO::File->new('< syn-PerlBean_Attribute_Single.pl');
    $fh = IO::File->new('< gen/syn-PerlBean_Attribute_Single.pl') if (! defined($fh));
    my $syn = '';
    my $prev_line = $fh->getline ();
    while (my $line = $fh->getline ()) {
        $syn .= ' ' . $prev_line;
        $prev_line = $line;
    }
    return($syn);
}

1;
