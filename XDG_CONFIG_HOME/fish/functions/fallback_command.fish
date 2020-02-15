function fallback_command
    for com in $argv
        if type -q $com
            echo $com
            break
        end
    end
end