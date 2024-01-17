#' Download and preprocess monthly weather data from DWD
#' @author Jan Linnenbrink, Marvin Ludwig
#' @param year integer. The year for which the weather data will be downloaded.
#' @param month integer. The month for which the weather data will be downloaded. One of 1:12.
#' @param variable character. The weather parameter of interest.
#' @param path character. The folder where results will be stored.
#' @export


weather <- function(year,
                    month,
                    variable = c("air_temperature_max", "air_temperature_mean", "air_temperature_min",
                                 "drought_index", "evapo_p", "evapo_r", "precipitation",
                                 "soil_moist", "soil_temperature_5cm", "sunshine_duration"),
                    path){


  dwd_stack = lapply(variable, function(x){
    dwd_single(year, month, x, path)
  })
  dwd_stack = do.call(c, dwd_stack)
  return(dwd_stack)
}


#' Download single DWD layer
#' @export



dwd_single <- function(year, month, variable, path) {

  if(!dir.exists(path)) dir.create(path, recursive = TRUE)


  dwdl <- dwd_lookup[dwd_lookup$name == variable,]


  # url based on year, month and variable
  url_base <- "https://opendata.dwd.de/climate_environment/CDC/grids_germany/monthly/"

  url_ending <- dwdl$url_ending

  url_month <- paste0(c(paste0("0", 1:9), 10:12),"_",
                      c("Jan","Feb","Mar","Apr","May","Jun","Jul",
                        "Aug","Sep","Oct","Nov","Dec"))




  ## differentiate between directory structure
  if(dwdl$structure == "all") {
    url_mid <- paste0("/grids_germany_monthly_", dwdl$shortname,"_")
  }
  if(dwdl$structure == "monthly"){
    url_mid <- paste0(url_month[[month]],"/grids_germany_monthly_", dwdl$shortname,"_")
  }

  url <- paste0(url_base, dwdl$name, "/", url_mid, year, stringr::str_pad(month, 2, pad = 0), url_ending)
  # download to raw_folder
  destfile <- paste0(path, "/", basename(url))

  if(!file.exists(destfile)){
    download.file(url, destfile)
    # unzip to raw_folder
    R.utils::gunzip(destfile, skip=TRUE)
  }


  # read as raster and crop + mask with AOI
  weather_rast <- terra::rast(gsub("*.gz", "", destfile))
  terra::crs(weather_rast) <- sp_ref
  return(weather_rast)

}
