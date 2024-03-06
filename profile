#configure prompt
#
# options include:
# (see https://www.baeldung.com/linux/customize-bash-prompt)
#
# \d: The current date
# \t: The current time
# \h: The hostname of our Linux machine
# \u: The username of the logged-in user
# \w: The user’s working directory\
# \[: Beginning of a sequence of non-printable characters
# that somehow control the behavior of the terminal
# \]: End of non-printable control characters sequence

PS1='\u@\h:\w\$ '