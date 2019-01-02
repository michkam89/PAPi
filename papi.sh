#!/bin/bash

echo "
################################
#   #####    #     #####    #  #
#   #   #   # #    #   #       #
#   # # #  #####   # # #    #  #
#   #      #   #   #        #  #
#  Pangenome Analysis Pipeline #
################################

Licensed under GNU General Public License v2.0

"
# If test data run $test

# Run the preformating of protein fasta FILES
echo "########## Formatting fasta files..."
python3 ./code/Prep_Init_Faa_Files.py --input ./data/sph_faa --output ./output
