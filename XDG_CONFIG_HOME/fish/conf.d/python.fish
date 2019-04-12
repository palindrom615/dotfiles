if command -sq python3
	alias python "python3"
	alias pip "pip3"
end
if command -sq python
	set -x PATH (python -m site --user-base)/bin $PATH
end
