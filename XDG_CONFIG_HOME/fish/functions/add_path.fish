function add_path
	if test -d $argv[1]
		set -x PATH $argv[1] $PATH
	end
end
