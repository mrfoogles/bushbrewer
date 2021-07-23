
BR = "\n"

Pronouns = %w[the a his her my your their our]
VerbSpecs = %w[with for in and or] # Specifiers
NounSpecs = %w[of under over]
Relatives = %w[me you myself yourself him her them us this that those these around]

class Array
	def next_phrase
		if Relatives.include? self.first
			return [self.shift]
		end
		
		adj = []
		if Pronouns.include? self.first
			adj.push self.shift
		end
		
		while self.length > 0 and not Pronouns.include? self.first and not VerbSpecs.include? self.first and not Relatives.include? self.first
			adj.push self.shift
		end

		return adj
	end

	def next_verb_spec
		if VerbSpecs.include? self.first
			return self.shift, self.next_phrase
		end
	end

	def parse_cmd!
		cmd = self.shift
		args = []
		kwargs = {}

		while self.length > 0
			if VerbSpecs.include? self.first
				kwargs[self.shift] = self.next_phrase
			else
				args.push self.next_phrase
			end
		end
		return cmd,args,kwargs
	end
end

def get_cmd(valid: nil)
	while true
		line = gets
		argv = line.split

		if argv.length >= 1
			return argv
		elsif valid != nil
			puts "Valid commands:\n#{valid.join BR}"
		end
	end
end

class Array
	def subset?(a2)
		(self & a2) == self
	end
end

things = [
	%w[a dead man's chest],
	%w[the red fiddle of a sad beggar],
	%w[the sound of a toot],
	%w[the sound of crying],
	%w[the sound of clanking wheels],
	%w[a train track],
	%w[a train on the train track],
	%w[a sign on the train track]
]

class Array
	def ask_which(prompt="Choose:")
		puts prompt
		self.each_index do |i|
			puts "#{i}. #{self[i]}"
		end
		return self[gets.to_i]
	end
end

Space = ' '
def handler(fn,args,kwargs)
	def internal
		fn.call()
	end
end

Registry = {
	'mix': lambda { |args,kwargs|
		a = args[0]
		b = kwargs['and']
		device = kwargs['with']
		
		puts "I'm not sure you WANT to mix #{a.join Space} and #{b.join Space}" + if device then ",even with #{device.join Space}" else '' end
	}
}

while true
	cmd,args,kwargs = get_cmd().parse_cmd!

	fn = Registry[cmd.to_sym]
	fn.call(args,kwargs)
end