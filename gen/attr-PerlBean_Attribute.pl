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
		meth_opt => [
			{
				method_name => 'getPackage',
				description => 'Returns the package name. The package name is obtained from the C<PerlBean> to which the C<PerlBean::Attribute> belongs. Or, if the C<PerlBean::Attribute> does not belong to a C<PerlBean>, C<main> is returned.',
			},
			{
				method_name => 'getPackageUS',
				description => 'Calls C<getPackage ()> and replaces C<:+> with C <_>.',
			},
			{
				method_name => 'writeMethods',
				parameter_description => 'FILEHANDLE',
				description => 'Writes the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'writeDocMethods',
				parameter_description => 'FILEHANDLE',
				description => 'Writes documentation for the access methods for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'writeDocInheritMethods',
				parameter_description => 'FILEHANDLE',
				description => 'Writes documentation for the access methods for the attribute in the case the attibute methods are inherited. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'writeDefaultValue',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<%DEFAULT_VALUE> line for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'writeOptInit',
				parameter_description => 'FILEHANDLE',
				description => 'Writes C<_initialize ()> option parsing code for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'writeDocInit',
				parameter_description => 'FILEHANDLE',
				description => 'Writes documentation for C<_initialize ()> for the attribute. C<FILEHANDLE> is an C<IO::Handle> object.',
				interface => 1,
			},
			{
				method_name => 'getOverloadedAttribute',
				description => 'Searches superclass packages for an identically named C<PerlBean::Attribute>. If found it is returned otherwise C<undef> is returned',
			},
			{
				method_name => 'type',
				description => 'Determins and returns the type of the attribute. The type is either C<BOOLEAN>, C<SINGLE> or C<MULTI>.',
			},
			{
				method_name => 'writeDocClauses',
				parameter_description => 'FILEHANDLE',
				description => 'Writes documentation for the clauses to which the contents the contents of the attribute must adhere. C<FILEHANDLE> is an C<IO::Handle> object.',
			},
		],
	},
);

1;
