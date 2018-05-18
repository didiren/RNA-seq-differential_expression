#Note: For using this pipeline, you need have the basic skill to install all softwares it required or have a server having all of them installed for you. Meanwhile, a little bit of skill of editing python scripts and R scripts is helpful too.

# RNA-seq-differential_expression pipeline
#Prepare a text file (parameters.txt) with the RNA-seq files names one per each line as well as the paired end files are next to each other.

#Here is a example parameters.txt file attached that you can download and edit based on your projects:

#This parameters.txt file, the RNA-seq-differential_expression.py file as well as the RNA-seq raw reads files should be in the same directory (one folder).

#The command for your to run. Please open the RNA-seq-differential_expression.py and edit it following the instruction in file if you don't need to use trimming process.

# python RNA-seq-differntial_expression.py 

#The pipeline will generate the outputs (reads count text files only) in each index folder

#The txt file from the control_index* and treatment_index* folders should be the reads count file for each sample.

#All txt file should be moved to a new foler that will be set as the working directory for running the R script, DESeq2.R (attached here too).

#You can run the R scirpt in LINUX without R studio by using the command:

# Rscript DESeq.R

#Or you can download DESeq.R file and open it to run in R studio.


# The optional step here depends on if your organims have the database in KEGG

#If you don't like my case, BLASTp is  step here to convert the ID to the ID system compatible in KEGG.The command you might need to use:

# makeblastdb -in your_KEGG_most_related_organism_proteom.fsa -parse_seqids -dbtype prot -out mydb

# blastp -num_threads 8 -query your.organims.protein.fa -outfomt 6 -max_target_seqs 1 -db mydb -out twoorganims_idlink

#Now with a twoorganims_idlink.txt file the first and second columns are your ID conversion source.

#With a normalized_combined_file.txt generated from the DESeq.R, its a table with your organism ID with the expression level from each sample.

#Here a small python file IDconversion.py I used to convert your organism ID from the normalization file to the KEGG most related organism ID.

#Again, the normalized_combined_file.txt, IDconversion.py and the output from blastp twoorganims_idlink.out, three files must be in the same folder for it to work. The simple command:

# python IDconversion.py

#Now in the normalized_combined_file_keggID.txt file, it was ready to feed the GAGE and pathview packages in R to generate the significantly regulated metabolism pathways and visulized them.The GAGE.R file contains the scripts I use for my project. You can adopt all scripts for running the GAGE but the pathview need to feed one pathway number each time, you might need to replace the pathway.id based on the pathway interested to you for your project. And it is better to do this in R studio.

# You might need to twist a little for using GAGE.R

Good luck.
