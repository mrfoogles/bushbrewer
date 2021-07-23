# Notes on the code
 - Hash/dict keys are never strings (symbols instead)
	- `{:foo => :bar}['foo'] = nil`
	- `{'foo' => 'bar'}[:foo] = nil`
	https://fullstackheroes.com/ruby/symbols-vs-strings/