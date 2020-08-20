function addto(x)
	return function(y)
		return x + y
	end
end

fourplus = addto(4)
print(fourplus(3))
