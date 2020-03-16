#! /bin/bash

#mkdir data
#mv mcmc_check/* BAMM_17order_PB_table.csv data

#rmdir mcmc_check

for i in 10 11 12 13 14 15 16 17; do
#for i in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17; do
	name=$(sed -n ${i}p Order)
	echo $name
	#if [ -e ${name}_PB_mcmc_out_cmb.csv ]; then
	#	rm ${name}_PB_mcmc_out_cmb.csv
	#else
		#cat ./$name/${name}_PB_mcmc_out*.txt|sed '/generation,/d' >./mcmc_check/${name}_PB_mcmc_out_cmb.csv
	#fi
	
	if [ -e ./data/${name}.tre ]; then
               ls ./data/ ${name}.tre
	else
		mv ./$name/${name}.tre data
	fi

	cat ./$name/${name}_PB_event_data*.txt|sed '/generation,/d' >./data/${name}_PB_eventdata_cmb.csv
	#sed -i '1 i generation,N_shifts,logPrior,logLik,eventRate,acceptRate' ./mcmc_check/${name}_PB_mcmc_out_cmb.csv
	sed -i '1 i generation,leftchild,rightchild,abstime,lambdainit,lambdashift,muinit,mushift' ./data/${name}_PB_eventdata_cmb.csv
done

