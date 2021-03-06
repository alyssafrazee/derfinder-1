\name{makeBamList}
\alias{makeBamList}
\title{Construct full paths to a group of BAM files}
\usage{
makeBamList(datadir = NULL, sampledirs = NULL, samplepatt = NULL,
  bamterm = "accepted_hits.bam")
}
\arguments{
  \item{datadir}{The main directory where each of the
  \code{sampledirs} is a sub-directory of \code{datadir}.}

  \item{sampledirs}{A character vector with the names of
  the sample directories. If \code{datadir} is \code{NULL}
  it is then assumed that \code{sampledirs} specifies the
  full path to each sample.}

  \item{samplepatt}{If specified and \code{sampledirs} is
  set to \code{NULL}, then the directories matching this
  pattern in \code{datadir} (set to \code{.} if it's set to
  \code{NULL}) are used as the sample directories.}

  \item{bamterm}{Name of the BAM file used in each sample.
  By default it is set to \code{accepted_hits.bam} since
  that is the automatic name generated when aligning with
  TopHat. If \code{NULL} it is then ignored when reading
  the BAM files. This can be useful if all the BAM files
  are stored in a single directory.}
}
\value{
A vector with the full paths to the BAM files and sample
names stored as the vector names.
}
\description{
For a group of samples this function creates the list of
paths to the BAM files which can then be used in
\link{loadCoverage}.
}
\examples{
datadir <- system.file("extdata", "genomeData", package="derfinder")
dirs <- makeBamList(datadir=datadir, samplepatt="*accepted_hits.bam$", bamterm=NULL)
dirs
}
\author{
Leonardo Collado-Torres
}
\seealso{
\link{loadCoverage}
}

