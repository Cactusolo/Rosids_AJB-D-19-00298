#!/bin/bash
order=$1
echo $order
cd $order
cp ../diversification.config ${order}_diversification.config
Shifts=$(grep $order ../expectedNumberOfShifts.csv|cut -f2 -d'=')
Lambda=$(grep "lambdaInitPrior" ${order}_Priors.txt|cut -f3 -d' ')
lambdaShift=$(grep "lambdaShiftPrior" ${order}_Priors.txt|cut -f3 -d' ')
muInitPrior=$(grep "muInitPrior" ${order}_Priors.txt|cut -f3 -d' ')
sed -i -e "s/XXX/$order/g;s/RRR/$Shifts/g;s/YYY/$Lambda/g;s/ZZZ/$lambdaShift/g;s/UUU/$muInitPrior/g" ${order}_diversification.config
cd ..
