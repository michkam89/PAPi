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
from Bio import SeqIO
#%% GET LIST OF FILES
indir = input("Please specify input directory with .faa files (no quotes): \n To use current working directory press enter \n")

if len(indir) == 0:
    print("No input directory specified. Using current working directory")
    indir = os.getcwd()
    
files = list(os.listdir(indir))

outdir = os.path.join(indir, "output")
os.makedirs(outdir)

print("########## Loaded", len(files), "files.")
#%% POCESSING FILES
# Input sequences should be named after the genomes used. They will be used to
# change name of fasta headers inside the files.
print("########## Processing files...")
n = 0
for file in files:
    n += 1
    basename = re.match("(.*?).faa", file).group(1)
    print("File", n, basename)
    input_name = indir + '\\' + file
    output_name = 'Pangenome_' + file
    output = open(os.path.join(outdir, output_name), "x")
    records = list(SeqIO.parse(input_name, "fasta"))
    for record in records:
        header = record.id + "_" + basename
        seq = str(record.seq)
        output.write(">" + header + "\n" + seq +"\n")
output.close()
print("########## Job done, good luck...")