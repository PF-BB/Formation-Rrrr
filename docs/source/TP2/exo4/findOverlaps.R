library("GenomicRanges")
library(plyr)

# create a test matrix with coordinates of transcripts
data <- data.frame(chr = rep('chr1',6),
                   start = c(66999824,33546713,48998526,16767166,16767166,8384389),
                   end = c(67210768,33585995,50489626,16786584,16786584,8404227),
                   id = c('NM_032291','NM_052998','NM_032785','NM_001145278','NM_001145277','NM_001080397'),
                   score = rep(0,6),
                   strand = c('+','+','-','+','+','+'),
                   stringsAsFactors=F)
cat('data :\n')
print(data)
cat('\n\n')

# create a test matrix with coordinates of snps
my_snp <- data.frame(chr = c(rep('chr1',4),'chr3'),
                     start = c(66999900,67052900,33546793,48998626, 1256896),
                     end = c(66999901,67052901,33546794,48998627,1256897),
                     id = c('snp1','snp2','snp3','snp4','snp5'),
                     score = rep(0,5),
                     strand = c('+','+','+','-','-'),
                     stringsAsFactors=F)
cat('my_snp :\n')
print(my_snp)
cat('\n\n')

# create 2 objects of class GRanges
data_grange <- with(data,
                    GRanges(chr, IRanges(start,end,names=id),
                    strand
                    )
)

snp_grange <- with(my_snp,
                   GRanges(chr, IRanges(start,end,names=id),
                   strand
                   )
)

# count overlaps between transcripts and snps
counts = countOverlaps(data_grange, snp_grange,ignore.strand=FALSE)
counts = data.frame(query=names(counts), number=counts)
cat('counts :\n')
print(counts)
cat('\n\n')

# find overlaps between transcripts and snps
overlaps <- findOverlaps(data_grange, snp_grange,ignore.strand=FALSE)
match_hit <- data.frame(names(data_grange)[queryHits(overlaps)],
                        names(snp_grange)[subjectHits(overlaps)],
                        stringsAsFactors=F
)

names(match_hit) <- c('query','subject')
cat('match_hit : \n')
print(match_hit)
cat('\n')

#create final matrix of results
match_hit_uniq = ddply(match_hit, .(query), summarize, subject = paste(subject, collapse = ';'))
match_hit_uniq = merge(match_hit_uniq, counts, by="query", by.y=0,all.y=TRUE)

cat('Final results\n')
print(match_hit_uniq)