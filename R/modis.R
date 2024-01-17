#' MODIS product
#' @description
#' Downloads a spatially continuous MODIS product (NDVI or LST) that is used as a response variable.
#'
#' @param year integer. The year for which the MODIS NDVI will be downloaded. One of 2020,2021 or 2022.
#' @param month integer. The month for which the MODIS NDVI will be downloaded. One of 1:12.
#' @param product string. One of "MODISNDVI" or "MODISLST"
#' @param path character. The folder where results will be stored.
#'
#' @details
#' The products are preprocessed using Google Earth Engine and stored in a GitHub repository. See...
#'
#' @author Marvin Ludwig
#' @export


modis_single = function(year, month, product, path){

  url_base <- "https://github.com/Ludwigm6/smb_data/raw/main/data"

  url_ending <- ".tif"

  url = paste0(url_base, "/",
               product, "/", product, "_", year, "_", stringr::str_pad(month, 2, pad = 0),
               url_ending)

  destfile <- paste0(path, "/", basename(url))

  if(!file.exists(destfile)){
    download.file(url, destfile)
  }

  modis_rast = terra::rast(destfile)
  return(modis_rast)

}
