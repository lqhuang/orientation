#!/bin/bash

# source 
source /vol7/home/lqhuang/.bashrc

### cd work dir
cd /vol7/home/lqhuang/Documents/MATLAB/orientation/test_script/

### run
matlab -nodesktop -nodisplay -nosplash -r "try, run('/vol7/home/lqhuang/Documents/MATLAB/orientation/test_script/m_runscript.m'), catch,  exit(1), end, exit(0);" > /vol7/home/lqhuang/Documents/MATLAB/orientation/test_script/run.txt


# echo "matlab exit code: $?"