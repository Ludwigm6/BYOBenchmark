% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/modis.R
\name{modis_single}
\alias{modis_single}
\title{MODIS product}
\usage{
modis_single(year, month, product, path)
}
\arguments{
\item{year}{integer. The year for which the MODIS NDVI will be downloaded. One of 2020,2021 or 2022.}

\item{month}{integer. The month for which the MODIS NDVI will be downloaded. One of 1:12.}

\item{product}{string. One of "MODISNDVI" or "MODISLST"}

\item{path}{character. The folder where results will be stored.}
}
\description{
Downloads a spatially continuous MODIS product (NDVI or LST) that is used as a response variable.
}
\details{
The products are preprocessed using Google Earth Engine and stored in a GitHub repository. See...
}
\author{
Marvin Ludwig
}
