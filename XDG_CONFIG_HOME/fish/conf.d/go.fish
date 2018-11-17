# set the workspace path
set -x GOPATH $HOME/go
set -x GOROOT /usr/local/go

# add the go bin path to be able to execute our programs
set -x PATH $GOROOT/bin $GOPATH/bin $PATH
