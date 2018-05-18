#read in csv with NCBI ids converted to KeGG
gencounts <- read.csv( file="normalized_results_nc.csv")

rownames(gencounts)<-gencounts[,1]

gencounts <-gencounts[c(2,3,4,5,6,7)]

cnts.norm=gencounts

kegg.gs=kegg.gsets(species= "ncr",  id.type="kegg")
#data(kegg.gs)

ref.idx=1:3
samp.idx=4:6
#knockdown and control samples are unpaired
cnts.kegg.p <- gage(cnts.norm, gsets = kegg.gs$kg.sets, ref = ref.idx,
                    samp = samp.idx, compare ="unpaired")

greater <- as.matrix(cnts.kegg.p$greater)
less <- as.matrix(cnts.kegg.p$less)
stats <- as.matrix(cnts.kegg.p$stats)


write.csv(as.data.frame(greater), file="greater.csv")
write.csv(as.data.frame(less), file="less.csv")
write.csv(as.data.frame(stats), file="stats.csv")

cnts.d= cnts.norm[, samp.idx]-rowMeans(cnts.norm[, ref.idx])
sel <- cnts.kegg.p$greater[, "p.val"] < 0.1 & !is.na(cnts.kegg.p$greater[, "p.val"])

path.ids <- rownames(cnts.kegg.p$greater)[sel]
sel.l <- cnts.kegg.p$less[, "p.val"] < 0.1 & !is.na(cnts.kegg.p$less[,"p.val"])

path.ids.l <- rownames(cnts.kegg.p$less)[sel.l]
path.ids2 <- substr(c(path.ids, path.ids.l), 1, 8)
path.ids2 <-substr(path.ids2,4,8)
#out top 3 pathways
limit<- list(gene=2, cpd=2)
# only one with hightest p val
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00010', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00500', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00052', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00680', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00030', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00051', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '03013', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)

pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '03013', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '03010', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '04120', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
pv.out  <- pathview(gene.data = cnts.d, gene.idtype = "KEGG" , pathway.id = '00190', xml.file= NULL, limit=limit,species = "ncr", node.sum="mean", kegg.native = TRUE)
