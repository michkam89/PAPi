# PAPi (Pangenome Analysis Pipeline)
in development

The analysis is designed to calculate core-pangenome for defined dataset of given protein sequences.
At the moment PAPi in not self-sufficient and require some user effort.
User should provide .faa files with appropriately formatted fasta headers and file names:

Fasta header must contain protein ID and genome name separated by underscore sign

Please name your genome files according to this template:
 - Genus_species_strain.faa eg. Sphingopyxis_lindanitolerans_WS5A3p.faa
 - Genus_sp.\_strain.faa eg. Sphingopyxis_sp.\_A083.faa

#2 PREPROCESS FAA FILES

1. Run "pre_papi.sh test" command to check if preprocessing step works correctly
2. Run "pre_papi.sh user your/input/dir your/output/dir"
- your input directory should contain only .faa files
3. When script is completed please run CD-HIT program with your own PARAMETERS
 ^ and provide the .clstr file for further analyses 
