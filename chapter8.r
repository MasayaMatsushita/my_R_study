# install.packages(c("sf", "spdep", "RColorBrewer", "NipponMap"), repos = "https://cran.r-project.org")
# install.packages("sf", repos = "https://cran.r-project.org")

# rgdalパッケージはさぽーとが修了している (ver4.2以降)
library(sf)
library(spdep)
library(RColorBrewer)
library(NipponMap)

###### Prepare prefecture porigon data in Japan (same as the previous section)
shp   	<- system.file("shapes/jpn.shp", package = "NipponMap")[1]
pref0 	<- read_sf(shp)
pref0b	<- pref0[pref0$name != "Okinawa",]
st_crs(pref0b) <- 4326
pref 	  <- st_transform(pref0b,crs=6677)
coords	<- st_coordinates(st_centroid(pref))
knn   	<- knearneigh(coords,4)
nb2    	<- knn2nb(knn)
w     	<- nb2listw(nb2)
pop   	<- pref$population

########## Local Moran's I statistic ##########
lmoran	<- localmoran(pop, listw=w)
lmoran[1:5,]

##### Plot the local Moran's I
pref$lmoran<- lmoran[, "Ii"]
breaks	<-c( -5, -2, -1, -0.5, 0, 0.5, 1, 2, 5 )
nc   	  <- length(breaks)-1
pal 	  <- rev( brewer.pal(n = nc, name = "RdYlBu" ))
plot(pref[,"lmoran"], pal = pal, breaks=breaks)

##### Plot the statistical significance
pref$lmoran_p<- lmoran[,"Pr(z != E(Ii))"]  # This line might not work for old version of the spdep package
breaks	<-c( 0, 0.01, 0.05, 0.10, 1 )
nc   	  <- length(breaks)-1
pal 	  <- rev( brewer.pal(n = nc, name = "YlOrRd" ))
plot(pref[,"lmoran_p"], pal = pal, breaks=breaks)

##### Moran scatter plot
moran.plot(pop, listw=w, labels=pref$name, pch=20,xlim=c(-1000000,13000000),ylim=c(1000000,8000000))

########## Local Getis/Ord G* statisti c##########
w_b2	 <- nb2listw(include.self(nb2))
lG	   <- localG(pop, listw=w_b2)
lG[1:5]

##### Plot the statistical significance
pref$lG<- lG
breaks <- c(-5, -2.58, -1.96, -1.65, 0, 1.65, 1.96, 2.58, 5)
nc	   <- length(breaks)-1
pal 	 <- rev(brewer.pal(n = nc, name = "RdYlBu"))
plot(pref[,"lG"], pal=pal, breaks=breaks)