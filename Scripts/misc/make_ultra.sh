#!/bin/bash

# All the trees are dated, and ultrametric;
# But different OSs have different convents of round up maximum digits for the branch length info;
# This bash script together with R script "make_ultra.R" to adjust this issue, making trees 
# ultrametric to facilitate downstream diversification analyses.
ml R
for order in Celastrales Crossosomatales Cucurbitales Fabales Fagales Geraniales Huerteales Malpighiales Malvales Myrtales Oxalidales Picramniales Rosales Sapindales Zygophyllales
	do
		cd $order
		rm *_1.txt
		cp ../make_ultra.R ./
		Rscript make_ultra.R
		rm *_ultramatric_extend.tre
		sed -i 's/_ultramatric_extend.tre/_ultrametric_extend.tre/g' ${order}_diversification.config
		cd ..
done
