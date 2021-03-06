\name{sampleDepth}
\alias{sampleDepth}
\title{Calculate adjustments for library size}
\usage{
sampleDepth(collapsedFull = NULL, probs = c(0.5, 1), nonzero = TRUE,
  scalefac = 32, center = FALSE, verbose = FALSE)
}
\arguments{
  \item{collapsedFull}{The full coverage data collapsed by
  sample as produced by \link{collapseFullCoverage}.}

  \item{probs}{Number(s) between 0 and 1 representing the
  quantile(s) of interest. For example, 0.5 is the median.}

  \item{nonzero}{If \code{TRUE} only the nonzero counts are
  used to calculate the library size adjustment.}

  \item{scalefac}{Number added to the sample coverage
  adjustments before the log2 transformation.}

  \item{center}{If \code{TRUE} the sample coverage
  adjustements are centered. In some cases, this could be
  helpful for interpretation purposes.}

  \item{verbose}{If \code{TRUE} basic status updates will
  be printed along the way.}
}
\value{
A matrix (vector of \code{length(probs) == 1}) with the
library size depth adjustments per sample to be used in
\link{makeModels}. The number of rows corresponds to the
number of quantiles used for the sample adjustments.
}
\description{
For a given data set calculate the per-sample coverage
adjustments. Hector Corrada's group proposed calculating
the sum of the coverage for genes below a given sample
quantile. In this function, we calculate the sample
quantiles of interest by sample, and then the sum of the
coverage for bases below or equal to quantiles of interest.
The resulting values are transformed {log2(x + scalefac)}
to avoid very large numbers that could potentially affect
the stability of the F-statistics calculation. The sample
coverage adjustments are then used in \link{makeModels} for
construcing the null and alternative models.
}
\examples{
## Collapse the coverage information
collapsedFull <- collapseFullCoverage(list(genomeData$coverage), verbose=TRUE)

## Calculate library size adjustments
sampleDepths <- sampleDepth(collapsedFull, probs=c(0.5, 1), nonzero=TRUE, verbose=TRUE)
sampleDepths
}
\author{
Leonardo Collado-Torres
}
\references{
Paulson, J. N., Stine, O. C., Bravo, H. C. & Pop, M.
Differential abundance analysis for microbial marker-gene
surveys. Nat. Methods (2013). doi:10.1038/nmeth.2658
}
\seealso{
\link{collapseFullCoverage}, \link{makeModels}
}

