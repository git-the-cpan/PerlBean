# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Attribute_Boolean.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Attribute_Boolean.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Attribute::Boolean> contains BOOLEAN bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code generation and documentation methods are implemented.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'BOOLEAN bean attribute information',
			package => 'PerlBean::Attribute::Boolean',
			base => [qw (PerlBean::Attribute)],
			description => $desc,
			short_description => 'contains BOOLEAN bean attribute information',
			synopsis => $syn,
		},
		attr_opt => [
		],
	},
);

1;
