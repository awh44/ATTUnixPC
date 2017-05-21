#!/bin/bash

file1="bin/15C-72-00617.bin"
file2="bin/14C-72-00616.bin"

len=$(stat -c %s ${file1})
each=1
while [ $len -gt 0 ]
do 
 dd bs=$each count=1 <&5
 dd bs=$each count=1 <&6
 let len=len-$each
done 5<${file1} 6<${file2} 2>/dev/null
