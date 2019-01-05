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

THIS IS PREPROCESSING SCRIPT FOR MAIN PAPi ANALYSES
_EOF_

# PARAMETERS

# If test data run
MODE=$1
# File with names of genomes used in the analysis
GNAMES=gnames_file.csv


# Run test or user mode
if [ "$MODE" = "test" ]; then
  echo "########## pre-PAPi RUNNING IN TEST MODE"
  INPUT=./data/sph_faa
  OUTPUT=./output
  PERM=100
else
  echo "########## pre-PAPi ANALYSIS RUNNING WITH USER INPUT"
  INPUT=$2
  OUTPUT=$3
  #PERM=$4
fi

# output for core clusters results
#CORECLUSTO=$OUTPUT/core_clust_out

# Assertions
if [[ ! -d "$INPUT" ]]; then
  echo "INPUT DIRECTORY $INPUT DOES NOT EXIST"
  exit 1
fi

# Run the preformating of protein fasta FILES
echo "Executing command:
python3 ./code/Prep_Init_Faa_Files.py --input $INPUT --output $OUTPUT"

echo "########## Formatting fasta files..."
python3 ./code/Prep_Init_Faa_Files.py --input $INPUT --output $OUTPUT

# check whether gnames_file was created
if [[ -e "$GNAMES" ]]; then
  echo "########## gnames_file.csv created"
else
  echo "########## gnames_file not created, exiting"
  stop
fi

echo "NOW PLEASE RUN CD-HIT FOR PROTEIN CLUSTERING"
