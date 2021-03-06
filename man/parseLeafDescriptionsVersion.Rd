% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/parse.R
\name{parseLeafDescriptionsVersion}
\alias{parseLeafDescriptionsVersion}
\title{read the ICD-9-CM description data as provided by the Center for
  Medicaid Services.}
\usage{
parseLeafDescriptionsVersion(version = getLatestBillableVersion(),
  save = FALSE, fromWeb = FALSE, verbose = FALSE)
}
\arguments{
\item{save}{logical whether to attempt to re-save source files in inst}

\item{icd9path}{path of the source data which is in /extddata in the
installed package, but would be in inst/extdata in development tree.}

\item{path}{Absolute path in which to save parsed data}
}
\value{
invisibly return the result
}
\description{
ICD9-CM data unfortunately has no comma separation, so have to
  pre-process. Note that this canonical data doesn't specify non-diagnostic
  higher-level codes, just the specific diagnostic 'child' codes.

  The file can be pulled from the zip files on the CMS web site or from
  within the package. Pulled data can be saved to the package development
  tree.
}
\keyword{internal}

