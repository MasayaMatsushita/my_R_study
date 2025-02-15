# install.packages(c("sf","NipponMap","spdep"),repos = "https://cran.r-project.org")
library(sf); library(NipponMap); library(spdep);

shp <- system.file("shapes/jpn.shp", package ="NipponMap")[1]
pref0 <- read_sf(shp)
pref0b <- pref0[pref0$name != "Okinawa", ]
st_crs(pref0b) <- 4326

pref <- st_transform(pref0b, crs=6677) #平面直角座標系第9系のEPSGコード指定

# nb1 <- poly2nb(pref)
# print(nb1)

# quartz()

# 図6.5
# png("figure6-5.png", width=800, height=600)
# coords <- st_coordinates(st_centroid(pref))
# plot(st_geometry(pref), col="White", border="grey")
# plot(nb1, coords, add=TRUE, col="red", cex=0.01, lwd=1.5)
# dev.off()

# Sys.sleep(30)  # 30秒間ウィンドウを保持

# 図6.6
# png("figure6-6.png", width=800, height=600)
# coords <- st_coordinates(st_centroid(pref))
# knn <- knearneigh(coords, 4)
# nb2 <- knn2nb(knn)
# plot(st_geometry(pref), border="grey")
# plot(nb2, coords, add=TRUE, col="red", cex=0.01, lwd=1.5)
# dev.off()

# 図6.7
# png("figure6-7.png", width=800, height=600)
# coords <- st_coordinates(st_centroid(pref))
# knn <- knearneigh(coords, 8)
# nb3 <- knn2nb(knn)
# plot(st_geometry(pref), border="grey")
# plot(nb3, coords, add=TRUE, col="red", cex=0.01, lwd=1.5)
# dev.off()

# 図6.8
# png("figure6-8.png", width=800, height=600)
# coords <- st_coordinates(st_centroid(pref))
# nb4 <- dnearneigh(coords, d1=0, d2 = 150000)
# plot(st_geometry(pref), border="grey")
# plot(nb4, coords, add=TRUE, col="red", cex=0.01, lwd=1.5)
# dev.off()
