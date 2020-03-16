#!/bin/bash
# the range of orders can be modified
for order in Celastrales Geraniales Picramniales Huerteales Vitales Crossosomatales Zygophyllales Fagales Oxalidales; do
	echo $order
	cat $order/${order}_event_data*.txt|sed '/generation,/d' >$order/${order}_event_data_final.txt
# insert a new header
	sed -i '' '1 i generation,leftchild,rightchild,abstime,lambdainit,lambdashift,muinit,mushift' $order/${order}_event_data_final.txt
done
