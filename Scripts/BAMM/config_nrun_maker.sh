#!/bin/bash

#reprun=$1
#
#d=`echo $reprun -1|bc`
#tt=`echo $reprun -2|bc`
#cp BAMM${d}.sbatch BAMM${reprun}.sbatch
#sed -i "s/_${d}.config/_${reprun}.config/g" BAMM${reprun}.sbatch

#for i in 1 4 6 10 11 14 15; do
for i in 5 9; do
		clade=$(sed -n ${i}p Order)
		cd $clade
		cp ${clade}_PB_diversification.config ${clade}_PB_diversification_2.config
		sed -i -e "s/_info.txt/_info_2.txt/g;s/_out.txt/_out_2.txt/g;s/_data.txt/_data_2.txt/g;s/_PB.txt/_PB_2.txt/g;s/loadEventData = 0/loadEventData = 1/g;s/#eventDataInfile = event_data_6th.txt/eventDataInfile = ${clade}_PB_event_data.txt/g;s/4000000/80000000/g" ${clade}_PB_diversification_2.config
		cd ..
done


#reprun=$1
## 5 9
#for i in 1 4 6 10 11 14 15
#	do
#		clade=$(sed -n ${i}p Order)
#		cd clade/
#		echo $clade
#		if [ $reprun -eq 2 ] ; then
#			cp ${clade}_PB_diversification.config ${clade}_PB_diversification_${reprun}.config
#		else
#		
#		fi
#		cp ${clade}_PB_diversification.config ${clade}_PB_diversification_${reprun}.config
#		sed -ie "s/_1.txt/_${reprun}.txt/g;s/loadEventData = 0/loadEventData = 1/g;s/#eventDataInfile = event_data_6th.txt/eventDataInfile = ${clade}_drop.tre_event_data_1.txt/g" ${clade}_diversification_${reprun}.config
#		cd ..
#done


