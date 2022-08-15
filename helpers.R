# # Filtro datos
# filtroDatos = function(datos, campo, filtro) {
#   if ({{filtro}} == 'TODAS') {{datos}} else
#   {{datos}} %>% filter({{datos}} == {{filtro}})
# }

# Preparar los datos
data = function(.datos, ...) {
  .datos %>% group_by(...) %>%
    summarise(MONTO = sum(`MONTO AUTORIZADO`),
              AUTORIZACIONES = n_distinct(INTEGRALIDAD),
              `MM AUTORIZACION` = MONTO / AUTORIZACIONES,
              USUARIOS = n_distinct(CDPERSON),
              `MM USUARIO` = MONTO / USUARIOS,
              .groups = "drop"
    )
}