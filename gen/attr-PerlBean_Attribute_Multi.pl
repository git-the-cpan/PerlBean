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
	},
);

1;
