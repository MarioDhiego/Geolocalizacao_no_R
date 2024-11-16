

# Pacotes ----------------------------------------------------------------------
library(tidyverse)
library(tidygeocoder)
library(leaflet)
library(googleway)
library(htmltools)
library(htmlwidgets)
library(sf)
library(rjson)
# ------------------------------------------------------------------------------


# Endereços --------------------------------------------------------------------

Enderecos1 <- tidygeocoder::geo(
  street = "Av Tapanã , 813",
  city = "Belém",
  state = "PA",
  country = "Brazil"
)

Enderecos2 <- tidygeocoder::geo(
  street = "Av Tapanã , 813",
  city = "Belém",
  state = "PA",
  country = "Brazil"
)



# ------------------------------------------------------------------------------

# Mapa -------------------------------------------------------------------------
Enderecos1 %>% 
  leaflet::leaflet() %>%
  leaflet::addTiles() %>% 
  leaflet::addMarkers(
    lng = Enderecos$long,
    lat = Enderecos$lat,
    popup="Condomínio Alegro Montenegro") 



# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
endereco_origem <- "Av Paulista, 302, Sao Paulo, SP, Brazil"
endereco_destino <- "Estadio Morumbi, Sao Paulo, SP, Brazil"

tabela <- dplyr::bind_rows(endereco_origem, endereco_destino)

origem <- tidygeocoder::geo(address = endereco_origem)
destino <- tidygeocoder::geo(address = endereco_destino)

url <- glue::glue("http://router.project-osrm.org/route/v1/driving/{origem$long},{origem$lat};{destino$long},{destino$lat}")


rota <- rjson::fromJSON(file = url)

tabela_rota <- googleway::decode_pl(rota$routes[[1]]$geometry)

tabela_rota %>%
  leaflet() %>%
  addTiles() %>%
  addPolylines(
    lng = ~lon,
    lat = ~lat) %>%
  addMarkers(
    data = tabela,
    lng = tabela$lon ,
    lat = tabela$lat
  )
# ------------------------------------------------------------------------------


# ------------------------------------------------------------------------------
# Para Uma Base de Endereços
for(i in 1:nrow(SUA_BASE_DE_DADOS)){
  tabela <- tidygeocoder::geo(
    address = "Av Paulista, 302, Sao Paulo, SP, Brazil"
  )
  tabela_completa <- rbind(tabela, tabela_completa)
  Sys.sleep(1)
}



# ------------------------------------------------------------------------------









