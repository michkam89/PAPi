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

THIS IS SCRIPT FOR MAIN PAPi ANALYSIS

_EOF_

# PARAMETERS

# If test data run
MODE=$1
# File with names of genomes used in the analysis
GNAMES=gnames_file.csv
# create temp folder
mkdir tmp
mkdir tmp/other
mkdir plots

# Run test or user mode
if [ "$MODE" = "test" ]; then
  echo "########## PAPi RUNNING IN TEST MODE"
  INPUT=./data/sph_pan_cdhit_output.clstr
  OUTPUT1=./output/core_clust_out
  OUTPUT2=./tmp
  PERM=10
else
  echo "########## PAPi ANALYSIS RUNNING WITH USER INPUT"
  INPUT=$2
  OUTPUT=$3
  PERM=$4
fi

# output for core clusters results
#CORECLUSTO=$OUTPUT/core_clust_out

# Assertions
if [[ ! -e "$INPUT" ]]; then
  echo "INPUT FILE $INPUT DOES NOT EXIST"
  exit 1
fi

# check whether gnames_file was created
if [[ -e "$GNAMES" ]]; then
  echo "########## gnames_file.csv PRESENT"
else
  echo "########## gnames_file NOT PRESENT, PROVIDE gnames_file.csv, EXITING"
  stop
fi

# Run the script generating list of core clusters
echo "EXECUTING COMMAND:
python3 ./code/Get_Core_Clusters_Names.py --input $INPUT --output $OUTPUT1"

echo "########## RUNNING ANALYSIS..."
python3 ./code/Get_Core_Clusters_Names.py --input $INPUT --output $OUTPUT1

# chceck if file was generated
if [[ -e "$OUTPUT1/coreclusters.txt" ]]; then
  echo "########## LIST OF CORE CLUSTERS GENERATED "
else
  echo "########## LIST OF CORE CLUSTERS FAILED, EXITING"
  stop
fi

# Run the script calculating permutations for core genome
echo "EXECUTING COMMAND:
python3 ./code/Calc_Core_Clust_Perm.py --input $INPUT --output $OUTPUT2 --gnames_file $GNAMES --perm $PERM"

echo "########## RUNNING ANALYSIS..."
python3 ./code/Calc_Core_Clust_Perm.py --input $INPUT --output $OUTPUT2 --gnames_file $GNAMES --perm $PERM

ls $OUTPUT2 > $OUTPUT2/other/dirlist.txt
echo "########## FILES CREATED IN $OUTPUT2 DIRECTORY"
grep -E '^[[:digit:]]{1,}.csv' $OUTPUT2/other/dirlist.txt
rm $OUTPUT2/other/dirlist.txt

echo "EXECUTING COMMAND:
python3 ./code/Get_Genome_Cluster_List.py --input $INPUT --output $OUTPUT2"

# creates input for pangenome accumulation plots
python3 ./code/Get_Genome_Cluster_List.py --input $INPUT --output $OUTPUT2

# chceck if file was generated
if [[ -e "$OUTPUT2/input_for_accumulation.tsv" ]]; then
  echo "########## FILE GENERATED "
else
  echo "########## FUNCTION FAILED, EXITING"
  stop
fi

cat << __EOF__
########## Python part completed successfully
########## Starting R PART
__EOF__
echo "########## PLOTTING CORE PANGENOME ACCUMUALTION DATA"

Rscript ./code/core_pangenome_analysis.R

echo "########## PLOTTING PANGENOME ACCUMULATION DATA"
Rscript ./code/pan_accumulation_plot.R

echo "########## THE END OF PAPi ##########"
