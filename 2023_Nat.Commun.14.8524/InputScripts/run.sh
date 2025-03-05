#!/bin/bash

module load hdf5 boost openBLAS

###############################################################
./dmrg -f gs.inp

./observe -f gs.inp "<gs|splus?0;sminus?0|gs>" >> corr_pm0.txt
./observe -f gs.inp "<gs|splus?1;sminus?1|gs>" >> corr_pm1.txt
./observe -f gs.inp "<gs|sz?0;sz?0|gs>" >> corr_zz0.txt
./observe -f gs.inp "<gs|sz?1;sz?1|gs>" >> corr_zz1.txt
./observe -f gs.inp "<gs|sz?0|gs>" >> corr_locs0.txt
./observe -f gs.inp "<gs|sz?1|gs>" >> corr_locs1.txt
./observe -f gs.inp "<gs|splus?0+splus?1;sminus?0+sminus?1|gs>" >> corr_pmt.txt
./observe -f gs.inp "<gs|sz?0+sz?1;sz?0+sz?1|gs>" >> corr_zzt.txt

grep Entropy runForgs.cout | awk '{print $4, $7}' | sed 's/EntropyReyni=//g' | sed 's/;//g' >& entropy.txt

###############################################################
./dmrg -f dynamics.inp "<gs|sz?0+sz?1|P2>,<gs|sz?0+sz?1|P3>"

rm *.hd5
