add_path $HOME/.local/share/go/bin
add_path $HOME/go/bin
if command_exist go
	set -x GO111MODULE on
end
