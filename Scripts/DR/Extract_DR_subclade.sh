#!/bin/bash
#this script firstly get tips for each subclade (order) tree;
#then extra DR rate for each tip from a table with DR rates calculated from the whole tree (see "DR_statistic.R")
#define the path for the directory of subclade tree
path="./data/100k-tip_tree/"

#required Newick Utilities (http://cegg.unige.ch/newick_utils) installed.


for order in `cat Order.txt`; do
	nw_labels -I ${path}/${order}_otl.tre >./data/${order}_otl_tip.txt
	wc -l ./data/${order}_otl_tip.txt
	echo "Tip_lable,DR_rates" >rosid_otl_clade_DR/rosid_otl_${order}_DR.csv
	grep -f ./data/${order}_otl_tip.txt rosids_otl_tip_DR.csv >>rosid_otl_clade_DR/rosid_otl_${order}_DR.csv
	wc -l rosid_otl_clade_DR/rosid_otl_${order}_DR.csv
done