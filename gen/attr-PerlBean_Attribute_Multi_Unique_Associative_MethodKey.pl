use IO::File;
my $fh = IO::File->new ('< syn-PerlBean_Attribute_Multi_Unique_Associative_MethodKey.pl');
$fh = IO::File->new ('< gen/syn-PerlBean_Attribute_Multi_Unique_Associative_MethodKey.pl') if (! defined ($fh));
my $syn = '';
my $prev_line = $fh->getline ();
while (my $line = $fh->getline ()) {
	$syn .= ' ' . $prev_line;
	$prev_line = $line;
}
chomp ($syn);

$desc = <<EOF;
C<PerlBean::Attribute::Multi::Unique::Associative::MethodKey> contains information on unique associative MULTI bean attribute that gets its key from an object method. It is a subclass of C<PerlBean::Attribute::Multi>. The code generation and documentation methods from C<PerlBean::Attribute> are implemented.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'Unique, associative MULTI bean attribute information',
			package => 'PerlBean::Attribute::Multi::Unique::Associative::MethodKey',
			base => [ qw (PerlBean::Attribute::Multi)],
			description => $desc,
			short_description => 'contains unique associative MULTI bean attribute information',
			synopsis => $syn,
		},
		attr_opt => [
			{
				attribute_name => 'id_method',
				type => 'SINGLE',
				default_value => 'getId',
				short_description => 'the method to obtain the ID from the item in the list',
			},
		],
		meth_opt => [
			{
				method_name => 'writeDocMethods',
				description => '__SUPER_POD__ Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.',
			},
			{
				method_name => 'writeMethods',
				description => '__SUPER_POD__ Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.',
			},
			{
				method_name => 'writeDocInheritMethods',
				description => '__SUPER_POD__ Access methods are B<set...>, B<add...>, B<delete...>, B<exists...>, B<keys...> and B<values...>.',
			},
		],
	},
);

1;
