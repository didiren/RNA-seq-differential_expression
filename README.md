# RNA-seq-differential_expression pipeline
#Prepare a text file (parameters.txt) with the RNA-seq files names one per each line as well as the paired end files are next to each other.
Here is the example attached that you can download and edit based on your projects:

#This parameters.txt file, the RNA-seq-differential_expression.py file as well as the RNA-seq raw reads files should be in the same directory (one folder).


#The pipeline will generate the outputs (reads count text files only) in one folder, which should be set as the working directory for running the R script, DESeq2.R.


#Depend on if your organims have the database in KEGG, BLASTp is optional step here to convert the ID to the ID system compatible in KEGG.
With a normalied_combined_file.txt ready, the GAGE.R is the next step to highlight the significantly regulated pathways and visualize them with Pathview.


Good luck.
