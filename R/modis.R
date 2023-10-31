#' Download MODIS NDVI
#'
#' @param year integer. The year for which the MODIS NDVI will be downloaded. One of 2020,2021 or 2022.
#' @param month integer. The month for which the MODIS NDVI will be downloaded. One of 1:12.
#' @param path character. The folder where results will be stored.
#' @author Marvin Ludwig
#' @export


modis_single = function(year, month, path){

  url_base <- "https://github.com/Ludwigm6/smb_data/raw/main/"

  url_ending <- ".tif"

  url = paste0(url_base, year, "/",
               "NDVI_", year, "_", stringr::str_pad(month, 2, pad = 0),
               url_ending)

  destfile <- paste0(path, "/", basename(url))

  if(!file.exists(destfile)){
    download.file(url, destfile)
  }

  modis_rast = terra::rast(destfile)
  return(modis_rast)

}
