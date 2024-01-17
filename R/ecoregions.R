#' WWF Ecoregions
#' @description
#' Downloads WWF ecoregions as categorial predictor.
#'
#' @param path character. The folder where results will be stored.
#'
#'
#' @author Marvin Ludwig
#' @export


landcover_single = function(path){

  url_base <- "https://github.com/Ludwigm6/smb_data/raw/main/data/static/"

  url_ending <- ".tif"

  url = paste0(url_base, "/",
               "ecoregions",
               url_ending)

  destfile <- paste0(path, "/", basename(url))

  if(!file.exists(destfile)){
    download.file(url, destfile)
  }

  modis_rast = terra::rast(destfile)
  return(modis_rast)

}
