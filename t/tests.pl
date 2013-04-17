my $tests = [
	[
		'<foo tmpl-bind="foo"/>', { foo => 'bar' },
		'<foo>bar</foo>', 'Single binding'
	],

	[
		'<foo><bar tmpl-each="bar" tmpl-bind="this"/></foo>',
		{ bar => [ 1, 2, 3 ] },
		'<foo><bar>1</bar><bar>2</bar><bar>3</bar></foo>',
		'This binds inside each'
	],

	[
		'<foo tmpl-attr-map="bar:baz"/>', { baz => 'quux' },
		'<foo bar="quux"></foo>', 'Attribute binds'
	],

	[
		'<foo tmpl-attr-map="a:aaa,b:bbb"/>', { aaa => 1, bbb => 2 },
		'<foo a="1" b="2"></foo>', 'Multiple attributes bind'
	],

	[
		'<foo><bar tmpl-each="bar"><baz tmpl-each="this" tmpl-bind="this"/></bar></foo>',
		{
			bar => [
				[ qw/ 1 2 / ],
				[ qw/ 3 4 / ],
			]
		},
		'<foo><bar><baz>1</baz><baz>2</baz></bar><bar><baz>3</baz><baz>4</baz></bar></foo>',
		'Nested arrays',
		{
			skip   => 'backwards',
			reason => 'Multiple nested arrays not yet supported',
		}
	],

	[
		'<foo><bar tmpl-each="bar"><id tmpl-bind="id"/></bar></foo>',
		{
			bar => [
				{ id => 1 },
				{ id => 2 },
			]
		},
		'<foo><bar><id>1</id></bar><bar><id>2</id></bar></foo>',
		'Each uses individual items as context'
	],

	[
		'<foo tmpl-bind="foo.bar.baz"/>',
		{ foo => { bar => { baz => 1 } } },
		'<foo>1</foo>', 'Dot notation references nested hashes'
	],

	[
		'<foo><bar tmpl-each="foo.bar" tmpl-bind="this"/></foo>',
		{ foo => { bar => [ 1, 2, 3 ] } },
		'<foo><bar>1</bar><bar>2</bar><bar>3</bar></foo>',
		'Dot notation can be used with each'
	],

	[
		'<foo><bar tmpl-if="show">bar</bar></foo>', { show => 1 },
		'<foo><bar>bar</bar></foo>', 'If true keeps node'
	],

	[
		'<foo><bar tmpl-if="show">bar</bar></foo>', { show => 0 },
		'<foo></foo>', 'If false removes node'
	],

	[
		'<foo><bar tmpl-if="!show">bar</bar></foo>', { show => 0 },
		'<foo><bar>bar</bar></foo>', 'Unless false keeps node'
	],

	[
		'<foo><bar tmpl-if="!show">bar</bar></foo>', { show => 1 },
		'<foo></foo>', 'Unless true removes node'
	],
];