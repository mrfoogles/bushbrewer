require './brew'

Registry = {
	:get => spec_router({:with => :c, :in => :d}, lambda { 
		|a,b,c: nil, d: nil|
		return "get #{a} #{b} with #{c} in #{d}"
	})
}

class String
	def test_as_cmd
		cmd, args, kwargs = self.dup.split.parse_cmd!
		out = Registry[cmd.to_sym].call(args,kwargs)
		puts "'#{self}'\n\tto '#{out}'"
	end
end

[
	'get me a banana with the car in the device',
	'get her car two bananas with the undercar for billy in the device'
].each do |s| s.test_as_cmd end