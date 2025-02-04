% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AF.Echidna.R
\name{plot}
\alias{plot}
\alias{plot.esR}
\title{output model diagnose results}
\usage{
plot(object, idx = NULL, mulT = FALSE, meanN = 2.5)

\method{plot}{esR}(object, idx = NULL, mulT = FALSE, meanN = 2.5)
}
\arguments{
\item{object}{an object of Echidna-R result.}

\item{idx}{trait order(1,2,...) when use !cycle in Echidna.}

\item{mulT}{multi-trait model,FALSE(default).}

\item{meanN}{make hat(y) higher than 4*mean(y) to NA.}
}
\value{
the result is returned directly.
}
\description{
\code{plot} This function output model diagnose results.
}
\details{
Test trait's norm for Echidna object,similar to asreml.
}
\examples{

\dontrun{
library(AFEchidna)

 ##  Echidna
 path='D:/Echidna/Jobs/METb11'

 #  mainly works for '_e.R'
 res<-esRT(path=path,trace=T) # for single trait

 names(res)
 class(res)

 # check .esy exist or not
 plot(res)
}

}
\references{
Yuanzhen Lin. R & ASReml-R Statistics. China Forestry Publishing House. 2016
}
\author{
Yuanzhen Lin <yzhlinscau@163.com>
}
