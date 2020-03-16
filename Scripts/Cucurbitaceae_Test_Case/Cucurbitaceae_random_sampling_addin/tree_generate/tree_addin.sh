#!/bin/bash
# this script will look for all those unmatched species, and checking if there are any sister species in the tree;
#if Yes, then add to the most updated tree;
#if No, output the no match list

tree=$1 #the tree which to add to
File=$2 #the tips which need to be added

#loading models
ml phyx newickutils
#Date=$(date|awk -F ' ' '{print $2,$3,$NF}'|sed 's/ //g')
#echo `date`

nw_labels -I $tree >${tree}_tips.tmp
Before_tip=$(wc -l ${tree}_tips.tmp|sort|uniq|cut -f1 -d' ')
add_tip=$(wc -l $File|cut -f1 -d' ')

touch add_in_auto.tmp add_to_root.tmp 

echo -e "\n add in species names using opentree pytoy\n"
#1). if more then one species from one genus on the tree, will use "add_missing_taxa_auto"
#2). if the genus not in the tree, then will add in at the root of the tree

for species in `cat $File`; do
		genus=$(echo $species|cut -f1 -d'_')
		N=$(grep -c $genus ${tree}_tips.tmp)
		if [ $N -eq 0 ]; then
			sp_head=$(head -1 ${tree}_tips.tmp)
			sp_tail=$(tail -1 ${tree}_tips.tmp)
			echo -e "$species,${sp_head},${sp_tail}" >>add_to_root.tmp
		else
			echo $species >>add_in_auto.tmp
		fi
done
no_genus=$(wc -l add_to_root.tmp|cut -f1 -d' ')
add_auto=$(wc -l add_in_auto.tmp|cut -f1 -d' ')

python /path_to_program/opentree_pytoys/src/add_missing_taxa_auto.py $tree add_in_auto.tmp >tree.tmp 2>runing.log
python /path_to_program/opentree_pytoys/src/add_missing_taxa_mrca.py tree.tmp add_to_root.tmp >${tree}_add.tre 2>>runing.log

after_tip=$(nw_labels -I ${tree}_add.tre|sort|uniq|wc -l |cut -f1 -d' ')

echo -e "${Before_tip},${add_tip},${add_auto},${no_genus},${after_tip}" >>summary.csv

rm ./data/*.tmp