#!/bin/bash

name="Cucurbitaceae_5g_family"
cp ../diversification.config ${name}_diversification.config
fraction=$(grep "fraction" ${name}_Priors.txt|cut -f3 -d' ')
Lambda=$(grep "lambdaInitPrior" ${name}_Priors.txt|cut -f3 -d' ')
lambdaShift=$(grep "lambdaShiftPrior" ${name}_Priors.txt|cut -f3 -d' ')
muInitPrior=$(grep "muInitPrior" ${name}_Priors.txt|cut -f3 -d' ')
sed -i -e "s/XXX/${name}.tre/g;s/RRR/$fraction/g;s/YYY/$Lambda/g;s/ZZZ/$lambdaShift/g;s/UUU/$muInitPrior/g" ${name}_diversification.config

