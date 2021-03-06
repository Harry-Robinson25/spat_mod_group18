
library(raster)
library(ncdf4)
library(rasterVis)
library(maptools)
library(maps)
CLIMATE = stack("data/HadCRUT.median.nc")
CLIMATE
CLIMATE[[1]]
image(CLIMATE[[1]])
levelplot(CLIMATE[[1]])
mapTheme = rasterTheme(region=rainbow(256))
levelplot(CLIMATE[[1]],par.settings=mapTheme)
summary(CLIMATE[[1]])
world.outlines=map("world",plot=FALSE)
world.outlines.sp= map2SpatialLines(world.outlines,proj4string= CRS("+proj=longlat"))
xx1 = levelplot(CLIMATE[[1]],par.settings=mapTheme)
xx1 + layer(sp.lines(world.outlines.sp,col="black",lwd=0.5))
