function fallback_command
	for c in $argv
		if command -v $c &> /dev/null
			echo $c
			break
		end
	end
end
