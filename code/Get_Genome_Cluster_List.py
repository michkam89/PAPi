# -*- coding: utf-8 -*-
"""
Get_Genome_Cluster_List.py
"""
import os
import re
import argparse

#%% PARSE CMD ARGUMENTS
parser = argparse.ArgumentParser(
    description='Get_Genome_Cluster_List.py script to generate input file for Pangenome accumulation analysis. Temp file')

parser.add_argument('--input', dest='inputfile', action='store',
                    help='file with CD-HIT clustering result (.clstr) (required)', required=True)
parser.add_argument('--output', dest='outdir', action='store',
                    help='Output directory (required)', required=True)

args = parser.parse_args()

inputfile = args.inputfile

outdir = args.outdir
os.makedirs(outdir, exist_ok = True)
#%% BLOCK 1
print("###### Pangenome accumulation analysis started...")
gnames_file = open("gnames_file.csv", "r")
gnames = []

for line in gnames_file:
    gnames.append(line[:-1])
gnames_file.close()

if len(gnames) == 0:
    print("######Error: gname file empty!")

#creates dictionary where cluster names are keys and names of bacteria in this cluster are values
dict={}
with open(inputfile) as infile:
    for line in infile:
        if line!='':
            if line[0] == '>':
                cluster_name=line[1:]
                cluster_name=cluster_name[:-1]
                dict[cluster_name]=[]
            else:
                for bacteria in gnames:
                    m=[]
                    m.append(re.findall(bacteria, line))
                    m = list(filter(None, m))
                    dict[cluster_name]=dict[cluster_name]+m

#%%
#create empty file
file =open(os.path.join(outdir, "input_for_accumulation.tsv"), "w")

for key, value in dict.items():
    for genome in value:
        file.write(str(genome) + "\t" + str(key) + "\n")
file.close()
