function add_path
	if status --is-login
		set -x PATH $argv[1] $PATH
	end
end