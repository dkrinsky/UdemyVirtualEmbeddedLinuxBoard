#!/bin/bash

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

# script will
#    use the passwd input file to define the user names and id.
#    create a /etc/group file assuming that each user is in its own group only.
#    create a /etc/shadow file by creating a encrypted password



# /etc/shadow file format
#   use only username, encrypted password ($type$salt$hashed)
# do we need any of the other fields? udemy course set the Last password change to 18541.
# I'm not sure if that is required
#
# Username. User account and login name that exist in the system.
# Encrypted password. Password using the format $type$salt$hashed and eight to 12 characters long.
# Last password change. num days since Jan. 1, 1970, when the password was last changed.
# Minimum password age. 
# Maximum password age. 
# Warning period. 
# Inactivity period. 
# Expiration date. The date on which the account was disabled.
# Unused. This field is left empty and reserved for future use.

# number of days after jan 1 1970 that the password changed
# 18541 ~ 50 years
last_password_change="18541"


echo "passwd file: "
cat ./passwd
input="./passwd"

rm -rf group
rm -rf shadow

while IFS= read -r line
do
  #echo "$line"
    IFS=':'; arrline=($line); unset IFS;
    
    username=${arrline[0]}
    userid=${arrline[2]}
    
    echo ""
    echo "create home directory and /etc/group file line for "${username}" "${userid}
    group_line="${username}:x:${userid}:${username}"
    touch group
    echo "group_line ${group_line}"
    echo "${group_line}" >> group
    sudo mount rootfs.ext4 mount
    sudo mkdir -p mount/${username}
    sudo umount mount

    echo ""
    if [ ${username} != "root" ]
    then
       echo "create password for "${username}" "${userid}
       password="12345"${userid}
    else
       echo "create password for "${username}" "${userid}
       password="root"
    fi
    salt="mypassword"
    pwdhash=$(mkpasswd -m sha-512 ${password} -S ${salt})
    echo "password"${password}" hash "$pwdhash
    echo ${username}":"${pwdhash}":"${last_password_change}"::::::" >> shadow

done < "$input"

# mount rootfs and copy passwd, shadow, and group files
sudo mount rootfs.ext4 mount
sudo cp passwd mount/etc
sudo cp shadow mount/etc
sudo cp group mount/etc
sudo cp inittab mount/etc
sudo umount mount



