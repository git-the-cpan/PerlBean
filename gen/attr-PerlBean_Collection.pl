use strict;

push(@::bean_desc, {
    bean_opt => {
        abstract => 'Code hierarchy generation for bean like Perl modules',
        package => 'PerlBean::Collection',
        use_perl_version => 5.005,
        description => <<EOF,
C<PerlBean::Collection> contains a collection of C<PerlBean> objects in order to generate an hierarchy of Perl modules.
EOF
        short_description => 'contains a ccollection of PerlBean objects',
        synopsis => &get_syn(),
    },
    attr_opt => [
        {
            attribute_name => 'perl_bean',
            type => 'MULTI',
            unique => 1,
            associative => 1,
            method_key => 1,
            id_method => 'get_package',
            allow_isa => [qw(PerlBean)],
            short_description => 'the list of PerlBean objects in the collection',
        },
        {
            attribute_name => 'license',
            type => 'SINGLE',
            allow_rx => [qw(.*)],
            short_description => 'the software license for the PerlBean collection',
        },
    ],
    meth_opt => [
        {
            method_name => 'write',
            parameter_description => 'DIRECTORY',
            description => <<EOF,
Write the hierarchy of Perl class code to C<DIRECTORY>. C<DIRECTORY> is a directory name. On error an exception C<Error::Simple> is thrown.
EOF
        },
    ],
} );

sub get_syn {
    use IO::File;
    my $fh = IO::File->new('< syn-PerlBean_Collection.pl');
    $fh = IO::File->new('< gen/syn-PerlBean_Collection.pl') if (! defined($fh));
    my $syn = '';
    my $prev_line = $fh->getline ();
    while (my $line = $fh->getline ()) {
        $syn .= ' ' . $prev_line;
        $prev_line = $line;
    }
    return($syn);
}

1;
