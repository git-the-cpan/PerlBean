# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Attribute_Multi_Unique_Ordered.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Attribute_Multi_Unique_Ordered.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Attribute::Multi::Unique::Ordered> contains unique ordered MULTI bean attribute information. It is a subclass of C<PerlBean::Attribute::Multi>. The code generation and documentation methods from C<PerlBean::Attribute> are implemented.`
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'Unique, ordered MULTI bean attribute information',
			package => 'PerlBean::Attribute::Multi::Unique::Ordered',
			base => [ qw (PerlBean::Attribute::Multi)],
			description => $desc,
			short_description => 'contains unique ordered MULTI bean attribute information',
			synopsis => $syn,
		},
		attr_opt => [
		],
	},
);

1;
