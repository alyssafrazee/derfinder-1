#' Make clusters of genomic locations based on distance in Rle() world
#'
#' Genomic locations are grouped into clusters based on distance: locations that are close to each other are assigned to the same cluster. The operation is performed on each chromosome independently. This is very similar to \link[bumphunter]{clusterMaker}.
#'
#' @details
#' \link[bumphunter]{clusterMaker} adapted to Rle world. Assumes that the data is sorted and that everything is in a single chromosome.
#' It is also almost as fast as the original version with the advantage that everything is in Rle() world.
#' 
#' It is a a helper function for \link{findRegions}.
#' 
#' @param pos A logical Rle indicating the chromosome positions.
#' @param maxGap An integer. Genomic locations within \code{maxGap} from each other are placed into the same cluster.
#'
#' @return An integer Rle with the cluster IDs.
#'
#' @seealso \link[bumphunter]{clusterMaker}, \link{findRegions}
#' @author Leonardo Collado-Torres
#' @export
#' @importFrom IRanges IRanges start end runValue reduce Views Rle
#' @importMethodsFrom IRanges length sum
#' @examples
#' library("IRanges")
#' set.seed(20130725)
#' pos <- Rle(sample(c(TRUE, FALSE), 1e5, TRUE, prob=c(0.05, 0.95)))
#' cluster <- clusterMakerRle(pos, 100L)
#' cluster
#' 
#' \dontrun{
#' ## clusterMakerRle() is comparable in speed if you start from the Rle world.
#' library("bumphunter")
#' library("microbenchmark")
#' micro <- microbenchmark(clusterMakerRle(pos, 100L), clusterMaker(chr=rep("chr21", sum(pos)), pos=which(pos)))
#' micro
#' }

clusterMakerRle <- function(pos, maxGap=300L) {
	## Instead of using which(), identify the regions of the chr with data
	ir <- IRanges(start=start(pos)[runValue(pos)], end=end(pos)[runValue(pos)])
	
	## Apply the gap reduction
	ir.red <-  reduce(ir, min.gapwidth=maxGap + 1)
	
	## Identify the clusters
	clusterIDs <- Rle(seq_len(length(ir.red)), sum(Views(pos, ir.red)))
	## Note that sum(Views(pos, ir.red)) is faster than sapply(ir.red, function(x) sum(pos[x]))
	
	## Done
	return(clusterIDs)
}