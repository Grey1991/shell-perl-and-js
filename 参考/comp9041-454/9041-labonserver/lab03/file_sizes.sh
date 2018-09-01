#!/bin/sh
s=()
sl=0
m=()
ml=0
l=()
ll=0
for file in *
do
  t=$(cat "$file"|wc -l)
if test $t -lt 10
then
  s[$sl]=$file
  sl=$(($sl+1))
elif test $t -lt 100
then
  m[$ml]=$file
  ml=$(($ml+1))
else
  l[$ll]=$file
  ll=$(($ll+1))
fi
done

ss=($(for val1 in "${s[@]}"
do
  echo "$val1"
done |sort -d)
)

ms=($(for val2 in "${m[@]}"
do
  echo "$val2"
done |sort -d)
)

ls=($(for val3 in "${l[@]}"
do
  echo "$val3"
done |sort -d)
)
echo -e "Small files: \c"
for i in ${ss[*]}
do
echo -e "${i} \c"
done
echo -e "\t"
echo -e "Medium-sized files: \c"
for j in ${ms[*]}
do
echo -e "${j} \c"
done
echo -e "\t"
echo -e "Large files: \c"
for k in ${ls[*]}
do
echo -e "${k} \c"
done
echo -e "\t"
