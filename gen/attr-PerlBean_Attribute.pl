$desc = <<EOF;
C<PerlBean::Attribute> abstract class for bean attribute information. Attribute access methods are implemented and code and documentation generation interface methods are defined.
EOF
chomp ($desc);

push (@::bean_desc, {
		bean_opt => {
			abstract => 'Abstract PerlBean attribute information',
			package => 'PerlBean::Attribute',
			description => $desc,
			short_description => 'contains bean attribute information',
			synopsis => 'None. This is an abstract class.',
		},
		attr_opt => [
			{
				attribute_name => 'attribute_name',
				type => 'SINGLE',
				mandatory => 1,
				allow_empty => 0,
				allow_rx => [qw (^\w+$)],
				short_description => 'attribute\'s name',
			},
			{
				attribute_name => 'default_value',
				type => 'SINGLE',
				short_description => 'attribute\'s default value',
			},
			{
				attribute_name => 'exception_class',
				type => 'SINGLE',
				allow_empty => 0,
				default_value => 'Error::Simple',
				short_description => 'the class to throw when an exception occurs',
			},
			{
				attribute_name => 'mandatory',
				type => 'BOOLEAN',
				default_value => 0,
				short_description => 'the attribute is mandatory for construction',
			},
			{
				attribute_name => 'method_base',
				type => 'SINGLE',
				short_description => 'the method base name',
			},
			{
				attribute_name => 'perl_bean',
				type => 'SINGLE',
				allow_isa => [qw (PerlBean)],
				short_description => 'the PerlBean to which this attribute belongs',
			},
			{
				attribute_name => 'short_description',
				type => 'SINGLE',
				short_description => 'the attribute description',
			},
		],
	},
);

1;
