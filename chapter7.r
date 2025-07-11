# install.packages(c("sf", "spdep", "RColorBrewer", "NipponMap"), repos = "https://cran.r-project.org")
library(sf)
library(spdep)
library(RColorBrewer)
library(NipponMap)

###### Prepare prefecture porigon data in Japan (same as the previous section)
shp   	<- system.file("shapes/jpn.shp", package = "NipponMap")[1]
pref0 	<- read_sf(shp)
pref0b	<- pref0[pref0$name != "Okinawa",]
st_crs(pref0b) <- 4326
pref 	<- st_transform(pref0b,crs=6677)

###### Adjacency matrix
coords	<- st_coordinates(st_centroid(pref))
knn   	<- knearneigh(coords,4)
nb2     <- knn2nb(knn)
w     	<- nb2listw(nb2)

###### Population data
pop   	<- pref$population

###### Moran's I statistic
moran	<- moran.test(pop, listw=w)
moran

###### Geary's C statistic
geary	<- geary.test(pop, listw=w)
geary

###### (Global) Getis G statistic
w_b	<- nb2listw( nb2, style="B" )
G	<- globalG.test( pop, listw = w_b )
w_b
G

###### (Global) Getis G* statistic
w_b2	<- nb2listw(include.self(nb2),style="B")
Gstar	<- globalG.test(pop, listw=w_b2)
Gstar