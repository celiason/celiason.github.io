#

library(ape)
library(paleotree)


dat <- readxl::read_excel("/Users/chadeliason/Desktop/research topics.xlsx")

dat$proj <- abbreviate(dat$project, 6)

tags <- strsplit(as.character(dat$tags), ",")

tags <- sapply(tags, as.numeric)

num <- sequence(max(unlist(tags)))

names(tags) <- dat$proj

M <- sapply(seq_along(tags), function(x) {
	ifelse(num %in% tags[[x]], 1, 0)
})

# image(M)
colnames(M) <- dat$project
M <- t(M)

dmat <- dist(M)

hc <- hclust(dmat)

tree <- as.phylo(hc)

# plot(tree, no.margin=TRUE)


year <- as.numeric(str_extract(Sys.Date(), "\\d+"))

timeData <- abs(cbind(dat$year, dat$year) - year)
rownames(timeData) <- dat$project

tree2 <- timePaleoPhy(tree=tree, timeData=timeData, type="mbl", vartime=1, ntrees=1, randres=FALSE, timeres=FALSE, add.term=FALSE, inc.term.adj=FALSE, dateTreatment="firstLast", node.mins=NULL, noisyDrop=TRUE, plot=FALSE)

# cats <- list('evolution'=1:6, 'behavior'=c(7:8, 15:18), 'biomechanics'=9:14)
# cats <- unlist(cats)
# names(cats) <- gsub("[0-9]$", "", names(cats))
# n <- length(unique(names(cats)))
# pal <- brewer.pal(n, "Set1")
# names(pal) <- unique(names(cats))
# edgecol <- pal[names(cats)[match(tree2$edge[, 2], cats)]]
# edgecol <- ifelse(is.na(edgecol), "gray", edgecol)

pdf("~/Desktop/research_topics.pdf", width=5, height=6)
# par(mar=c(3,1,3,0))
par(mar=rep(0,4), mgp=c(1.5,.5,0), ps=10, mex=.75)
plot(tree2, edge.width=3, edge.col='gray', no.margin=TRUE)
# plot(tree2, edge.col=edgecol, edge.width=3)
axisPhylo(lwd=1, col='gray')
# legend("bottomleft", bty="n", lty=1, legend=names(pal), col=pal, lwd=3)
dev.off()
