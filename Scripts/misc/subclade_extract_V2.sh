#!/bin/bash
ml phyx
for clade in `cat Order`; do
	echo $clade
	pxmrcacut -t ../ALLOTB_rosid_106910_final.tre -m ${clade}/${clade}_mrca.txt >${clade}/${clade}_ALLOTB.tre
	pxlstr -t ${clade}/${clade}_ALLOTB.tre
done
