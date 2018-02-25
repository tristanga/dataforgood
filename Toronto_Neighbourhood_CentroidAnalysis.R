# Load libraries
library('raster')
library('geosphere')
library('mapview') # incredible interactive map visualization in R

# Get SpatialPolygonsDataFrame object example
toronto <- readOGR("C:/NEIGHBORHOODS_WGS84.shp",
                              layer = "NEIGHBORHOODS_WGS84", GDAL1_integer64_policy = TRUE)
# Plot Polygons
mapview(toronto)

# Get polygons centroids
centroids <- as.data.frame(centroid(toronto))
colnames(centroids) <- c("lon", "lat") 
centroids <- data.frame("ID" = 1:nrow(centroids), centroids)

# Create SpatialPointsDataFrame object
coordinates(centroids) <- c("lon", "lat") 
proj4string(centroids) <- proj4string(polygons) # assign projection

# Plot Polygons + Centroids
mapview(toronto) + mapview(centroids)

# Plot Only Centroids
mapview(centroids)

# Get polygons attribute for each centroid point 
centroids@data <- sp::over(x = centroids, y = polygons, returnList = FALSE)

# Plot centroids interactive with data (click on point to see the information)
mapview(centroids)

# Display coordinates for the last Neighbourhood
centroids@coords[140,] 
