module UsersHelper
	def random_password()
		words = %w[ foo bar jim bar col uac atl aut ]
		max = 999
		"%s%0#{max.to_s.length}d" % [ words.sample, rand(max+1) ]
	end
end
