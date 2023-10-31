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

  weather = dwd_multi(year, month, path = path)
  topo = topography(path = path)
  response = modis_single(year, month, path)

  benchmark = c(weather, topo, response)

  return(benchmark)

}
