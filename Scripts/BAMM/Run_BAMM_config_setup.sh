#!/bin/bash
while read -r order; do
	echo $order
	mkdir -p $order
	cd $order
	cp ../diversification.config ${order}_PB_diversification.config
	mv ../${order}.tre .
	Shifts=$(grep $order ../expectedNumberOfShifts.csv|cut -f2 -d'=')
	Fraction=$(grep "fraction" ../BAMM_Priors/${order}_Priors.txt|cut -f3 -d' ')
	Lambda=$(grep "lambdaInitPrior" ../BAMM_Priors/${order}_Priors.txt|cut -f3 -d' ')
	lambdaShift=$(grep "lambdaShiftPrior" ../BAMM_Priors/${order}_Priors.txt|cut -f3 -d' ')
	muInitPrior=$(grep "muInitPrior" ../BAMM_Priors/${order}_Priors.txt|cut -f3 -d' ')
	sed -i -e "s/XXX/$order/g;s/RRR/$Shifts/g;s/TTT/$Fraction/g;s/YYY/$Lambda/g;s/ZZZ/$lambdaShift/g;s/UUU/$muInitPrior/g" ${order}_PB_diversification.config
	cd ..
done<Order
exit 0
