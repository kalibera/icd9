% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ranges.R
\name{icd9Children}
\alias{icd9Children}
\alias{icd9ChildrenDecimal}
\alias{icd9ChildrenShort}
\title{Expand ICD-9 codes to all possible sub-codes}
\usage{
icd9Children(icd9, isShort = icd9GuessIsShort(icd9), onlyReal = TRUE,
  onlyBillable = FALSE)

icd9ChildrenShort(icd9Short, onlyReal = TRUE, onlyBillable = FALSE)

icd9ChildrenDecimal(icd9Decimal, onlyReal = TRUE, onlyBillable = FALSE)
}
\arguments{
\item{icd9}{is
a character vector or factor of ICD-9 codes. If fewer than five characters
is given in a code, then the digits are greedily assigned to hundreds, then
tens, then units, before the decimal parts. E.g. "10" becomes "010", not
"0010".}

\item{isShort}{single logical value which determines whether the ICD-9 code
provided is in short (TRUE) or decimal (FALSE) form. Where reasonable, this
is guessed from the input data.}

\item{onlyReal}{single logical value, if TRUE, will limit the search to those
codes which appear in the master list, not just syntactically valid codes.
Since nearly valid, out-dated or new codes may be missed, not limiting to
'real' values will be useful. Ultimately, there will need to be annual (and
all-time) master lists of codes and the ability to test against a given
master list given the year of the ICD-9 coding.}

\item{onlyBillable}{single logical value, if \code{TRUE}, describes the input
data, stating that it only contains billable codes. Usually, the function
will try to guess this, but if you know in advance what they should be, the
functions can optionally warn if this is incorrect, and save some
computation time. The billable codes are derived from the CMS list. The
most recent version is used by default.}

\item{icd9Short}{is a character vector of ICD-9 codes. If fewer than
five characters is given in a code, then the digits are greedily assigned
to hundreds, then tens, then units, before the decimal parts. E.g. "10"
becomes "010", not "0010"}

\item{icd9Decimal}{character vector of ICD-9 codes. If fewer than five
characters is given in a code, then the digits are greedily assigned to
hundreds, then tens, then units, before the decimal parts. E.g. "10"
becomes "010", not "0010"}
}
\examples{
library(magrittr)
icd9ChildrenShort("10201", FALSE) # no children other than self
icd9Children("0032", FALSE) # guess it was a short, not decimal code
icd9ChildrenShort("10201", TRUE) # empty because 102.01 is not meaningful
icd9ChildrenShort("003", TRUE) \%>\% icd9ExplainShort(doCondense = FALSE)
icd9ChildrenDecimal("100.0")
icd9ChildrenDecimal("100.00")
icd9ChildrenDecimal("2.34")
}
\seealso{
Other ICD-9 ranges: \code{\link{icd9Condense}},
  \code{\link{icd9ExpandMinor}},
  \code{\link{icd9ExpandRange}}
}
\keyword{manip}

