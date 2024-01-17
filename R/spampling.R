#' Spampling
#' @description Spatial Sampling
#'
#' @param method string, can be "random" or "clustered"
#' @param size integer, the sample size
#' @param cluster integer, number of cluster centers
#' @param radius integer, sampling distance around cluster centers
#' @param benchmark terra::rast, for feature extraction
#'
#'
#' @details TODO
#'
#' @author Marvin Ludwig
#' @export

spampling = function(method = "random", size = 1000, cluster = 10, radius = 20000, seed = 1, benchmark = NULL){

  set.seed(seed)

  if(method == "random"){
    spample = sample_random(size)
  }
  if(method == "clustered"){
    spample = sample_clustered(size, cluster, radius)
  }

  # TODO check if its a terra::rast
  if(!is.null(benchmark)){
    spample = terra::extract(benchmark, spample,
                             xy = FALSE, ID = FALSE, bind = TRUE)
    spample = st_as_sf(spample)

  }

  return(spample)


}


#' Random Sample
#'
#' @description Random sample without replacement
#' @param size numeric, number of samples to draw
#'
#' @details
#' Can be seen as a probability sample
#'
#' @author Marvin Ludwig
#'


sample_random = function(size){
  s = terra::spatSample(x = raster_template, size = size, as.points = TRUE, na.rm = TRUE, cells = TRUE)
  s = st_as_sf(s)
  return(s)
}



#' Sample Clustered
#' @description Spatially clustered sample without replacement
#'
#' @param size numeric,  number of samples to draw (in total)
#' @param ncluster numeric, number of cluster centers
#' @param radius numeric, buffer size around the cluster centers to draw samples from
#'
#' @details Tweaking `radius` decides the severeness of clustering. Larger `radius` means less severe clusters.
#'     Clusters can overlap, but samples are unique cells.
#' @author Marvin Ludwig


sample_clustered = function(size, ncluster = 5, radius = 25000){


  # create cluster centers with buffer
  cluster_center = terra::spatSample(raster_template, size = ncluster, as.points = TRUE, na.rm = TRUE, cells = TRUE)
  clusters = terra::buffer(cluster_center, width = radius)

  # initialize sample
  all_s = data.frame(cell = numeric(),
                     cluster = numeric())

  for(i in seq(length(clusters))){

    sampling_area = terra::mask(raster_template, clusters[i,])
    sampling_area[sampling_area == 1, ] = i
    names(sampling_area) = "cluster"

    # remove previous samples from sampling area to avoid doublettes
    sampling_area[all_s$cell] = NA

    current_s = terra::spatSample(sampling_area,
                                  size = round(size / ncluster, 0),
                                  cells = TRUE,
                                  as.points = TRUE,
                                  na.rm = TRUE)

    current_s = sf::st_as_sf(current_s)

    # append current sample to all sample
    all_s = rbind(all_s, current_s)
  }

  return(all_s)
}



#' Sample Federal
#'
#' @description
#' Clustered Sample based on states
#'
#'


sample_federal = function(size){



  NULL

}


sample_roads = function(size){


NULL

}








