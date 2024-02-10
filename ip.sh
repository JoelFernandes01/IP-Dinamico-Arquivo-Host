inet_value=$(ifconfig | awk '/inet / && $1 !~ /lo/{gsub("addr:",""); print $2; exit}')
echo $inet_value