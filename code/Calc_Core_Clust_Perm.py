#!/usr/bin/python
#-*- coding: utf-8 -*-
"""
core_clusters_permutations.py
"""
import os
import re
import argparse
#%% PARSE CMD ARGUMENTS
parser = argparse.ArgumentParser(
    description='core_clusters_permutations.py script to generate .csv files for core protein clusters while adding new genome to dataset')

parser.add_argument('--input', dest='inputfile', action='store',
                    help='folder with fasta protein sequences (faa) only (required)', required=True)
parser.add_argument('--output', dest='outdir', action='store',
                    help='Output directory (required)', required=True)
parser.add_argument('--gnames_file', dest='gnames_file', action='store',
                    help='Output directory (required)', required=True)
parser.add_argument('--perm', dest='max_permutation_num', action='store',
                    help='Output directory (required)', required=True)
args = parser.parse_args()

inputfile = args.inputfile
outdir = args.outdir
gnames_file = args.gnames_file
max_permutation_num = args.max_permutation_num

# create output dir in overwrite mode
os.makedirs(outdir, exist_ok = True)

#%% Prepare gnames_lst
print("###### Processing gname file")
gnames = open(gnames_file, "r")
gnames_lst = []
for line in gnames:
    gnames_lst.append(line[:-1])
gnames.close()
#print("DONE")
#%% get standard dictionary dictionary
#print("Preparing standard dict")
dict={}
with open(inputfile) as infile:
    for line in infile:
        if line!='':
            if line[0] == '>':
                cluster_name=line[1:]
                cluster_name=cluster_name[:-1]
                dict[cluster_name]=[]
            else:
                for bacteria in gnames_lst:
                    m=[]
                    m.append(re.findall(bacteria, line))
                    m = list(filter(None, m))
                    dict[cluster_name]=dict[cluster_name]+m
#print("DONE")
#%%
import itertools
import operator
from functools import reduce
print("###### Calculating permutations. This may take a while...")
gnames_count = len(gnames_lst)
for i in range(1, gnames_count+1):
    print("Genome set: ", i)
    combinations = i

    iterations = list(itertools.islice(itertools.combinations(gnames_lst, combinations), int(max_permutation_num)))
    sum_of_clusters_all = 0
    pair = 0

    file = open(os.path.join(outdir, str(combinations) + ".csv"), "w")
    file.write("CombID"+","+str(combinations)+"\n")
    for iteration in iterations:
        pair += 1
        matches = []
        for key, value in dict.items():
            if len(value) > 1:
                x = 0
                reduced_value = reduce(operator.add, value)
                match = set(iteration).intersection(reduced_value)
                if len(match) == combinations:
                    x += 1
                    matches.append(match)
        file.write("Pair" + str(pair) + "," + str(len(matches)) + "\n")
    file.close()
print("###### DONE")
