#!/bin/bash

echo "Tip_label,Rate" >../../../../boxplot/data/Cucurbitaceae_5g_genus_10_BAMM_TipRate.csv
cat Cucurbitaceae_5g_genus_*_BAMM_TipRates.csv|sed '/Tip_label,Rate/d' >>../../../../boxplot/data/Cucurbitaceae_5g_genus_10_BAMM_specific_TipRate.csv

#echo "Time,SpeciationRate" >../../../../boxplot/data/Cucurbitaceae_5g_genus_10_BAMM_SpeciationRate.csv
#cat Cucurbitaceae_5g_genus_*_BAMM_median_speciation_rates.csv |sed '1d' >>../../../../boxplot/data/Cucurbitaceae_5g_genus_10_BAMM_SpeciationRate.csv