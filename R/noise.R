#' Random Noise Raster
#' @description Generates a raster layer based on a distribution function
#'
#'
#'
#' @param fun a distribution function, see Distribution
#' @param seed numeric, RNG seed
#'
#'
#' @author Marvin Ludwig
#'
#' @export
#'
#'




noise = function(fun = runif, seed = 1){

  #t = terra::rast("data-raw/raster_template.tif")
  set.seed(seed)
  n = terra::init(x = raster_template, fun = fun)
  n = round(n, 2)
  n = mask(n, raster_template)
  return(n)
}


