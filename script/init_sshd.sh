#!/bin/bash

cd /conf/sshd

for user in *; do
  if [ -d ${user} ]; then
    ( getent passwd ${user} >/dev/null 2>&1 ) || adduser -D -s /bin/bash ${user}
    ln -s /var/www /home/${user}/website
    touch /home/${user}/.hushlogin
    user_ssh_dir=/home/${user}/.ssh
    if [ -f ${user}/authorized_keys ]; then
      [ -d ${user_ssh_dir} ] || mkdir ${user_ssh_dir}
      chmod 700 ${user_ssh_dir}
      cp ${user}/authorized_keys ${user_ssh_dir}
      chown -R ${user}:${user} ${user_ssh_dir}
      chmod 600 ${user_ssh_dir}/authorized_keys
    fi
    rand_pass=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
    chpasswd <<EOF
${user}:x0${rand_pass}l0l
EOF
  fi
done


for x in rsa dsa ecdsa ed25519; do
  f=ssh_host_${x}_key
  if [ -f $f ] && [ -f $f.pub ]; then
    cp -f $f /etc/ssh/$f
    cp -f $f.pub /etc/ssh/$f.pub
  else
    ssh-keygen -f /etc/ssh/$f -N '' -t $x
  fi
done
