#!/bin/bash
a=$(wc -l tips.txt|cut -f1 -d' ')
b=$(cut -f2 -d'_' Cucurbitaceae_OTL.csv|sort|uniq|wc -l)
faction=$(echo "scale=4;$a/$b"|bc)
echo $faction >sample_probs.txt
for line in `cat tips.txt`; do
	genus=$(echo $line|cut -f2 -d'_')
	N=$(grep -c $genus Cucurbitaceae_OTL.csv)
	f=$(echo "scale=4;1/$N"|bc)
	echo -e "$line\t$genus\t$f" >>sample_probs.txt
done
