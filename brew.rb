
BR = "\n"

Numbers = %w[one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eightteen nineteen twenty]

Pronouns = %w[the a his her my your their our] + Numbers
VerbSpecs = %w[with in and] # Specifiers
NounSpecs = %w[of for under over]
Relatives = %w[me you myself yourself him her them us this that those these around]

class Array
	def next_phrase
		adj = []
		if Pronouns.include? self.first
			adj.push self.shift
		end
		if Relatives.include? self.first and adj == []
			return [self.shift]
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
				kwargs[self.shift.to_sym] = self.next_phrase
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
def spec_router(kwarg_names, fn)
	lambda { |args,specs|
		kwargs = {}

		# Rename and add each kwarg
		kwarg_names.each_pair do |spec,name|
			kwargs[name] = specs[spec]
		end

		if (req_l = fn.parameters.select { |arg| arg[0] == :req }.length) != args.length
			throw "#{req_l} arguments needed for command, but got #{args.length}"
		end
		# Call fn with argument dict
		fn.call(*args,**kwargs)
	}
end