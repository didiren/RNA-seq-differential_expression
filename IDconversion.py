#create dictionary for EP id to NC id
        
combined={}
inf2=open('normalied_combined_file.txt','r')
a=inf2.readline()
for line in inf2:
    line=line.strip()
    fields=line.split('\t')
    if len(fields)>6:
        combined[fields[0]]=(fields[1],fields[2],fields[3],fields[4],fields[5],fields[6])
inf2.close()
combined1={}
inf1=open('twoorganims_idlink.out','r')

for line in inf1:
    line=line.strip()
    fields=line.split('\t')
    for k in combined.keys():
        if k ==fields[0]:
            combined1[fields[1][0:8]]=combined[k]
inf1.close()

        
outf=open('normalied_combined_file_keggID.txt','w')
print(len(combined1))
for k,v in combined1.items():

    outf.write(k+'\t'+v[0]+'\t'+v[1]+'\t'+v[2]+'\t'+v[3]+'\t'+v[4]+'\t'+v[5]+'\n')

outf.close()
