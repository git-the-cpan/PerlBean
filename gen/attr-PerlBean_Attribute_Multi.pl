$desc = <<EOF;
C<PerlBean::Attribute::Multi> is a subclass of C<PerlBean::Attribute> and it's only function is to group the MULTI attribute classes.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'MULTI bean attribute abstraction',
			package => 'PerlBean::Attribute::Multi',
			base => [ qw (PerlBean::Attribute::Single)],
			description => $desc,
			short_description => 'contains MULTI bean attribute information',
			synopsis => 'None. This is an abstract class.',
		},
		attr_opt => [
		],
		meth_opt => [
			{
				method_name => 'writeDocMethods',
				description => '__SUPER_POD__ As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.',
			},
			{
				method_name => 'writeMethods',
				description => '__SUPER_POD__ As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.',
			},
			{
				method_name => 'writeDocInheritMethods',
				description => '__SUPER_POD__ As package C<PerlBean::Attribute::Multi> is intended to group its subclasses this method actually throws an exception.',
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
		],
	},
);

1;
