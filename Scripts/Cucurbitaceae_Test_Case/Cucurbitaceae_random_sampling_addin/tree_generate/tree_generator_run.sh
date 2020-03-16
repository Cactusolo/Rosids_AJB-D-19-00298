#!/bin/bash

#rm ./data/*rm_tip.txt ./data/*_drop.tre ./data/*_add.tre ./data/*.tmp
#loading R model from HPC

ml R

#Step 1 generate random trees
Rscript tree_generater.R

#remove file header
sed -i '1d' ./data/Cucurbitaceae_5g_*_rm_tip.txt

sed -i 's/\r$//' ./data/*.tre

#make a summary table for all the ramdom trees
echo "Before_tip,add_tip,add_auto,no_genus,after_tip" >summary.csv

#Step2 loop through add in tips using pytoy in "tree_addin.sh" script
for tree in `ls ./data/*_drop.tre`; do
	echo $tree
	file=$(echo $tree|sed 's/_drop.tre/_rm_tip.txt/g')
	bash tree_addin.sh $tree $file
	rm *.tmp
done

mv ./data/*_add.tre result

cd result

#rename the tree
for i in `ls *.tre`; do
	mv $i `echo $i|sed 's/_drop.tre_add.tre/_bub.tre/g'`
done
cd ..