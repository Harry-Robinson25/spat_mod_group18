DATAFILE <- '~/code/spat_mod_group18/data/HadCRUT.median.nc'

install.packages('tidyverse')
install.packages('ncdf4')
install.packages('raster')
install.packages('rasterVis')
install.packages('maptools')
install.packages('maps')

download.file(
  url='https://crudata.uea.ac.uk/cru/data/temperature/HadCRUT.4.6.0.0.median.nc',
  destfile=DATAFILE,
)


