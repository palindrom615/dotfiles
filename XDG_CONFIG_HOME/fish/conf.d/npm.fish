if command -sq npm
	set -x PATH (npm get prefix)/bin $PATH
end

