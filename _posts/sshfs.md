

# Montage SSH sous Mac OS X

brew cask install sshfs
sshfs username@hostname:/remote/directory/path /local/mount/point -ovolname=NAME

sshfs -p <port> <user>@<hostname>:<remote path> <local path> -ovolname=rvol -o sshfs_debug

http://apple.stackexchange.com/a/193043
https://jonathansblog.co.uk/sshfs-mount-remote-drive-in-finder

