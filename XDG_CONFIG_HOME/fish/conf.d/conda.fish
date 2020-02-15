if test -d $HOME/.local/share/anaconda3
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	eval $HOME/.local/share/anaconda3/bin/conda "shell.fish" "hook" $argv | source
	# <<< conda initialize <<<
end
