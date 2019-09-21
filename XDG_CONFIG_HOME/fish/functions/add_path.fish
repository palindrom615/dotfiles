function add_path
	#if status --is-login && [ -d $argv[1] ]
	if [ -d $argv[1] ]
		set -x PATH $argv[1] $PATH
	end
end
