library(leaflet)
library(readxl)
library(sf)
#library(htmlwidgets)#export to HTML code
# import fichier bilan metadonnée
bilanko <- read_excel("bilan_MD.xlsx")
polygones_wkt <- bilanko$Zone_etude

# Convertir la colonne polygone_wkt en objets spatiaux
polygones_sf <- st_as_sfc(polygones_wkt)

# Calculer les centroïdes des polygones
centroïdes <- st_centroid(polygones_sf)
coordinates <- st_coordinates(centroïdes)
bilanko$long<-longitude <- coordinates[, "X"]
bilanko$lat<-latitude <- coordinates[, "Y"]
# longitude<-as.numeric(bilanko$long)
# latitude <-as.numeric(bilanko$lat)

data_coraux<-subset(bilanko, bilanko$Composante=="CORAUX",)
data_invertebres<-subset(bilanko, bilanko$Composante=="INVERTEBRES",)
data_megafaune<-subset(bilanko, bilanko$Composante=="MEGAFAUNE",)
data_microorganismes<-subset(bilanko, bilanko$Composante=="MICROORGANISMES",)
data_peche<-subset(bilanko, bilanko$Composante=="PECHE",)
data_poisson<-subset(bilanko, bilanko$Composante=="POISSONS",)
data_transverse<-subset(bilanko, bilanko$Composante=="TRANSVERSE",)

img_poisson="http://localhost/wordpress/wp-content/uploads/2024/02/img_poisons.jpg"
img_peche="http://localhost/wordpress/wp-content/uploads/2024/02/img_peche.jpg"
img_micro="http://localhost/wordpress/wp-content/uploads/2024/02/img_micro.jpg"
img_megafaune="http://localhost/wordpress/wp-content/uploads/2024/02/img_megafaune.jpg"
img_invertebre="http://localhost/wordpress/wp-content/uploads/2024/02/img_invertebre.jpg"
img_coraux="http://localhost/wordpress/wp-content/uploads/2024/02/img_coraux.jpg"
img_transveral="http://localhost/wordpress/wp-content/uploads/2024/02/Img_transver.jpg"

#my_map <-leaflet() %>%#ajouter pour export Html
leaflet() %>%
  addTiles(group = "IHSM") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
  setView(lng = 46.8691, lat = -18.7669, zoom = 6) %>%
  
addCircleMarkers( data = data_coraux,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group= "CORAUX",color = "#F7E700",
                  clusterOptions = markerClusterOptions(autoPan = TRUE),
                  popup = paste(
                    "<div style='display: flex;'>",
                    "<div style='flex: 1;'>",
                    paste0("<img src = ", img_coraux, "' width='90%' height='100%'>"),
                    "</div>",
                    "<div style='flex: 1;'>",
                    "<strong>Nom et prenom:</strong><br>", data_coraux$Nom,"<br>",
                    "<strong>Thematique:</strong><br>", data_coraux$Thematique,"<br>",
                    "<a href=",data_coraux$Lien,">","Voir tout","</a>",
                    "</div>",
                    "</div>"
                  )) %>%

addCircleMarkers( data = data_invertebres,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="INVERTEBRES",color = '#FFA600',
                  clusterOptions = markerClusterOptions(autoPan = TRUE),
                   popup = paste(
                    "<div style='display: flex;'>",
                    "<div style='flex: 1;'>",
                    paste0("<img src = ", img_invertebre, "' width='90%' height='100%'>"),
                    "</div>",
                    "<div style='flex: 1;'>",
                    "<strong>Nom et prenom:</strong><br>", data_invertebres$Nom,"<br>",
                    "<strong>Thematique:</strong><br>", data_invertebres$Thematique,"<br>",
                    "<a href=",data_invertebres$Lien,">","Voir tout","</a>",
                    "</div>",
                    "</div>"
                  )) %>%
addCircleMarkers( data = data_megafaune,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="MEGAFAUNE",color = '#000080',
              clusterOptions = markerClusterOptions(autoPan = TRUE),
              popup = paste(
              "<div style='display: flex;'>",
              "<div style='flex: 1;'>",
              paste0("<img src = ", img_megafaune, "' width='90%' height='100%'>"),
              "</div>",
              "<div style='flex: 1;'>",
              "<strong>Nom et prenom:</strong><br>", data_megafaune$Nom,"<br>",
              "<strong>Thematique:</strong><br>", data_megafaune$Thematique,"<br>",
              "<a href=",data_megafaune$Lien,">","Voir tout","</a>",
              "</div>",
              "</div>"
            )) %>%
addCircleMarkers( data = data_microorganismes,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="MICROORGANISMES",color = '#1874CD',
              clusterOptions = markerClusterOptions(autoPan = TRUE),
              popup = paste(
              "<div style='display: flex;'>",
              "<div style='flex: 1;'>",
              paste0("<img src = ", img_micro, "' width='90%' height='100%'>"),
              "</div>",
              "<div style='flex: 1;'>",
              "<strong>Nom et prenom:</strong><br>", data_microorganismes$Nom,"<br>",
              "<strong>Thematique:</strong><br>", data_microorganismes$Thematique,"<br>",
              "<a href=",data_microorganismes$Lien,">","Voir tout","</a>",
              "</div>",
              "</div>"
            )) %>%
addCircleMarkers( data = data_peche,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="PECHE",color = '#0000CD',
            clusterOptions = markerClusterOptions(autoPan = TRUE),
            popup = paste(
              "<div style='display: flex;'>",
              "<div style='flex: 1;'>",
              paste0("<img src = ", img_peche, "' width='90%' height='100%'>"),
              "</div>",
              "<div style='flex: 1;'>",
              "<strong>Nom et prenom:</strong><br>", data_peche$Nom,"<br>",
              "<strong>Thematique:</strong><br>", data_peche$Thematique,"<br>",
              "<a href=",data_peche$Lien,">","Voir tout","</a>",
              "</div>",
              "</div>"
            )) %>%
addCircleMarkers( data = data_poisson,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="POISSONS",color = '#0000FF',
            options = markerOptions(autoPan = TRUE),
            popup = paste(
              "<div style='display: flex;'>",
              "<div style='flex: 1;'>",
              paste0("<img src = ", img_poisson, "' width='90%' height='100%'>"),
              "</div>",
              "<div style='flex: 1;'>",
              "<strong>Nom et prenom:</strong><br>", data_poisson$Nom,"<br>",
              "<strong>Thematique:</strong><br>", data_poisson$Thematique,"<br>",
              "<a href=",data_poisson$Lien,">","Voir tout","</a>",
              "</div>",
              "</div>"
            )) %>%

addCircleMarkers( data = data_transverse,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="TRANSVERSE",color = '#00F5FF',
            options = markerOptions(autoPan = TRUE),
            popup = paste(
              "<div style='display: flex;'>",
              "<div style='flex: 1;'>",
              paste0("<img src = ", img_transveral, "' width='90%' height='100%'>"),
              "</div>",
              "<div style='flex: 1;'>",
              "<strong>Nom et prenom:</strong><br>", data_transverse$Nom,"<br>",
              "<strong>Thematique:</strong><br>", data_transverse$Thematique,"<br>",
              "<a href=",data_transverse$Lien,">","Voir tout","</a>",
              "</div>",
              "</div>"
            )) %>%

  addLayersControl(#baseGroups = c("IHSM", "Esri World Imagery"), 
    overlayGroups = c("POISSONS","PECHE","CORAUX","INVERTEBRES","MICROORGANISMES","MEGAFAUNE","TRANSVERSE"),
    options = layersControlOptions(collapsed = FALSE)) %>% 
  
  addMiniMap( # add mini map
    tiles = providers$OpenStreetMap,
    width = 150,
    height = 150,
    toggleDisplay = TRUE
  ) %>%
  addScaleBar(position = "bottomleft")
################################################################################
#(my_map, file="my_map.html")

