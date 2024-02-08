#!/bin/bash

# /etc/shadow file format
#   use only username, encrypted password ($type$salt$hashed)
# do we need any of the other fields? udemy course set the Last password change to 18541.
# I'm not sure if that is required
#
# Username. User account and login name that exist in the system.
# Encrypted password. Password using the format $type$salt$hashed and eight to 12 characters long.
# Last password change. Date since Jan. 1, 1970, when the password was last changed.
# Minimum password age. 
# Maximum password age. 
# Warning period. 
# Inactivity period. 
# Expiration date. The date on which the account was disabled.
# Unused. This field is left empty and reserved for future use.

# passwd file is going to be the input
# e.g.
#
#   root:x:0:0:root:/root:/bin/sh
#   dkrinsky:x:1:1:dkrinsky:/dkrinsky:/bin/sh
#
# Username: It is used when user logs in. It should be between 1 and 32 characters in length.
# Password: An x character indicates that encrypted password is stored in /etc/shadow file.
# User ID (UID): 
# Group ID (GID): 
# User ID Info (GECOS): The comment field. It allow you to add extra information 
# Home directory: The absolute path to the directory the user will be in when they log in.
# Command/shell: The absolute path of a command or shell (/bin/bash). 




echo "passwd file: "
cat ./passwd
input="./passwd"


while IFS= read -r line
do
  #echo "$line"
    IFS=':'; arrline=($line); unset IFS;
    
    username=${arrline[0]}
    userid=${arrline[2]}
    echo "create home directory /"${username}
    group_line="${username}:x:${userid}:${username}"
    echo "group_line ${group_line}"
    sudo mkdir -p mount/${username}
done < "$input"

pwdhash=$(mkpasswd -m sha-512 123456 -S "mypassword")
echo "--x--x--> $pwdhash"

sudo mount rootfs.ext4 mount
sudo cp passwd mount/etc
sudo cp group mount/etc

sudo umount mount
#run_kernel_rootfs
