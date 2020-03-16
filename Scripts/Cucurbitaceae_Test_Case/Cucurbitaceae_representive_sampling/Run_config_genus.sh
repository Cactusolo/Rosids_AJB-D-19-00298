#!/bin/bash

name="Cucurbitaceae_5g_genus"
cp diversification.config Run_genus/${name}_diversification.config
fraction=$(grep "fraction" BAMM_Priors/${name}_Priors.txt|cut -f3 -d' ')
Lambda=$(grep "lambdaInitPrior" BAMM_Priors/${name}_Priors.txt|cut -f3 -d' ')
lambdaShift=$(grep "lambdaShiftPrior" BAMM_Priors/${name}_Priors.txt|cut -f3 -d' ')
muInitPrior=$(grep "muInitPrior" BAMM_Priors/${name}_Priors.txt|cut -f3 -d' ')
sed -i -e "s/XXX/${name}.tre/g;s/RRR/$fraction/g;s/YYY/$Lambda/g;s/ZZZ/$lambdaShift/g;s/UUU/$muInitPrior/g" Run_genus/${name}_diversification.config

