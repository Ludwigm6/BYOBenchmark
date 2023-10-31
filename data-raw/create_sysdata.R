# Lookup table for DWD download paths




dwd_lookup = dplyr::tribble(
  ~name, ~shortname, ~scale_factor, ~description, ~structure, ~url_ending,
  "air_temperature_max", "air_temp_max", 10, NA, "monthly", ".asc.gz",
  "air_temperature_mean", "air_temp_mean", 10, NA, "monthly", ".asc.gz",
  "air_temperature_min", "air_temp_min", 10, NA, "monthly", ".asc.gz",
  "drought_index", "drought_index", NA, NA, "monthly", ".asc.gz",
  "evapo_p", "evapo_p", 10, "potential evapotranspiration over grassland", "all", ".asc.gz",
  "evapo_r", "evapo_r", 10, "potential evapotranspiration over gras and sandiger lehm", "all", ".asc.gz",
  "precipitation", "precipitation", NA, "Cumulative Precipitation in mm", "monthly", ".asc.gz",
  "radiation_diffuse", "radiation_diffuse", NA, NA, "all", ".zip",
  "radiation_direct", "radiation_direct", NA, NA, "all", ".zip",
  "radiation_global", "radiation_global", NA, NA, "all", ".zip",
  "soil_moist", "soil_moist", NA, "Prozent pflanzenverfuegbares Wasser", "all", ".asc.gz",
  "soil_temperature_5cm", "soil_temperature_5cm", 10, NA, "all", ".asc.gz",
  "sunshine_duration", "sunshine_duration", NA, NA, "monthly", ".asc.gz")

# Raster in DWD Format
raster_template = terra::rast("data-raw/raster_template.tif")
sp_ref <- "epsg:31467"


germany_outline = sf::st_as_sf(rnaturalearth::countries110[rnaturalearth::countries110$ADMIN == "Germany",]) |>
  dplyr::select(ADMIN) |> sf::st_transform(sp_ref)



usethis::use_data(dwd_lookup, raster_template, sp_ref, germany_outline, internal = TRUE, overwrite = TRUE)
