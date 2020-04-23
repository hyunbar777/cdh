#!/bin/bash
p=$#
if [[ p == 0 ]]
then
echo no args;
exit;
fi

#2 获取文件名
p1=$1
fname=`basename $p1`

#3 获取上级目录到绝对路径
pdir=`cd -P $(dirname $p1);pwd`
echo pdir=$pdir

#4 获取当前用户名称
u=`whoami`

#5 循环
for host in hadoop100 hadoop101 hadoop102 ; do
 echo ------------------- $host ---------------
 rsync -av $pdir/$fname $u@$host:$pdir
done

