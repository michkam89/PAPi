# -*- coding: utf-8 -*-
"""
Created on Tue Mar 20 09:21:57 2018

@author: Michal Kaminski
"""
#Pangenome pipeline requires specific naming of fasta header. Must contain
#protein ID and genome name separated by underline sign "_".
#Please name your genome files according to this template:
#Genus_species_strain.faa --> eg. Sphingopyxis_lindanitolerans_WS5A3p.faa
#or
#Genus_sp._strain.faa -->  eg. Sphingopyxis_sp._A083.faa
#%% IMPORT MODULES
import os
import re
import argparse
from Bio import SeqIO
#%% PARSE CMD ARGUMENTS
parser = argparse.ArgumentParser(
    description='Prep_Init_Faa_Files.py script to prepare .faa files for the analysis')

parser.add_argument('--input', dest='inputdir', action='store',
                    help='folder with fasta protein sequences (faa) only (required)', required=True)
parser.add_argument('--output', dest='outdir', action='store',
                    help='Output directory (required)', required=True)

args = parser.parse_args()

inputdir = args.inputdir

outdir = args.outdir
os.makedirs(outdir, exist_ok = True)
#%% GET LIST OF FILES
files = list(os.listdir(inputdir))
print("########## Loaded", len(files), "files...")
#%% POCESSING FILES
# Input sequences should be named after the genomes used. They will be used to
# change name of fasta headers inside the files.
print("########## Processing files...")
gnames = []
n = 0
for file in files:
    n += 1
    basename = re.match("(.*?).faa", file).group(1)
    gnames.append(basename)
    #print(gnames)
    print("File", n, basename)
    input_name = inputdir + '/' + file
    output_name = 'Pangenome_' + file
    output = open(os.path.join(outdir, output_name), "w")
    records = list(SeqIO.parse(input_name, "fasta"))
    for record in records:
        header = record.id + "_" + basename
        seq = str(record.seq)
        output.write(">" + header + "\n" + seq +"\n")
output.close()

gnames_file = open("gnames_file.csv", "w")
for genome in gnames:
        gnames_file.write(genome + "\n")
gnames_file.close()

print("########## Job done, good luck...")
