###### capa resultados.org

df_resultadosorg <- st_read("Municipios/Municipios.shp")
laboral_radios <- st_read("Censo 2010 - Radios - Todos/Censo 2010 - Radios - Todos.shp")
nbi <- st_read("NBI/Indicadores de hogares. Radios, 2010.shp")
educacion <- st_read("NIVEL EDUCATIVO RADIOS/Indicadores de personas. Radios, 2010.shp")

nbi<- nbi %>% 
  filter(IDPROV == 14)
educacion<- educacion %>% 
  filter(IDPROV == 14)
laboral_radios<- laboral_radios %>% 
  filter(IDPROV == 14)

nbi <- nbi %>% 
  select(-c("IDPROV",
            "PROV",
            "IDDPTO",
            "DPTO",
            "REDCODE_1",
            "RADIOS_POB",
            "RADIOS_HOG",
            "RADIOS_LAT",
            "RADIOS_LON",
            "RADIOS_SUP",
            "geometry")) %>% 
  st_set_geometry(NULL)

nbi_relativo <- mutate(nbi, 
                       )

educacion <- educacion %>% 
  select(-c("IDPROV",
            "PROV",
            "IDDPTO",
            "DPTO",
            "REDCODE_1",
            "RADIOS_POB",
            "RADIOS_HOG",
            "RADIOS_LAT",
            "RADIOS_LON",
            "RADIOS_SUP",
            "geometry")) %>% 
  st_set_geometry(NULL)
laboral_radios <- laboral_radios %>% 
  select(-c("IDPROV",
            "PROV",
            "IDDPTO",
            "DPTO",
            "REDCODE_1",
            "RADIOS_POB",
            "RADIOS_HOG",
            "RADIOS_LAT",
            "RADIOS_LON",
            "RADIOS_SUP",
            "geometry")) %>% 
  st_set_geometry(NULL)
laboral_radios$REDCODE <- as.character(laboral_radios$REDCODE)

superdf <- left_join(nbi, laboral_radios, by = "REDCODE")
superdf <- left_join(superdf, educacion, by = "REDCODE")

write.csv(educacion, "NIVEL EDUCATIVO RADIOS/educacion_radio.csv")
write.csv(laboral_radios,"laboral/laboral_radio.csv")
write.csv(nbi,"NBI/nbi_radio.csv")
write.csv(superdf, "laboral_nbi_radios.csv")
write.csv(superdf, "laboral_nbi_educacion_radios.csv")
