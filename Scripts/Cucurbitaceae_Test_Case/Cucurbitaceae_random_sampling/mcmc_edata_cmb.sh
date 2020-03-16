#! /bin/bash
for i in {1..40}; do
	name=$(sed -n ${i}p list)
	cat ${name}_mcmc_out_*.txt|sed '/generation,/d' >${name}_mcmc_out_cmb.csv
	sed -i '1 i generation,N_shifts,logPrior,logLik,eventRate,acceptRate' ${name}_mcmc_out_cmb.csv
	cat ${name}_event_data_*.txt|sed '/generation,/d' >${name}_event_data_cmb.csv
	sed -i '1 i generation,leftchild,rightchild,abstime,lambdainit,lambdashift,muinit,mushift' ${name}_event_data_cmb.csv
done
wc -l *.csv