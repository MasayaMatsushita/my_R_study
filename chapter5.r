# 例：Tokyo (RIKEN) を選択する場合
# install.packages(c("sf", "NipponMap", "RColorBrewer"), repos = "https://cran.r-project.org")

library(sf)
library(NipponMap)
library(RColorBrewer)

shp <- system.file("shapes/jpn.shp", package="NipponMap")[1]
# print(shp)

pref <- read_sf(shp)
print(pref)


# WGS84（緯度経度）の CRS を設定
st_crs(pref) <- 4326
print(st_crs(pref))


pref_tr <- st_transform(pref, crs=6677)
print(st_coordinates(st_centroid(pref_tr)))

#5.7

pref2 <- pref[pref$name != "Okinawa",]
# Mac用のプロットウィンドウを開く
quartz()

# 図5.1
# plot(pref2[, "population"])

# # ウィンドウが閉じるのを防ぐために少し待機
# Sys.sleep(30)  # 10秒間ウィンドウを保持

# 図5.3
# nc <- 7
# pal <- brewer.pal(nc, "RdYlGn")
# plot(pref2[, "population"], pal=pal, axes=TRUE, nbreaks=nc)
# Sys.sleep(30)  # 10秒間ウィンドウを保持

# 図5.4
breaks <- c(0, 1000000, 2000000, 3000000, 5000000, 8000000, max(pref$population))
nc <- length(breaks)-1
pal <- rev(brewer.pal(nc, "RdYlGn"))

png("figure5-4.png", width=800, height=600)
plot(pref2[, "population"], pal=pal, axes=TRUE,
  xlim=c(130.5,145), ylim=c(31,46),
  breaks=breaks, key.pos=1, key.length=0.8)
# Sys.sleep(30)  # 10秒間ウィンドウを保持
dev.off()