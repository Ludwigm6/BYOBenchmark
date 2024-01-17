#' Get Benchmark
#' @description Downloads a stack of standardized raster
#'
#' @param year integer, one of 2020, 2021, 2022
#' @param month integer, one of 1 to 12
#' @param path string, where to store downloaded data
#'
#' @author Marvin Ludwig
#' @export
#'
#'



get_smb = function(year, month, path){

  weather = weather(year, month, path = path)
  topo = topography(path = path)
  grassland = landcover_single(year = 2018, product = "GRA", path = path)
  forest = landcover_single(year = 2018, product = "TCD", path = path)
  urban = landcover_single(year = 2018, product = "IMD", path = path)
  response = modis_single(year, month, product = "MODISNDVI", path)

  benchmark = c(weather, topo, grassland, forest, urban, response)

  return(benchmark)

}
