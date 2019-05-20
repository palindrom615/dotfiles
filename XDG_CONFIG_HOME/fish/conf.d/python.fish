if command_exist python3
	alias python "python3"
	alias pip "pip3"
end
if command_exist python
	set -x PATH (python -m site --user-base)/bin $PATH
end
