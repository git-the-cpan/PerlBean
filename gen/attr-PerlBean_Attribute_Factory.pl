# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Attribute_Factory.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Attribute_Factory.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
        $syn .= ' ' . $prev_line;
        $prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Attribute::Factory> objects create instances of C<PerlBean::Attribute> objects.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'C<PerlBean::Attribute> object factory',
			package => 'PerlBean::Attribute::Factory',
			description => $desc,
			short_description => 'factory package to generate C<PerlBean::Attribute> objects',
			synopsis => $syn,
		},
		attr_opt => [
		],
	},
);

1;
