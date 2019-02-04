# -*- coding: utf-8 -*-
"""
Returns file named coreclusters.txt with core protein cluster list
"""
import os
import re
import argparse

#%% PARSE CMD ARGUMENTS
parser = argparse.ArgumentParser(
    description='Prep_Init_Faa_Files.py script to prepare .faa files for the analysis')

parser.add_argument('--input', dest='inputfile', action='store',
                    help='file with CD-HIT clustering result (.clstr) (required)', required=True)
parser.add_argument('--output', dest='outdir', action='store',
                    help='Output directory (required)', required=True)

args = parser.parse_args()

inputfile = args.inputfile

outdir = args.outdir
os.makedirs(outdir, exist_ok = True)
#%% BLOCK 1
print("###### Core pangenome clusters analysis started...")
# read gnames_file.csv
gnames_file = open("gnames_file.csv", "r")
# make list
gnames = []
for line in gnames_file:
    gnames.append(line[:-1])
gnames_file.close()
# check if not empty
if len(gnames) == 0:
    print("###### Error: gname file empty!")

# create dictionary where cluster names are keys and names of bacteria in this
# cluster are values
dict={}
with open(inputfile) as infile:
    for line in infile:
        # line not empty
        if line !='':
            # protein cluster
            if line[0] == '>':
                cluster_name=line[1:]
                cluster_name=cluster_name[:-1]
                dict[cluster_name]=[]
            # bacteria having this cluster
            else:
                # look if bacteria from gnames_file is in the line
                for bacteria in gnames:
                    m=[]
                    m.append(re.findall(bacteria, line))
                    # remove missing values from regex
                    m = list(filter(None, m))
                    dict[cluster_name]=dict[cluster_name]+m

if len(dict) == 39909:
    print("###### Test 1 OK")
else:
    print("###### Dictionary test failed")
#%% BOCK2 Retreive initial complete clusters
gcount = len(gnames)

def uniq(lst):
    last = object()
    for item in lst:
        if item == last:
            continue
        yield item
        last = item

# clusters that appeared in all genomes
clusters_complete=[]
# clusters that appeared in some genomes more than once
clusters_complete_duplicates=[]
for key, value in dict.items():
    if len(value) == gcount:
        clusters_complete.append(key)
        if len(value) != len(list(uniq(value))):
            clusters_complete_duplicates.append(key)

print("###### There are ",
    len(clusters_complete),
    "complete clusters, and ",
    len(clusters_complete_duplicates),
    "that have duplicates")

#%% BLOCK 3 Recover clusters and add to complete
clusters_oversize=[]
clusters_oversize_duplicates=[]
clusters_to_recover=[]
for key, value in dict.items():
    if len(value) > gcount:
        clusters_oversize.append(key)
        if len(value) != len(list(uniq(value))):
            clusters_oversize_duplicates.append(key)
            if len(list(uniq(value))) == gcount:
                clusters_to_recover.append(key)

print("###### There are ",
    len(clusters_to_recover),
    "potential protein clusters available for recovery")

core_clusters=[x for x in clusters_complete if x not in clusters_complete_duplicates]
core_clusters=core_clusters+clusters_to_recover

print("###### Final number of core clusters: ",
    len(core_clusters),
    "Saving them into coreclusters.txt file")

#%% SAVE FILE
fcore_clusters = open(os.path.join(outdir, "coreclusters.txt"), "w")
for cluster in core_clusters:
    fcore_clusters.write(cluster + "\n")
fcore_clusters.close()
