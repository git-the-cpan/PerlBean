# read synopsis
use IO::File;
my $fh = IO::File->new ('< syn-PerlBean.pl');
$fh = IO::File->new ('< gen/syn-PerlBean.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean> generates bean like Perl packages. That is, it generates code with for a module with attributes (properties) and the attribute's access methods (B<set>, B<push>, B<pop>, B<shift>, B<unshift>, B<has>, B<get> or B<is>, depending on the type of attribute). The attribute base types are B<BOOLEAN>, B<SINGLE> and B<MULTI>. B<BOOLEAN> attributes may be set to C<0> or C<1>. B<SINGLE> attributes may contain any scalar. B<MULTI> attributes contain a set of values (ordered/not ordered and unique/not unique).

The attribute insertion methods (C<setAttribute ()>, C<pushAttribute ()> and unshiftAttribute ()) accept C<PerlBean::Attribute> objects. However, C<PerlBean::Attribute> are best generated using C<PerlBean::Attribute::Factory>. See the sample in the B<SYNOPSIS> section.

Finaly, the actual bean code is written using the C<wite ()> method.

The generated code should be free of syntax errors. It's intended to be mixed with the application logic you intend to write yourself.

Background information: Of course the attribute code in C<PerlBean> and C<PerlBean::Attribute> are actually generated using this method.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'Code generation for bean like Perl modules',
			package => 'PerlBean',
			description => $desc,
			short_description => 'Package to generate bean like Perl modules',
			synopsis => $syn,
		},
		attr_opt => [
			{
				attribute_name => 'abstract',
				type => 'SINGLE',
				allow_rx => [qw (^.*$)],
				short_description => 'the PerlBean\' abstract',
			},
			{
				attribute_name => 'attribute',
				type => 'MULTI',
				unique => 1,
				associative => 1,
				method_key => 1,
				id_method => 'getAttributeName',
				short_description => 'the list of \'PerlBean::Attribute\' objects',
				allow_isa => [qw (PerlBean::Attribute)],
			},
			{
				attribute_name => 'base',
				type => 'MULTI',
				unique => 1,
				ordered => 1,
				short_description => 'the list of class names in use base',
				allow_rx => [qw (^\S+$)],
			},
			{
				attribute_name => 'collection',
				allow_isa => [qw (PerlBean::Collection)],
				short_description => 'class to throw when exception occurs',
			},
			{
				attribute_name => 'description',
				short_description => 'the PerlBean description',
			},
			{
				attribute_name => 'exception_class',
				allow_empty => 0,
				default_value => 'Error::Simple',
				short_description => 'class to throw when exception occurs',
			},
			{
				attribute_name => 'exported',
				type => 'BOOLEAN',
				short_description => 'the PerlBean must contain code for exporter',
				default_value => 0,
			},
			{
				attribute_name => 'license',
				type => 'SINGLE',
				allow_rx => [qw (.*)],
				short_description => 'the software license for the PerlBean',
			},
			{
				attribute_name => 'method',
				type => 'MULTI',
				unique => 1,
				associative => 1,
				method_key => 1,
				id_method => 'getMethodName',
				short_description => 'the list of \'PerlBean::Method\' objects',
				allow_isa => [qw (PerlBean::Method)],
			},
			{
				attribute_name => 'package',
				allow_empty => 0,
				default_value => 'main',
				short_description => 'package name',
			},
			{
				attribute_name => 'short_description',
				short_description => 'the short PerlBean description',
				default_value => 'NO DESCRIPTION AVAILABLE',
			},
			{
				attribute_name => 'synopsis',
				type => 'SINGLE',
				allow_rx => [qw (.*)],
				short_description => 'the synopsis for the PerlBean',
			},
		],
		meth_opt => [
			{
				method_name => 'write',
				parameter_description => 'FILEHANDLE',
				description => 'Write the Perl class code to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
			{
				method_name => 'writeAllowIsaHash',
				parameter_description => 'FILEHANDLE',
				description => 'Write the C<%ALLOW_ISA> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
			{
				method_name => 'writeAllowRefHash',
				parameter_description => 'FILEHANDLE',
				description => 'Write the C<%ALLOW_REF> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
			{
				method_name => 'writeAllowRxHash',
				parameter_description => 'FILEHANDLE',
				description => 'Write the C<%ALLOW_RX> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
			{
				method_name => 'writeAllowValueHash',
				parameter_description => 'FILEHANDLE',
				description => 'Write the C<%ALLOW_VALUE> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
			{
				method_name => 'writeDefaultValueHash',
				parameter_description => 'FILEHANDLE',
				description => 'Write the C<%DEFAULT_VALUE> hash to C<FILEHANDLE>. C<FILEHANDLE> is an C<IO::Handle> object. On error an exception C<Error::Simple> is thrown.',
			},
		],
	},
);

1;
