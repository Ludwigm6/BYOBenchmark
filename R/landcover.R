#' Copernicus land cover product
#' @description
#' Downloads a spatially continuous land cover (grassland, build up, forests)
#'
#' @param year integer. The year for which the land cover will be downloaded. Currently only 2018 is available.
#' @param class string. One of "GRA", "IMD" or "TCD".
#' @param path character. The folder where results will be stored.
#'
#' @details
#' Land cover is based no the Copernicus land monitoring service with 100m spatial resolution.
#' It was spatially aggregated to a 1km resolution. Hence, land cover classes are represented by % coverage.
#' GRA is grasslands, IMD is impervious build-up, TCD is tree cover density i.e. forests.
#'
#' @author Marvin Ludwig
#' @export


landcover_single = function(year = 2018, product, path){

  url_base <- "https://github.com/Ludwigm6/smb_data/raw/main/data/LANDCOVER/"

  url_ending <- ".tif"

  url = paste0(url_base, "/",
               product, "_", year,
               url_ending)

  destfile <- paste0(path, "/", basename(url))

  if(!file.exists(destfile)){
    download.file(url, destfile)
  }

  lc_rast = terra::rast(destfile)
  names(lc_rast) = product

  return(lc_rast)

}
