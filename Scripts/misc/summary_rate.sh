#!/bin/bahs

echo "Order, SpeciationRate, Tiprate" >rosid_17order_100k_BAMM_meanrates.csv

for order in `cat Order`; do
	#sed -i '1d' ${order}/result/${order}_BAMM_mean_TipSpeciation_Rates.csv
	SpeciationRate=$(sed -n '1d;p;n' ${order}/result/${order}_BAMM_mean_TipSpeciation_Rates.csv|cut -f2 -d',' )
	TipRate=$(sed -n 'p;n' ${order}/result/${order}_BAMM_mean_TipSpeciation_Rates.csv|cut -f2 -d',' )
	echo -e "$order, $SpeciationRate, $TipRate" >>rosid_17order_100k_BAMM_meanrates.csv
done