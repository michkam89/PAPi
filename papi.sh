#!/bin/bash

cat << _EOF_

################################
#   #####    #     #####    #  #
#   #   #   # #    #   #       #
#   # # #  #   #   # # #    #  #
#   #      #####   #        #  #
#   #      #   #   #        #  #
#  Pangenome Analysis Pipeline #
################################

Licensed under GNU General Public License v2.0

_EOF_

# If test data run
MODE=$1

if [ "$MODE" = "test" ]; then
  echo "########## PAPi RUNNING IN TEST MODE"
  INPUT=./data/sph_faa
  OUTPUT=./output
else
  echo "########## PAPi ANALYSIS RUNNING WITH USER INPUT"
  INPUT=$2
  OUTPUT=$3
fi

# Run the preformating of protein fasta FILES
echo "Executing command:
python3 ./code/Prep_Init_Faa_Files.py --input $INPUT --output $OUTPUT"

echo "########## Formatting fasta files..."
python3 ./code/Prep_Init_Faa_Files.py --input $INPUT --output $OUTPUT
