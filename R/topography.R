#' Download and project topography data
#' @param ... see geodata::elevation_30s
#' @author Marvin Ludwig
#' @export
#'
#'


topography = function(...){

  elev = geodata::elevation_30s(country = "Germany", ...)
  names(elev) = "elev"
  elev = terra::project(elev, raster_template)

  elev = c(elev, terra::terrain(elev, c("slope", "aspect", "TPI", "TRI")))

  elev$northness <- cos(elev$aspect * pi / 180)
  elev$eastness <- sin(elev$aspect * pi / 180)

  return(elev)

}
