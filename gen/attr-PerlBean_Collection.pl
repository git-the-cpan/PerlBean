# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Collection.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Collection.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Collection> contains a collection of C<PerlBean> objects in order to generate an hierarchy of Perl modules.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'Code hierarchy generation for bean like Perl modules',
			package => 'PerlBean::Collection',
			description => $desc,
			short_description => 'contains a ccollection of PerlBean objects',
			synopsis => $syn,
		},
		attr_opt => [
			{
				attribute_name => 'bean',
				type => 'MULTI',
				unique => 1,
				associative => 1,
				allow_isa => [qw (PerlBean)],
				short_description => 'the list of beans in the collection',
			},
			{
				attribute_name => 'license',
				type => 'SINGLE',
				allow_rx => [qw (.*)],
				short_description => 'the software license for the PerlBean collection',
			},
		],
	},
);

1;
