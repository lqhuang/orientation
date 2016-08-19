#!/bin/bash
#PBS -V
#PBS -q batch 
#PBS -l walltime=2400:00:00
#PBS -l nodes=1:ppn=1
#PBS -l ncpus=10
#PBS -k eo

### cd work dir
cd ~/Documents/MATLAB/orientation/test_script/
### run
matlab -nodesktop -nodisplay -nosplash -r "try, run('/home/lqhuang/Documents/MATLAB/orientation/test_script/m_runscript_3.m'), catch,  exit(1), end, exit(0);" > ~/Documents/MATLAB/orientation/test_script/run.txt


# echo "matlab exit code: $?"
