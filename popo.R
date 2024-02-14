library(leaflet)
library(readxl)
#library(htmlwidgets)#export to HTML code
# import fichier bilan metadonnée
bilanko <- read_excel("bilan_MD.xlsx")
longitude<-as.numeric(bilanko$long)
latitude <-as.numeric(bilanko$lat)

data_coraux<-subset(bilanko, bilanko$Composante=="CORAUX",)
data_invertebres<-subset(bilanko, bilanko$Composante=="INVERTEBRES",)
data_megafaune<-subset(bilanko, bilanko$Composante=="MEGAFAUNE",)
data_microorganismes<-subset(bilanko, bilanko$Composante=="MICROORGANISMES",)
data_peche<-subset(bilanko, bilanko$Composante=="PECHE",)
data_poisson<-subset(bilanko, bilanko$Composante=="POISSONS",)
data_transverse<-subset(bilanko, bilanko$Composante=="TRANSVERSE",)

file = "http://bit.ly/1TVwRiR"
img="https://fr.wikipedia.org/wiki/Institut_halieutique_et_des_sciences_marines#/media/Fichier:Logo_ihsm.png"

iconeko=makeAwesomeIcon(
  icon = 'coffee',
  library = 'ion',
  iconColor = '#000000',
  markerColor = '#F5F',
  squareMarker = TRUE
)

#my_map <-leaflet() %>%#ajouter pour export Html
leaflet() %>%
  addTiles(group = "IHSM") %>%
  addProviderTiles(providers$Esri.WorldImagery, group = "Esri World Imagery") %>%
  setView(lng = 46.8691, lat = -18.7669, zoom = 6) %>%
  
  addMarkers( data = data_coraux,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="CORAUX",
              popup=paste("<strong>Nom:</strong><br>", data_coraux$Nom,"<br>",
                            "<strong>Thematique:</strong><br>", data_coraux$Thematique,"<br>",
                            paste0("<img src = ", file, "' width='100px' height='100%'>"),"<br>",
                            
                            "<strong>Lien:</strong><br>", "<a href=",data_coraux$Lien,">","Voir tout","</a>"),
                      popupOptions = popupOptions(Width = "200px")) %>%
  
  addAwesomeMarkers( data = data_invertebres,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="INVERTEBRES",icon = iconeko,
                     popup=paste("<strong>Nom et prenom:</strong><br>", data_invertebres$Nom,"<br>",
                                 "<strong>Thematique:</strong><br>", data_invertebres$Thematique,"<br>",
                                 paste0("<img src = ", file, "' width='100px' height='100%'>"),"<br>",
                                 
                                 "<strong>Lien:</strong><br>", "<a href=",data_invertebres$Lien,">","Voir tout","</a>"),
                     popupOptions = popupOptions(Width = "auto")) %>%
  addMarkers( data = data_megafaune,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="MEGAFAUNE",
              popup = paste(
                "<div style='display: flex;'>",
                "<div style='flex: 1;'>",
                paste0("<img src = ", file, "' width='90%' height='100%'>"),
                "</div>",
                "<div style='flex: 1;'>",
                "<strong>Nom et prenom:</strong><br>", data_megafaune$Nom,"<br>",
                "<strong>Thematique:</strong><br>", data_megafaune$Thematique,"<br>",
                "<a href=",data_megafaune$Lien,">","Voir tout","</a>",
                "</div>",
                "</div>"
              )) %>%
  addMarkers( data = data_microorganismes,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="MICROORGANISMES",
              popup = paste(
                "<div style='display: flex;'>",
                "<div style='flex: 1;'>",
                paste0("<img src = ", file, "' width='90%' height='100%'>"),
                "</div>",
                "<div style='flex: 1;'>",
                "<strong>Nom et prenom:</strong><br>", data_megafaune$Nom,"<br>",
                "<strong>Thematique:</strong><br>", data_megafaune$Thematique,"<br>",
                "<a href=",data_megafaune$Lien,">","Voir tout","</a>",
                "</div>",
                "</div>"
              )) %>%
  addMarkers( data = data_peche,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="PECHE",
              options = markerOptions(autoPan = TRUE),
              popup = paste(
                "<div style='display: flex;'>",
                "<div style='flex: 1;'>",
                paste0("<img src = ", file, "' width='90%' height='100%'>"),
                "</div>",
                "<div style='flex: 1;'>",
                "<strong>Nom et prenom:</strong><br>", data_peche$Nom,"<br>",
                "<strong>Thematique:</strong><br>", data_peche$Thematique,"<br>",
                "<a href=",data_peche$Lien,">","Voir tout","</a>",
                "</div>",
                "</div>"
              )) %>%
  addMarkers( data = data_poisson,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="POISSONS",
              options = markerOptions(autoPan = TRUE),
              popup = paste(
                "<div style='display: flex;'>",
                "<div style='flex: 1;'>",
                paste0("<img src = ", file, "' width='90%' height='100%'>"),
                "</div>",
                "<div style='flex: 1;'>",
                "<strong>Nom et prenom:</strong><br>", data_poisson$Nom,"<br>",
                "<strong>Thematique:</strong><br>", data_poisson$Thematique,"<br>",
                "<a href=",data_poisson$Lien,">","Voir tout","</a>",
                "</div>",
                "</div>"
              )) %>%
  
  addMarkers( data = data_transverse,lng = ~ as.numeric(long),lat = ~ as.numeric(lat),group="TRANSVERSE",
              options = markerOptions(autoPan = TRUE),
              popup = paste(
                "<div style='display: flex;'>",
                "<div style='flex: 1;'>",
                paste0("<img src = ", file, "' width='90%' height='100%'>"),
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

