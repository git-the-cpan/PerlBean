# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Attribute_Single.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Attribute_Single.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Attribute::Single> contains SINGLE bean attribute information. It is a subclass of C<PerlBean::Attribute>. The code and documentation methods are implemented.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'SINGLE bean attribute information',
			package => 'PerlBean::Attribute::Single',
			base => [ qw (PerlBean::Attribute)],
			description => $desc,
			short_description => 'contains SINGLE bean attribute information',
			synopsis => $syn,
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
				method_name => 'writeDocMethods',
			},
			{
				method_name => 'writeMethods',
			},
			{
				method_name => 'writeDocInheritMethods',
			},
			{
				method_name => 'writeDefaultValue',
			},
			{
				method_name => 'writeOptInit',
			},
			{
				method_name => 'writeDocInit',
			},
			{
				method_name => 'writeAllowIsa',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<%ALLOW_ISA> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
			},
			{
				method_name => 'writeAllowRef',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<%ALLOW_REF> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
			},
			{
				method_name => 'writeAllowRx',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<%ALLOW_RX> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
			},
			{
				method_name => 'writeAllowValue',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<%ALLOW_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
			},
		],
	},
);

1;
