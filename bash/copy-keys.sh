#!/bin/bash +x
# Copies over a key to a number of servers
# Uses /etc/hosts as inventory by default

hosts_file=/etc/hosts
#keyfile=KEY_FILE
#user=hybris
tmp=/tmp/hosts
inventory=/tmp/inventory

# Given a hosts file, remove string and numerical localhost entries
# Write result to a file - $tmp
cat $hosts_file | while read line || [[ -n $line ]];
do
  [[ "$line" =~ ^#.*$ ]] && continue
  if [[ "$line" != *127.0.0.1* ]];then
    if [[ "$line" != *host* ]];then
      echo "$line" >> $tmp
    fi
  fi
done

# Remove bogus whitespace
sed '/^$/d' $tmp > $inventory

while read i; do
  host=$(echo $i | awk {'print $1'})
  ssh-copy-id -i $keyfile $user@$host
done < $inventory
