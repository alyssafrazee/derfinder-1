\name{makeModels}
\alias{makeModels}
\title{Build model matrices for differential expression}
\usage{
makeModels(sampleDepths, testvars, adjustvars = NULL, testIntercept = FALSE)
}
\arguments{
  \item{sampleDepths}{Per sample library size adjustments
  calculated with \link{sampleDepth}.}

  \item{testvars}{A vector or matrix specifying the
  variables to test. For example, a factor with the group
  memberships when testing for differences across groups.
  It's length should match the number of columns used from
  \code{coverageInfo$coverage}.}

  \item{adjustvars}{Optional matrix of adjustment variables
  (e.g. measured confounders, output from SVA, etc.) to use
  in fitting linear models to each nucleotide. These
  variables have to be specified by sample and the number
  of rows must match the number of columns used. It will
  also work if it is a vector of the correct length.}

  \item{testIntercept}{If \code{TRUE} then \code{testvars}
  is ignored and mod0 will contain the column medians and
  any adjusting variables specified, but no intercept.}
}
\value{
A list with two components. \describe{ \item{mod }{ The
alternative model matrix.} \item{mod0 }{ The null model
matrix.} }
}
\description{
Builds the model matrices for testing for differential
expression by comparing a model with a grouping factor
versus one without it. It adjusts for the confounders
specified and the median coverage of each sample. The
resulting models can be used in \link{calculateStats}.
}
\examples{
## Collapse the coverage information
collapsedFull <- collapseFullCoverage(list(genomeData$coverage), verbose=TRUE)

## Calculate library size adjustments
sampleDepths <- sampleDepth(collapsedFull, probs=c(0.5), nonzero=TRUE, verbose=TRUE)

## Build the models
group <- genomeInfo$pop
adjustvars <- data.frame(genomeInfo$gender)
models <- makeModels(sampleDepths, testvars=group, adjustvars=adjustvars)
names(models)
models
}
\author{
Leonardo Collado-Torres
}
\seealso{
\link{sampleDepth}, \link{calculateStats}
}

