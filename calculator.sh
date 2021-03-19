#!/bin/bash

echo -n "Enter A: "
read A
echo -n "Enter B: "
read B

echo "---------------------------"
echo " (1) + (2) - (3) * (4) /"
echo "---------------------------"

echo -n "Enter your cohice: "
read C

case $C in
1) echo "A + B = `expr $A + $B`";;
2) echo "A - B = `expr $A - $B`";;
3) echo "A * B = `expr $A \* $B`";;
4) if [ $B -eq 0 ]; then
	echo "Wrong B"
   else
	echo "A/B =`expr $A / $B`"
   fi;;
*) echo "Wrong Number";;
esac
