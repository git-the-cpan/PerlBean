use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'BOOLEAN bean attribute information',
        package => 'PerlBean::Attribute::Boolean',
        base => [qw(PerlBean::Attribute)],
        description => <<EOF,
C<PerlBean::Attribute::Boolean> contains BOOLEAN bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code generation and documentation methods are implemented.
EOF
        short_description => 'contains BOOLEAN bean attribute information',
        synopsis => &get_syn(),
    },
    attr_opt => [
    ],
    meth_opt => [
        {
            method_name => 'write_doc_methods',
            description => <<EOF,
__SUPER_POD__ Access methods are B<set...> and B<is...>.
EOF
        },
        {
            method_name => 'write_methods',
            description => <<EOF,
__SUPER_POD__ Access methods are B<set...> and B<is...>.
EOF
        },
        {
            method_name => 'write_doc_inherit_methods',
            description => <<EOF,
__SUPER_POD__ Access methods are B<set...> and B<is...>.
EOF
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
} );

sub get_syn {
    use IO::File;
    my $fh = IO::File->new('< syn-PerlBean_Attribute_Boolean.pl');
    $fh = IO::File->new('< gen/syn-PerlBean_Attribute_Boolean.pl') if (! defined($fh));
    my $syn = '';
    my $prev_line = $fh->getline ();
    while (my $line = $fh->getline ()) {
        $syn .= ' ' . $prev_line;
        $prev_line = $line;
    }
    return($syn);
}

1;
